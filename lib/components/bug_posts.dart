import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BugPost extends StatelessWidget {
  final String message;
  final String username;
  final Timestamp? time;

  const BugPost(
      {super.key, required this.message, required this.username, this.time});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [Text(username), const Divider(), Text(message)],
            ),
          )
        ],
      ),
    );
  }
}
