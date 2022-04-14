import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShopModel {
  final String name;
  final String address;
  final LatLng location;
  final String shopType;
  final List<ShopItem> itemLists;

  ShopModel({
    required this.name,
    required this.address,
    required this.location,
    required this.shopType,
    this.itemLists = const [],
  });
}

class ShopItem {
  final String name;
  final String imgUrl;
  final double price;
  final double ratings;
  final List<String> occassion;
  final List<String> itemType;
  final String shopId;

  ShopItem({
    required this.name,
    required this.imgUrl,
    required this.price,
    required this.shopId,
    this.itemType = const [],
    this.occassion = const [],
    this.ratings = 0.0,
  });
}
