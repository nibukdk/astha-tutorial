// Packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:temple/screens/auth/auth_screen.dart';
//Custom files
import 'package:temple/screens/home/home.dart';
import 'utils/router_utils.dart';
import 'package:temple/screens/onboard/onboard_screen.dart';
import 'package:temple/globals/providers/app_state/app_state_provider.dart';

class AppRouter {
  AppRouter({
    required this.appStateProvider,
    required this.prefs,
  });

  AppStateProvider appStateProvider;
  late SharedPreferences prefs;
  get router => _router;

// change final to late final to use prefs inside redirect.
  late final _router = GoRouter(
      refreshListenable: appStateProvider,
      initialLocation: "/",
      routes: [
        GoRoute(
          path: APP_PAGE.home.routePath,
          name: APP_PAGE.home.routeName,
          builder: (context, state) => const Home(),
        ),
        // Add the onboard Screen

        GoRoute(
            path: APP_PAGE.onboard.routePath,
            name: APP_PAGE.onboard.routeName,
            builder: (context, state) => const OnBoardScreen()),

        // Add Auth Screen on Go Router
        GoRoute(
            path: APP_PAGE.auth.routePath,
            name: APP_PAGE.auth.routeName,
            builder: (context, state) => const AuthScreen()),
      ],
      redirect: (state) {
        // define the named path of onboard screen
        final String onboardPath =
            state.namedLocation(APP_PAGE.onboard.routeName);

        // define the named path of auth screen
        final String authPath = state.namedLocation(APP_PAGE.auth.routeName);

        // Checking if current path is onboarding or not
        bool isOnboarding = state.subloc == onboardPath;

        // Checking if current path is auth or not
        bool isAuthenticating = state.subloc == authPath;

        // check if sharedPref as onBoardCount key or not
        //if is does then we won't onboard else we will
        bool toOnboard = prefs.containsKey('onBoardCount') ? false : true;

        // Check if user is loggedin or not based on userLog Status
        bool isLoggedIn =
            FirebaseAuth.instance.currentUser != null ? true : false;

        print("isLoggedIn is: $isLoggedIn");
        if (toOnboard) {
          // return null if the current location is already OnboardScreen to prevent looping
          return isOnboarding ? null : onboardPath;
        }
        // only authenticate if user is not logged in
        else if (!isLoggedIn) {
          return isAuthenticating ? null : authPath;
        }

        // returning null will tell router to don't mind redirect section
        return null;
      });
}
