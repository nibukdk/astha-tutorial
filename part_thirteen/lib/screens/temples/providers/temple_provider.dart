import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firbase_storage;
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

//custom modules
import 'package:temple/screens/temples/models/temple.dart';
import 'package:temple/screens/temples/utils/temple_utils.dart';

class TempleProvider with ChangeNotifier {
  // Instantiate FIbrebase products
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFunctions functions = FirebaseFunctions.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  // Estabish sotrage instance for bucket of our choice
  // once e mulator runs you can find the bucket name at storage tab
  final firbase_storage.FirebaseStorage storage =
      firbase_storage.FirebaseStorage.instanceFor(
          bucket: 'astha-being-hindu-tutorial.appspot.com');

// Instantiate Temple Utils
  final TemplesUtils templesUtils = TemplesUtils();
  // Create the fake list of temples
  List<TempleModel>? _temples = [];
  // User location from db
  LatLng? _userLocation;
// FavTempList

// Getters
  List<TempleModel> get temples => [..._temples as List];
  LatLng get userLocation => _userLocation as LatLng;

// List of Images
  static const List<String> imagePaths = [
    'image_1.jpg',
    'image_2.jpg',
    'image_3.jpg',
    'image_4.jpg',
  ];

// Future method to get temples
  Future<List<TempleModel>?> getNearyByTemples(LatLng userLocation) async {
    // Get urls from the temple utils
    Uri url = templesUtils.searchUrl(userLocation);

    try {
      // Set up references for firebase products.
      // Callable getNearbyTemples
      HttpsCallable getNearbyTemples =
          functions.httpsCallable('getNearbyTemples');
      // COllection reference for temples
      CollectionReference templeDocRef = firestore.collection('temples');
      // Get one doc from temples collection
      QuerySnapshot querySnapshot = await templeDocRef.limit(1).get();
      // A reference to a folder in storage that has images.
      firbase_storage.Reference storageRef = storage.ref('TempleImages');

      // We'll only get nearby temples if the temples collection empty
      if (querySnapshot.docs.isEmpty) {
        print("Temple collection is empty");
        // get the result from api search
        final res = await http.get(url);
        // decode the json result
        final decodedRes = await jsonDecode(res.body) as Map;
        // get result as list
        final results = await decodedRes['results'] as List;
        // Get random image url from available ones to put as images
        // Since we have 4 images we'll get 0-3 values from Random()
        final imgUrl = await storageRef
            .child(imagePaths[Random().nextInt(4)])
            .getDownloadURL();
        // Call the function
        final templesListCall = await getNearbyTemples.call(<String, dynamic>{
          'templeList': [...results],
          'imageRef': imgUrl,
        });

        // map the templesList restured by https callable
        final newTempleLists =
            templesUtils.mapper(templesListCall.data['temples']);

        // update the new temples list
        _temples = [...newTempleLists];
      } else {
        // If the temples collection already has temples then we won't write
        // but just fetch temples collection
        print("Temple collection is not empty");

        try {
          // get all temples documents
          final tempSnapShot = await templeDocRef.get();
          // fetch the values as list.
          final tempList = tempSnapShot.docs[0]['temples'] as List;
          // map the results into a list
          final temps = templesUtils.mapper(tempList);
          // update temples we can use this
          _temples = [...temps];
        } catch (e) {
          // incase of error temples list in empty
          _temples = [];
        }
      }
    } catch (e) {
      // incase of error temples list in empty
      _temples = [];
    }
// notify all the listeners
    notifyListeners();
    return _temples;
  }

  void addToFavList(String templeId) async {
    // Instantiate callable from index.js
    HttpsCallable addToFav = functions.httpsCallable('addToFavList');
    try {
      // Run the callable with the passing the current temples ID
      await addToFav.call(<String, String>{
        'templeId': templeId,
      });
    } catch (e) {
      rethrow;
    }
  }
}
