// Packages
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
//Custom files
import 'package:temple/screens/home/home.dart';
import 'utils/router_utils.dart';
import 'package:temple/screens/onboard/onboard_screen.dart';
import 'package:temple/globals/providers/app_state_provider.dart';

class AppRouter {
  //=======================change #1 start ===========/
  AppRouter({
    required this.appStateProvider,
    required this.prefs,
  });

  AppStateProvider appStateProvider;
  late SharedPreferences prefs;
  //=======================change #1 end===========/
  get router => _router;

// change final to late final to use prefs inside redirect.
  late final _router = GoRouter(
      refreshListenable:
          appStateProvider, //=======================change #2===========/
      initialLocation: "/",
      routes: [
        GoRoute(
          path: APP_PAGE.home.routePath,
          name: APP_PAGE.home.routeName,
          builder: (context, state) => const Home(),
        ),
        // Add the onboard Screen
        //=======================change #3  start===========/

        GoRoute(
            path: APP_PAGE.onboard.routePath,
            name: APP_PAGE.onboard.routeName,
            builder: (context, state) => const OnBoardScreen()),
        //=======================change #3  end===========/
      ],
      redirect: (state) {
        //=======================change #4  start===========/

        // define the named path of onboard screen
        final String onboardPath =
            state.namedLocation(APP_PAGE.onboard.routeName); //#4.1

        // Checking if current path is onboarding or not
        bool isOnboarding = state.subloc == onboardPath; //#4.2

        // check if sharedPref as onBoardCount key or not
        //if is does then we won't onboard else we will
        bool toOnboard =
            prefs.containsKey('onBoardCount') ? false : true; //#4.3

        //#4.4
        if (toOnboard) {
          // return null if the current location is already OnboardScreen to prevent looping
          return isOnboarding ? null : onboardPath;
        }
        // returning null will tell router to don't mind redirect section
        return null; //#4.5
        //=======================change #4  end===========/
      });
}
