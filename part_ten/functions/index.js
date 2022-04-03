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

// Create a function named addUserLocation 
exports.addUserLocation = functions.runWith({ 
    timeoutSeconds: 60,  
    memory: "256MB"
}).https.onCall(async (data, context) => {
   
    try {
       // Fetch correct user document with user id.
        let snapshot = await db.collection('users').doc((context.auth.uid)).get();
        // Check if field value for location is null
        // functions.logger.log(snapshot['_fieldsProto']['userLocation']["valueType"] === "nullValue");
        let locationValueType = snapshot['_fieldsProto']['userLocation']["valueType"];
        if (locationValueType == 'nullValue') {
            await db.collection('users').doc((context.auth.uid)).set({ 'userLocation': data.userLocation }, { merge: true });
            functions.logger.log(`User location added    ${data.userLocation}`);
                return data.userLocation;

        }
        else {
            functions.logger.log(`User location not changed`);

        }

    }
    catch (e) {
        functions.logger.log(e);
        throw new functions.https.HttpsError('internal', e);
    }
    return data.userLocation;

});


exports.getNearbyTemples = functions.https.onCall(async (data, _) => {
    
    try {
        // Notify function's been called
        functions.logger.log("Add nearby temples function was called");
        // Create array of temple objects.
        let temples = data.templeList.map((temple) => {
            return {
                'place_id': temple['place_id'],
                'address': temple['vicinity'] ? temple['vicinity'] : 'Not Available',
                'name': temple['name'] ? temple['name'] : 'Not Available',
                'latLng': {
                    'lat': temple.hasOwnProperty('geometry') ? temple['geometry']['location']['lat'] : 'Not Available', 'lon': temple.hasOwnProperty('geometry') ? temple['geometry']['location']['lng'] : 'Not Available',
                    'dateAdded': admin.firestore.Timestamp.now()
                },
                'imageRef': data.imageRef
            }
        }

        );

        // save the temples array to temples collection as one document named temples 
        await db.collection('temples').add({ temples: temples });

    } catch (e) {
        // if error return errormsg
        return { 'Error Msg': e };
    }
    // If everything's fine return temples array.
    return temples;
});