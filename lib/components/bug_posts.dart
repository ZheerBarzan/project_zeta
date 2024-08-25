import 'package:flutter/material.dart';

class BugPost extends StatelessWidget {
  final String message;
  final String username;
  final String time;

  const BugPost(
      {super.key,
      required this.message,
      required this.username,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Text(username),
              const Divider(),
              Text(time),
              const Divider(),
              Text(message)
            ],
          ),
        )
      ],
    );
  }
}
