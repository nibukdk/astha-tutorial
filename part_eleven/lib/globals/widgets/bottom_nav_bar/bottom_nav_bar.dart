import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:temple/globals/settings/router/utils/router_utils.dart';

class CustomBottomNavBar extends StatefulWidget {
  // create index to select from the list of route paths
  final int navItemIndex;

  const CustomBottomNavBar({required this.navItemIndex, Key? key})
      : super(key: key);

  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  // Make a list of routes that you'll want to go to
  static final List<String> _widgetOptions = [
    APP_PAGE.home.routeName,
    APP_PAGE.favorite.routeName,
    APP_PAGE.shop.routeName,
  ];

// Function that handles navigation based of index received
  void _onItemTapped(int index) {
    GoRouter.of(context).goNamed(_widgetOptions[index]);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      // List of icons that represent screen.
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favorites',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shop),
          label: 'Shop',
        ),
      ],

      // Backgroud color

      backgroundColor: Theme.of(context).colorScheme.primary,

      currentIndex: widget.navItemIndex, // current selected index
      selectedItemColor:
          Theme.of(context).colorScheme.onPrimary, // selected item color

      selectedIconTheme: IconThemeData(
        size: 30, // Make selected icon bigger than the rest
        color: Theme.of(context)
            .colorScheme
            .onPrimary, // selected icon will be white
      ),
      unselectedIconTheme: const IconThemeData(
        size: 24, // Size of non-selected icons
        color: Colors.black,
      ),
      selectedLabelStyle: const TextStyle(
        fontSize: 20, // When selected make text bigger
        fontWeight: FontWeight.w400, // and bolder but not so thick
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
      onTap: _onItemTapped,
    );
  }
}
