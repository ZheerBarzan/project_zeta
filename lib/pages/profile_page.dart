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

  Future<void> editField(String field) async {}

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
      body: ListView(
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
              text: "Mr.Zheer",
              sectionName: "User Name",
              onPressed: () => editField("user name")),

          //bio
          MyTextBox(
              text: "I am a software engineer",
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
      ),
    );
  }
}
