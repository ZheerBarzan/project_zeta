import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_bugkill/components/bug_posts.dart';
import 'package:project_bugkill/components/my_drawer.dart';
import 'package:project_bugkill/components/my_textfiled.dart';
import 'package:project_bugkill/pages/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // make an instance of the user
  final currentUser = FirebaseAuth.instance.currentUser!;

  void postBug() {
    if (_messageController.text.isNotEmpty) {
      FirebaseFirestore.instance.collection("user posts").add({
        "message": _messageController.text,
        "username": currentUser.email,
        "likes": [],
        "time": Timestamp.now(),
      });
    }

    setState(() {
      _messageController.clear();
    });
  }

  void goToProfile() {
    Navigator.pop(context);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProfilePage(),
      ),
    );
  }

  final TextEditingController _messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("H O M E"),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        elevation: 10,
      ),
      drawer: const MyDrawer(),
      body: Center(
        child: Column(
          children: [
            //the bug
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("user posts")
                    .orderBy("time", descending: false)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        // get the messages
                        final post = snapshot.data!.docs[index];

                        return BugPost(
                          message: post['message'],
                          username: post['username'],
                          postID: post.id,
                          likes: List<String>.from(post['likes'] ?? []),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }

                  return const Center(
                      child: CircularProgressIndicator.adaptive());
                },
              ),
            ),

            // post message
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(children: [
                Expanded(
                  child: MyTextField(
                    controller: _messageController,
                    hintText: "What's on your mind?",
                    obscureText: false,
                  ),
                ),
                SizedBox(
                  width: 70,
                  height: 55,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
                      onPressed: () {
                        // send message
                        postBug();
                      },
                      child: const Icon(Icons.send)),
                )
              ]),
            ),

            // login as
            //Text("Logged in as ${currentUser.email!}"),

            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
    );
  }
}
