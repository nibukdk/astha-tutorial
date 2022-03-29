import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:temple/globals/providers/app_state_provider.dart';
import 'package:temple/globals/settings/router/app_router.dart';
import 'package:temple/globals/theme/app_theme.dart';

class MyApp extends StatefulWidget {
// Declared fields prefs which we will pass to the router class
  SharedPreferences prefs;
  MyApp({required this.prefs, Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppStateProvider()),
        // Remove previous Provider call and create new proxyprovider that depends on AppStateProvider
        ProxyProvider<AppStateProvider, AppRouter>(
            update: (context, appStateProvider, _) => AppRouter(
                appStateProvider: appStateProvider, prefs: widget.prefs))
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
