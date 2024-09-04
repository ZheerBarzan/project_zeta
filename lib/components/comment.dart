import 'package:flutter/material.dart';

class Comment extends StatelessWidget {
  final String comment;
  final String user;
  final String date;
  const Comment(
      {super.key,
      required this.comment,
      required this.user,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(comment),
          Row(
            children: [
              Text(user),
              const Text("."),
              Text(date),
            ],
          ),
        ],
      ),
    );
  }
}
