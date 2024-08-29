import 'package:flutter/material.dart';
import 'package:project_bugkill/components/my_drawer.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
        children: const [
          // user profile picture

          // user name

          // user email

          //user details

          //bio

          //user posts
        ],
      ),
    );
  }
}
