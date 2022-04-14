import 'dart:math';

import 'package:flutter/material.dart';

class ShopItemWidget extends StatelessWidget {
  const ShopItemWidget(
      {required this.width,
      required this.imgUrl,
      required this.itemType,
      required this.price,
      required this.title,
      required this.ratings,
      Key? key})
      : super(key: key);

  final double width;
  final String imgUrl;
  final String title;
  final List<String> itemType;
  final double price;
  final double ratings;

  List<Widget> randomRatingStars() {
    int ratings = Random().nextInt(6);
    if (ratings == 0) ratings = 1;
    List<Icon> stars = [];
    for (var i = 0; i < ratings; i++) {
      stars.add(const Icon(
        Icons.star,
        size: 20,
        color: Colors.amber,
      ));
    }
    print(stars);
    return stars;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width * .5,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(10),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                // flex: 3,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: Image.asset(
                    imgUrl,
                    width: width,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: 24,
                        overflow: TextOverflow.fade,
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4),
                child: Text(
                  " NPR ${price.toString()}",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(fontSize: 20, fontWeight: FontWeight.w400),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ...randomRatingStars(),
                    Text(" / ${Random().nextInt(10000).toString()}")
                  ],
                ),
              )
            ]),
      ),
    );
  }
}
