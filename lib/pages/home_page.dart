import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_bugkill/components/bug_posts.dart';
import 'package:project_bugkill/components/my_drawer.dart';
import 'package:project_bugkill/components/my_textfiled.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // make an instance of the user
  final currentUser = FirebaseAuth.instance.currentUser!;

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
                      itemBuilder: (context, index) {
                        // get the messages
                        final post = snapshot.data!.docs[index];

                        return BugPost(
                          message: post['message'],
                          username: post['username'],
                          time: post['time'],
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
                      },
                      child: const Icon(Icons.send)),
                )
              ]),
            ),

            // login as
            Text("Logged in as ${currentUser.email!}"),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
    );
  }
}
