import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  final IconData? icon;
  final String? text;
  void Function()? onTap;
  MyListTile(
      {super.key, required this.icon, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: ListTile(
        onTap: onTap,
        leading: Icon(
          icon,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
        title: Text(text!),
      ),
    );
  }
}
