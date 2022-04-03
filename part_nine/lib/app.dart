import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:temple/globals/providers/app_state/app_state_provider.dart';
import 'package:temple/globals/providers/permissions/app_permission_provider.dart';
import 'package:temple/globals/settings/router/app_router.dart';
import 'package:temple/globals/theme/app_theme.dart';
import 'package:temple/screens/auth/providers/auth_provider.dart';

class MyApp extends StatefulWidget {
// Declared fields prefs which we will pass to the router class
  SharedPreferences prefs;

  MyApp({required this.prefs, Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn = FirebaseAuth.instance.currentUser != null ? true : false;

//  Find the user authentication status
  Future<bool> isUserLoggedIn() async {
    var user;
    // Get stream from firebase auth

    try {
      user = FirebaseAuth.instance.currentUser!.reload();
      // Listen for auth changes
    } on FirebaseAuthException catch (e) {
      // If admin deletes user from control panel
      if (e.code == "user-not-found" || e.code == "user-disabled") {
        return false;
      }
    } catch (e) {
      // if any error just return no user
      return false;
    }
    return user != null ? true : false;
  }

  @override
  void didChangeDependencies() async {
    if (isLoggedIn) {
      final hasUser = await isUserLoggedIn();
      setState(() => isLoggedIn = hasUser);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppStateProvider()),
        ChangeNotifierProvider(create: (context) => AppPermissionProvider()),
        ChangeNotifierProvider(create: (context) => AuthStateProvider()),
        // Remove previous Provider call and create new proxyprovider that depends on AppStateProvider
        ProxyProvider<AppStateProvider, AppRouter>(
            update: (context, appStateProvider, _) => AppRouter(
                  appStateProvider: appStateProvider,
                  prefs: widget.prefs,
                ))
      ],
      child: Builder(
        builder: ((context) {
          final GoRouter router = Provider.of<AppRouter>(context).router;

          return MaterialApp.router(
              routeInformationParser: router.routeInformationParser,
              theme: asthaTutorialTheme,
              routerDelegate: router.routerDelegate);
        }),
      ),
    );
  }
}
