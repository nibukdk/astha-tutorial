import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:temple/globals/settings/router/utils/router_utils.dart';

class AuthStateProvider with ChangeNotifier {
  FirebaseAuth authInstance = FirebaseAuth.instance;

  // Our Function will take email,password, username and buildcontext
  void register(String email, String password, String username,
      BuildContext context) async {
    // Start loading progress indicator once submit button is hit
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
      // if every thing goes well user will registered and logged in
      // now go to homepage
      GoRouter.of(context).goNamed(APP_PAGE.home.routeName);
    } on FirebaseAuthException catch (e) {
      // In case of error
      // if email already exists
      if (e.code == "email-already-in-use") {
        print("The account with this email already exists.");
      }
      if (e.code == 'weak-password') {
        // If password is too weak
        print("Password is too weak.");
      }
    } catch (e) {
      // For anything else
      print("Something went wrong please try again.");
    }
    // notify listeneres
    notifyListeners();
  }

  // Our Function will take email,password and buildcontext

  void login(String email, String password, BuildContext context) async {
    try {
      // try signing in
      UserCredential userCred = await authInstance.signInWithEmailAndPassword(
          email: email, password: password);
      // if succesfull leave auth screen and go to homepage
      GoRouter.of(context).goNamed(APP_PAGE.home.routeName);
    } on FirebaseAuthException catch (e) {
      // On error
      // If user is not found
      if (e.code == 'user-not-found') {
        print("No user found for that email.");
      }
      // If password is wrong
      if (e.code == 'wrong-password') {
        print("Wrong password.");
      }
    } catch (e) {
      print("Something went wrong please try again");
    }
    // notify the listeners.
    notifyListeners();
  }

  void logOut() async {
    await authInstance.signOut();
    notifyListeners();
  }
}
