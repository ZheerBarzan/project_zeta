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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                shape: BoxShape.circle, color: Colors.grey.shade400),
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
          const MyTextBox(text: "Mr.Zheer", sectionName: "User Name"),

          //bio
          const MyTextBox(text: "I am a software engineer", sectionName: "Bio"),

          //user posts
        ],
      ),
    );
  }
}
