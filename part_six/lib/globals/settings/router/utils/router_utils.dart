enum APP_PAGE {
  onboard,
  auth,
  home,
  search,
  shop,
  favorite,
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

      case APP_PAGE.search:
        return "/serach";

      case APP_PAGE.favorite:
        return "/favorite";

      case APP_PAGE.shop:
        return "/shop";
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

      case APP_PAGE.search:
        return "Search";
      case APP_PAGE.favorite:
        return "Favorite";

      case APP_PAGE.shop:
        return "Shop";

      default:
        return "HOME";
    }
  }

// for page titles

  String get routePageTitle {
    switch (this) {
      case APP_PAGE.home:
        return "Astha";

      case APP_PAGE.auth:
        return "Register/SignIn";

      case APP_PAGE.shop:
        return "Shops";

      case APP_PAGE.search:
        return "Search";

      case APP_PAGE.favorite:
        return "Your Favorites";

      default:
        return "Astha";
    }
  }
}
