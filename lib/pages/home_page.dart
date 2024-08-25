import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_bugkill/components/my_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // make an instance of the user
  final currentUser = FirebaseAuth.instance.currentUser!;
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

            // post message

            // login as
            Text("Logged in as ${currentUser.email!}"),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
    );
  }
}
