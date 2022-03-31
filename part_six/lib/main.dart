import 'dart:io' show Platform;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
// Custom modules
import 'package:temple/app.dart';

const bool _useEmulator = true;

void main() async {
  //  concrete binding for applications based on the Widgets framewor
  WidgetsFlutterBinding.ensureInitialized();

// Instantiate shared pref
  SharedPreferences prefs = await SharedPreferences.getInstance();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.black38),
  );
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Set app to run on firebase emulator
  if (_useEmulator) {
    await _connectToEmulator();
  }

// Pass prefs as value in MyApp
  runApp(MyApp(prefs: prefs));
}

// Settings for firebase emulator connection
Future _connectToEmulator() async {
  // Provide url to the emulator, localhost might not work on android emulator.
  final host = Platform.isAndroid ? '10.0.2.2' : 'localhost';
  // Provide port for all the local emulator prodcuts
  const authPort = 9099;
  const firestorePort = 8080;
  const functionsPort = 5001;
  const storagePort = 9199;

  // Just to make sure we're running locally
  print("I am running on emulator");

  // Instruct all the relevant firebase products to use firebase emulator
  await FirebaseAuth.instance.useAuthEmulator(host, authPort);
  FirebaseFirestore.instance.useFirestoreEmulator(host, firestorePort);
  FirebaseFunctions.instance.useFunctionsEmulator(host, functionsPort);
  FirebaseStorage.instance.useStorageEmulator(host, storagePort);
}
