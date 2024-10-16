import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:project_zeta/components/comment.dart';
import 'package:project_zeta/components/comment_button.dart';
import 'package:project_zeta/components/like_button.dart';
import 'package:project_zeta/helper/helper.dart';

class BugPost extends StatefulWidget {
  final String message;
  final String username;
  final String postID;
  final List<String> likes;
  final String time;

  const BugPost(
      {super.key,
      required this.message,
      required this.username,
      required this.time,
      required this.postID,
      required this.likes});

  @override
  State<BugPost> createState() => _BugPostState();
}

class _BugPostState extends State<BugPost> {
  // make an instance of the user
  final currentUser = FirebaseAuth.instance.currentUser!;
  final userPost = FirebaseFirestore.instance.collection('user posts');
  bool isLiked = false;
  // comment text controller
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(currentUser.email);
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });

    DocumentReference postRef = userPost.doc(widget.postID);

    if (isLiked) {
      postRef.update({
        'likes': FieldValue.arrayUnion([currentUser.email]),
      });
    } else {
      postRef.update({
        'likes': FieldValue.arrayRemove([currentUser.email]),
      });
    }
  }

  // add comments

  void addComment(String comment) {
    userPost.doc(widget.postID).collection('comments').add({
      "comment": comment,
      "username": currentUser.email,
      "time": Timestamp.now(),
    });
  }

  // show dialog for adding comment

  void showCommentDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add Comment"),
        content: TextField(
          decoration: const InputDecoration(
            hintText: "Enter comment",
          ),
          controller: _commentController,
        ),
        actions: [
          MaterialButton(
            child: const Text("cancel"),
            onPressed: () {
              Navigator.of(context).pop();
              _commentController.clear();
            },
          ),
          MaterialButton(
            child: const Text("post"),
            onPressed: () {
              addComment(_commentController.text);
              Navigator.of(context).pop();
              _commentController.clear();
            },
          ),
        ],
      ),
    );
  }

  void deletePost() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Are you sure?"),
              actions: [
                MaterialButton(
                  child: const Text("delete"),
                  onPressed: () async {
                    final commentDocs = await userPost
                        .doc(widget.postID)
                        .collection('comments')
                        .get();

                    for (var doc in commentDocs.docs) {
                      await userPost
                          .doc(widget.postID)
                          .collection('comments')
                          .doc(doc.id)
                          .delete();
                    }

                    userPost
                        .doc(widget.postID)
                        .delete()
                        .then((value) => print("post deleted"))
                        .catchError(
                            (error) => print("failed to delete $error"));
                    Navigator.pop(context);
                  },
                ),
                MaterialButton(
                  child: const Text("Cancel"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              if (widget.username == currentUser.email) {
                deletePost();
              }
            },
            backgroundColor: Colors.redAccent,
            icon: Icons.delete,
            borderRadius: BorderRadius.circular(8),
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.only(top: 25, left: 25, right: 25),
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
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
                  width: 10,
                ),
                Text(
                  widget.username,
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                const SizedBox(
                  width: 70,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(widget.message),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Column(
                  children: [
                    LikeButton(isLiked: isLiked, onTap: toggleLike),
                    Text(widget.likes.length.toString()),
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    CommentButton(onTap: showCommentDialog),
                    const Text("0"),
                  ],
                ),
                const Spacer(),
                Text(
                  widget.time,
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),

            // comments
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: userPost
                  .doc(widget.postID)
                  .collection('comments')
                  .orderBy("time", descending: true)
                  .snapshots(),
              builder: (Context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
                return ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: snapshot.data!.docs.map((doc) {
                      final commentData = doc.data();
                      return Comment(
                          comment: commentData['comment'],
                          user: commentData['username'],
                          date: formatDate(commentData['time']!));
                    }).toList());
              },
            )
          ],
        ),
      ),
    );
  }
}
