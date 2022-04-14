import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CardButton extends StatelessWidget {
  // Define Fields
  // Icon to be used
  final IconData icon;
  // Tittle of Button
  final String title;
  // width of the card
  final double width;
  // Route to go to
  final String routeName;

  const CardButton(this.icon, this.title, this.width, this.routeName,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      // Make the border round
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child:
          // We'll make whole card tappable with inkwell
          InkWell(
        // ON tap go to the respective widget
        onTap: () => GoRouter.of(context).goNamed(routeName),
        child: SizedBox(
          width: width,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Expanded(
                  flex: 2,
                  child:
                      // Icon border should be round and partially transparent
                      CircleAvatar(
                    backgroundColor: Theme.of(context)
                        .colorScheme
                        .background
                        .withOpacity(0.5),
                    radius: 41,
                    child:
                        // Icon
                        Icon(
                      icon,
                      size: 35,
                      // Use secondary color
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
