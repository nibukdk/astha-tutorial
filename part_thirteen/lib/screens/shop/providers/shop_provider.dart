import 'package:flutter/foundation.dart';
import 'package:temple/screens/shop/models/shop.dart';

class ShopProvider extends ChangeNotifier {
  final List<ShopItem> _items = [
    ShopItem(
      name: "Ganesh Murti",
      imgUrl: "assets/images/image_1.jpg",
      price: 5.0,
      shopId: "Shop2",
      ratings: 4.5,
    ),
    ShopItem(
        name: "Dhup",
        imgUrl: "assets/shop/img.png",
        price: 5.0,
        ratings: 4.5,
        shopId: "Shop3"),
    ShopItem(
        ratings: 4.5,
        name: "Dhup",
        imgUrl: "assets/shop/img.png",
        price: 5.0,
        shopId: "Shop"),
    ShopItem(
        name: "Dhup",
        ratings: 4.5,
        imgUrl: "assets/shop/img.png",
        price: 5.0,
        shopId: "Shop1"),
    ShopItem(
        ratings: 4.5,
        name: "Dhup",
        imgUrl: "assets/shop/img.png",
        price: 5.0,
        shopId: "Shop1"),
  ];

  get items => [..._items];
}
