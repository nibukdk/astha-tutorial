import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PillButton extends StatelessWidget {
  const PillButton(
      {required this.icon,
      required this.title,
      required this.width,
      required this.routeName,
      Key? key})
      : super(key: key);

  final IconData icon;
  final String title;
  final double width;
  final String routeName;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => GoRouter.of(context).goNamed(routeName),
      icon: Icon(
        icon,
        size: 30,
      ),
      label: Text(title),
    );
  }
}
