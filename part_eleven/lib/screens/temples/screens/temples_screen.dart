import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:temple/globals/providers/permissions/app_permission_provider.dart';
import 'package:temple/globals/settings/router/utils/router_utils.dart';
import 'package:temple/globals/widgets/app_bar/app_bar.dart';
import 'package:temple/globals/widgets/user_drawer/user_drawer.dart';
import 'package:temple/screens/temples/providers/temple_provider.dart';
import 'package:temple/screens/temples/widgets/temple_item_widget.dart';

class TempleListScreen extends StatefulWidget {
  const TempleListScreen({Key? key}) : super(key: key);

  @override
  State<TempleListScreen> createState() => _TempleListScreenState();
}

class _TempleListScreenState extends State<TempleListScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  // location is required as input for getNearbyTemples method
  LatLng? _userLocation;

  @override
  void didChangeDependencies() {
    // after the build load get the user location from AppPermissionProvider
    _userLocation = Provider.of<AppPermissionProvider>(context, listen: false)
        .locationCenter;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // Device width
    final deviceWidth = MediaQuery.of(context).size.width;
    // Subtract paddings to calculate available dimensions
    final availableWidth = deviceWidth -
        MediaQuery.of(context).padding.right -
        MediaQuery.of(context).padding.left;

    return Scaffold(
      key: _scaffoldKey,
      drawer: const UserDrawer(),
      appBar: CustomAppBar(
        scaffoldKey: _scaffoldKey,
        title: APP_PAGE.temples.routePageTitle,
        // Its a subpage so we'll use backarrow and now bottom nav bar
        isSubPage: true,
      ),
      primary: true,
      body: SafeArea(
        child: FutureBuilder(
          // pass the getNearyByTemples as future
          future: Provider.of<TempleProvider>(context, listen: false)
              .getNearyByTemples(_userLocation as LatLng),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting ||
                snapshot.connectionState == ConnectionState.none) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.connectionState == ConnectionState.active) {
                return const Center(child: Text("Loading..."));
              } else {
                // After the snapshot connectionState is done
                // if theres an error go back home
                if (snapshot.hasError) {
                  Navigator.of(context).pop();
                }

                //  check if snapshot has data return on temple widget list
                if (snapshot.hasData) {
                  final templeList = snapshot.data as List;
                  return SizedBox(
                    width: availableWidth,
                    child: Column(
                      children: [
                        Expanded(
                            child: ListView.builder(
                          itemBuilder: (context, i) => TempleItemWidget(
                            address: templeList[i].address,
                            imageUrl: templeList[i].imageUrl,
                            title: templeList[i].name,
                            width: availableWidth,
                            itemId: templeList[i].placesId,
                          ),
                          itemCount: templeList.length,
                        ))
                      ],
                    ),
                  );
                } else {
                  //  check if snapshot is empty return text widget
                  return const Center(
                      child: Text("There are no temples around you."));
                }
              }
            }
          },
        ),
      ),
    );
  }
}
