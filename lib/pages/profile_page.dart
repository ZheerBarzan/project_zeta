import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_bugkill/components/my_drawer.dart';
import 'package:project_bugkill/components/text_box.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final userCollection = FirebaseFirestore.instance.collection('Users');

  Future<void> editField(String field) async {
    String newValue = "";

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text("Edit $field"),
        content: TextField(
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: "Enter new value",
            hintStyle: TextStyle(color: Colors.grey),
          ),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          MaterialButton(
            child: const Text("cancel"),
            onPressed: () => Navigator.of(context).pop(),
          ),
          MaterialButton(
            child: const Text("save"),
            onPressed: () => Navigator.of(context).pop(newValue),
          ),
        ],
      ),
    );

    // update the firestore
    if (newValue.isNotEmpty) {
      await userCollection.doc(currentUser.email).update({field: newValue});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        title: const Text("P R O F I L E"),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        elevation: 10,
      ),
      drawer: const MyDrawer(),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Users")
            .doc(currentUser.email)
            .snapshots(),
        builder: (context, snapshot) {
          // get user data
          if (snapshot.hasData) {
            final userData = snapshot.data!.data() as Map<String, dynamic>;

            return ListView(
              children: [
                const SizedBox(height: 50),
                // user profile picture
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.secondary),
                  padding: const EdgeInsets.all(10),
                  child: Icon(
                    Icons.person,
                    size: 100,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),

                const SizedBox(height: 25),
                // user email
                Text(
                  currentUser.email!,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 50),

                //user details
                const Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: Text("My Details "),
                ),

                // user name
                MyTextBox(
                    text: userData["username"],
                    sectionName: "User Name",
                    onPressed: () => editField("username")),

                //bio
                MyTextBox(
                    text: userData["bio"],
                    sectionName: "Bio",
                    onPressed: () => editField("bio")),

                //user posts
                const SizedBox(height: 20),

                //user details
                const Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: Text("My Posts "),
                ),
              ],
            );
          } else {
            if (snapshot.hasError) {
              return Center(
                  child: Text(
                snapshot.error.toString(),
              ));
            }
          }
          return const Center(child: CircularProgressIndicator.adaptive());
        },
      ),
    );
  }
}
