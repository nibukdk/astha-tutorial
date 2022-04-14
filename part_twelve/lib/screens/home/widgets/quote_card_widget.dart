import 'package:flutter/material.dart';

class DailyQuotes extends StatelessWidget {
  // Dimensions for our card
  final double width;
  const DailyQuotes(this.width, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          // Adjust the height by content
          const BoxConstraints(maxHeight: 180, minHeight: 160),
      width: width,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(2),
      child: Card(
          elevation: 4,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      // Adjust padding
                      padding: const EdgeInsets.only(
                          top: 10, left: 4, bottom: 10, right: 4),
                      child: Text(
                        "Bhagavad Gita",
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 6, left: 4, right: 4),
                      child: Text(
                        "Calmness, gentleness, silence, self-restraint, and purity: these are the disciplines of the mind.",
                        style: Theme.of(context).textTheme.bodyText2,
                        overflow: TextOverflow.clip,
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0)),
                  child: Image.asset(
                    "assets/images/image_3.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ],
          )),
    );
  }
}
