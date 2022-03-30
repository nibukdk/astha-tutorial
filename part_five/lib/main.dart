import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:temple/app.dart';

void main() async {
  //  concrete binding for applications based on the Widgets framewor
  WidgetsFlutterBinding.ensureInitialized();

// Instantiate shared pref
  SharedPreferences prefs = await SharedPreferences.getInstance();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.black38),
  );
// Pass prefs as value in MyApp
  runApp(MyApp(prefs: prefs));
}
