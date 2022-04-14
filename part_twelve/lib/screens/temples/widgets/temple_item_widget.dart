import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:temple/screens/temples/providers/temple_provider.dart';

class TempleItemWidget extends StatefulWidget {
  // Fields that'll shape the Widget
  final String title;
  final String imageUrl;
  final String address;
  final double width;
  final String itemId;

  const TempleItemWidget(
      {required this.title,
      required this.imageUrl,
      required this.address,
      required this.width,
      required this.itemId,

      // required this.establishedDate,
      Key? key})
      : super(key: key);

  @override
  State<TempleItemWidget> createState() => _TempleItemWidgetState();
}

class _TempleItemWidgetState extends State<TempleItemWidget> {
  // function to call addToFavList from provider class
  // It'll take id and providerclass as input
  void toggleFavList(String placeId, TempleProvider templeProvider) {
    templeProvider.addToFavList(placeId);
  }

  @override
  Widget build(BuildContext context) {
    // Fetch the user doc as stream
    Stream<DocumentSnapshot> qSnapShot = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots();

// Instantiate provider method to pass as argument for tooggle FavList
    TempleProvider templeProvider =
        Provider.of<TempleProvider>(context, listen: false);

    return SizedBox(
      // Card will have height of 260
      height: 260,
      width: widget.width,
      child: Card(
        key: ValueKey<String>(widget.itemId),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(10),
        child: Column(
          // Column will have two children stack and a row
          children: [
            // Stack will have two children image and title text
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: Image.network(
                    widget.imageUrl,
                    fit: BoxFit.cover,
                    width: widget.width,
                    height: 190,
                  ),
                ),
                Positioned(
                  bottom: 1,
                  child: Container(
                    color: Colors.black54,
                    width: widget.width,
                    height: 30,
                    child: Text(
                      widget.title,
                      style: Theme.of(context)
                          .textTheme
                          .headline2!
                          .copyWith(color: Colors.white),
                      // softWrap: true,
                      overflow: TextOverflow.fade,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            Row(
                // Rows will have two icons as children

                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: IconButton(
                      onPressed: () {
                        print("Donate Button Pressed");
                      },
                      icon: const Icon(
                        Icons.attach_money,
                        color: Colors.amber,
                      ),
                    ),
                  ),
                  StreamBuilder(
                      // User the ealier stream
                      stream: qSnapShot,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                                ConnectionState.waiting ||
                            snapshot.connectionState == ConnectionState.none) {
                          return const CircularProgressIndicator();
                        } else {
                          // Get documentsnaphot which is given from the stream
                          final docData = snapshot.data as DocumentSnapshot;
                          // Fetch favTempleList array from user doc
                          final favList = docData['favTempleList'] as List;
                          // Check if the curent widget id is among the favTempLlist
                          final isFav = favList.contains(widget.itemId);
                          return Expanded(
                            child: IconButton(
                                // Call toggleFavlist method on tap
                                onPressed: () => toggleFavList(
                                    widget.itemId, templeProvider),
                                icon: Icon(
                                  Icons.favorite,
                                  // Show color by value of isFav
                                  color: isFav ? Colors.red : Colors.grey,
                                )),
                          );
                        }
                      })
                ]),
          ],
        ),
      ),
    );
  }
}
