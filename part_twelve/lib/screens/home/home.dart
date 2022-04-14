import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Custom
import 'package:temple/globals/providers/permissions/app_permission_provider.dart';
import 'package:temple/globals/widgets/app_bar/app_bar.dart';
import 'package:temple/globals/settings/router/utils/router_utils.dart';
import 'package:temple/globals/widgets/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:temple/globals/widgets/user_drawer/user_drawer.dart';
import 'package:temple/screens/home/widgets/card_button_widget.dart';
import 'package:temple/screens/home/widgets/quote_card_widget.dart';

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
    // Device width
    final deviceWidth = MediaQuery.of(context).size.width;
    // Available width
    final availableWidth = deviceWidth -
        MediaQuery.of(context).padding.right -
        MediaQuery.of(context).padding.left;

    return Scaffold(
      key: _scaffoldKey,
      endDrawer: const UserDrawer(),
      appBar: CustomAppBar(
        scaffoldKey: _scaffoldKey,
        title: APP_PAGE.home.routePageTitle,
      ),
      primary: true,
      bottomNavigationBar: const CustomBottomNavBar(navItemIndex: 0),
      body: FutureBuilder(
          // Call getLocation function as future
          // its very very important to set listen to false
          future: Provider.of<AppPermissionProvider>(context, listen: false)
              .getLocation(),
          // don't need context in builder for now
          builder: ((context, snapshot) {
            // if snapshot connectinState is none or waiting
            if (snapshot.connectionState == ConnectionState.waiting ||
                snapshot.connectionState == ConnectionState.none) {
              return const Center(child: CircularProgressIndicator());
            } else {
              // if snapshot connectinState is active

              if (snapshot.connectionState == ConnectionState.active) {
                return const Center(
                  child: Text("Loading..."),
                );
              }
              // if snapshot connectionState is done
              return SafeArea(
                // Whole view will be scrollable
                child: SingleChildScrollView(
                    // Column
                    child: Column(children: [
                  // FIrst child would be quote card
                  DailyQuotes(availableWidth),
                  // Second child will be GriDview.count with padding of 4
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: GridView.count(
                      // scrollable
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      // two grids
                      crossAxisCount: 2,
                      //  Space between two Horizontal axis
                      mainAxisSpacing: 10,
                      //  Space between two vertical axis
                      crossAxisSpacing: 10,
                      children: [
                        // GridView Will have children
                        CardButton(
                          Icons.temple_hindu_sharp,
                          "Temples Near You",
                          availableWidth,
                          APP_PAGE.temples.routeName, // Route for temples
                        ),
                        CardButton(
                          Icons.event,
                          "Coming Events",
                          availableWidth,
                          APP_PAGE.home
                              .routeName, // Route for homescreen we are not making these for MVP
                        ),
                        CardButton(
                          Icons.location_pin,
                          "Find Venues",
                          availableWidth,
                          APP_PAGE.home.routeName,
                        ),
                        CardButton(
                          Icons.music_note,
                          "Morning Prayers",
                          availableWidth,
                          APP_PAGE.home.routeName,
                        ),
                        CardButton(
                          Icons.attach_money_sharp,
                          "Donate",
                          availableWidth,
                          APP_PAGE.home.routeName,
                        ),
                      ],
                    ),
                  )
                ])),
              );
            }
          })),
    );
  }
}
