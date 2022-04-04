import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:temple/globals/settings/router/utils/router_utils.dart';

// Make an enum to togggle progrss indicator
enum ProcessingState {
  done,
  waiting,
}

class AuthStateProvider with ChangeNotifier {
  FirebaseAuth authInstance = FirebaseAuth.instance;
  ProcessingState _processingState = ProcessingState.done;

  // getter
  ProcessingState get processingState => _processingState;

  void setPrcState(ProcessingState prcsState) {
    _processingState = prcsState;
    notifyListeners();
  }

  //  create function to handle popups
  SnackBar msgPopUp(msg) {
    return SnackBar(
        content: Text(
      msg,
      textAlign: TextAlign.center,
    ));
  }

  AlertDialog errorDialog(BuildContext context, String errMsg) {
    return AlertDialog(
      title: Text("Error",
          style: TextStyle(
            //text color will be red
            color: Theme.of(context).colorScheme.error,
          )),
      content: Text(errMsg,
          style: TextStyle(
            //text color will be red
            color: Theme.of(context).colorScheme.error,
          )),
      actions: [
        TextButton(
          // On button click remove the dialog box
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    );
  }

  // Our Function will take email,password, username and buildcontext
  void register(String email, String password, String username,
      BuildContext context) async {
    // Start loading progress indicator once submit button is hit
    setPrcState(ProcessingState.waiting);
    try {
      // Get back usercredential future from createUserWithEmailAndPassword method
      UserCredential userCred = await authInstance
          .createUserWithEmailAndPassword(email: email, password: password);
      // Save username name
      await userCred.user!.updateDisplayName(username);

      // After that access "users" Firestore in firestore and save username, email and userLocation
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCred.user!.uid)
          .set(
        {
          'username': username,
          'email': email,
          'userLocation': null,
        },
      );

      ScaffoldMessenger.of(context)
          .showSnackBar(msgPopUp("The account has been registered."));
      // if every thing goes well user will registered and logged in
      // now go to homepage
      GoRouter.of(context).goNamed(APP_PAGE.home.routeName);
    } on FirebaseAuthException catch (e) {
      // In case of error
      // if email already exists
      if (e.code == "email-already-in-use") {
        showDialog(
            context: context,
            builder: (context) => errorDialog(
                context, "The account with this email already exists."));
      }
      if (e.code == 'weak-password') {
        // If password is too weak
        showDialog(
            context: context,
            builder: (context) =>
                errorDialog(context, "Password is too weak."));
      }
      setPrcState(ProcessingState.done);
    } catch (e) {
      // For anything else
      showDialog(
          context: context,
          builder: (context) =>
              errorDialog(context, "Something went wrong please try again."));
      setPrcState(ProcessingState.done);
    }
    // notify listeneres
    notifyListeners();
  }

  // Our Function will take email,password and buildcontext

  void login(String email, String password, BuildContext context) async {
    setPrcState(ProcessingState.waiting);
    try {
      // try signing in
      UserCredential userCred = await authInstance.signInWithEmailAndPassword(
          email: email, password: password);

      ScaffoldMessenger.of(context).showSnackBar(msgPopUp("Welcome Back"));
      // if succesfull leave auth screen and go to homepage
      GoRouter.of(context).goNamed(APP_PAGE.home.routeName);
    } on FirebaseAuthException catch (e) {
      // On error
      // If user is not found
      if (e.code == 'user-not-found') {
        showDialog(
            context: context,
            builder: (context) =>
                errorDialog(context, "No user found for that email."));
      }
      // If password is wrong
      if (e.code == 'wrong-password') {
        showDialog(
            context: context,
            builder: (context) => errorDialog(context, "Wrong password."));
      }
      setPrcState(ProcessingState.done);
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) =>
              errorDialog(context, "Something went wrong please try again"));
      setPrcState(ProcessingState.done);
    }
    // notify the listeners.
    notifyListeners();
  }

  void logOut() async {
    await authInstance.signOut();
    setPrcState(ProcessingState.done);
    notifyListeners();
  }
}
