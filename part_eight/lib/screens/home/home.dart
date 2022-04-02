import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:temple/globals/widgets/app_bar/app_bar.dart';
import 'package:temple/globals/settings/router/utils/router_utils.dart';
import 'package:temple/globals/widgets/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:temple/globals/widgets/user_drawer/user_drawer.dart';
import 'package:temple/screens/auth/auth_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // create a global key for scafoldstate
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // Provide key to scaffold
        key: _scaffoldKey,
        // Changed to custom appbar
        appBar: CustomAppBar(
          title: APP_PAGE.home.routePageTitle,
          // pass the scaffold key to custom app bar
          // #3
          scaffoldKey: _scaffoldKey,
        ),
        // Pass our drawer to drawer property
        // if you want to slide right to left use
        endDrawer: const UserDrawer(),
        bottomNavigationBar: const CustomBottomNavBar(
          navItemIndex: 0,
        ),
        primary: true,
        body: const SafeArea(
            child: Center(
                child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: Text("This Is home")))));
  }
}
