import 'package:flutter/material.dart';

class UserDrawer extends StatefulWidget {
  const UserDrawer({Key? key}) : super(key: key);

  @override
  _UserDrawerState createState() => _UserDrawerState();
}

class _UserDrawerState extends State<UserDrawer> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.primary,
      actionsPadding: EdgeInsets.zero,
      scrollable: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: Text(
        "Astha",
        style: Theme.of(context).textTheme.headline2,
      ),
      content: const Divider(
        thickness: 1.0,
        color: Colors.black,
      ),
      actions: [
        // Past two links as list tiles
        ListTile(
            leading: Icon(
              Icons.person_outline_rounded,
              color: Theme.of(context).colorScheme.secondary,
            ),
            title: const Text('User Profile'),
            onTap: () {
              print("User Profile Button Pressed");
            }),
        ListTile(
            leading: Icon(
              Icons.logout,
              color: Theme.of(context).colorScheme.secondary,
            ),
            title: const Text('Logout'),
            onTap: () {
              print("Log Out Button Pressed");
            }),
      ],
    );
  }
}
