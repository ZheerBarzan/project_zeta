import 'package:flutter/material.dart';

class MyTextBox extends StatelessWidget {
  final String text;
  final String sectionName;
  const MyTextBox({super.key, required this.text, required this.sectionName});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(sectionName),
          Text(text),
        ],
      ),
    );
  }
}
