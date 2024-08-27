import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BugPost extends StatelessWidget {
  final String message;
  final String username;
  final Timestamp? time;

  const BugPost(
      {super.key, required this.message, required this.username, this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 25, left: 25, right: 25),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          //profile picture
          Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: Colors.grey.shade400),
            padding: const EdgeInsets.all(10),
            child: Icon(
              Icons.person,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                username,
                style: TextStyle(color: Colors.grey.shade600),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(message),
            ],
          )
        ],
      ),
    );
  }
}
