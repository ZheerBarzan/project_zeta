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
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(comment),
          Row(
            children: [
              Text(
                user,
                style: TextStyle(color: Colors.grey.shade600),
              ),
              const Text(" . "),
              Text(date, style: TextStyle(color: Colors.grey.shade600)),
            ],
          ),
        ],
      ),
    );
  }
}
