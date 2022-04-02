// Import modiules
const functions = require("firebase-functions"),
    admin = require('firebase-admin');

// always initialize admin 
admin.initializeApp();

// create a const to represent firestore
const db = admin.firestore();


// Create a new background trigger function 
exports.addTimeStampToUser = functions.runWith({
    timeoutSeconds: 240,  // Give timeout 
    memory: "512MB" // memory allotment 
}).firestore.document('users/{userId}').onCreate(async (_, context) => {
    // Get current timestamp from server
    let curTimeStamp = admin.firestore.Timestamp.now();
    // Print current timestamp on server
    functions.logger.log(`curTimeStamp ${curTimeStamp.seconds}`);

    try {
        // add the new value to new users document i
        await db.collection('users').doc(context.params.userId).set({ 'registeredAt': curTimeStamp, 'favTempleList': [], 'favShopsList': [], 'favEvents': [] }, { merge: true });
        // if its done print in logger
        functions.logger.log(`The current timestamp added to users collection:  ${curTimeStamp.seconds}`);
        // always return something to end the function execution
        return { 'status': 200 };
    } catch (e) {
        // Print error incase of errors
        functions.logger.log(`Something went wrong could not add timestamp to users collectoin ${curTimeStamp.seconds}`);
        // return status 400 for error
        return { 'status': 400 };
    }
});
