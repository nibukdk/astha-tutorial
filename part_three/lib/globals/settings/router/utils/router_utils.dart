enum APP_PAGE {
  onboard,
  auth,
  home,
}

extension AppPageExtension on APP_PAGE {
  // create path for routes
  String get routePath {
    switch (this) {
      case APP_PAGE.home:
        return "/";

      case APP_PAGE.onboard:
        return "/onboard";

      case APP_PAGE.auth:
        return "/auth";

      default:
        return "/";
    }
  }

// for named routes
  String get routeName {
    switch (this) {
      case APP_PAGE.home:
        return "HOME";

      case APP_PAGE.onboard:
        return "ONBOARD";

      case APP_PAGE.auth:
        return "AUTH";

      // case APP_PAGE.splash:
      //   return "SPLASH";

      default:
        return "HOME";
    }
  }

// for page titles

  String get routePageTitle {
    switch (this) {
      case APP_PAGE.home:
        return "Astha";

      default:
        return "Astha";
    }
  }
}
