import 'package:flutter/material.dart';
import 'package:project_bugkill/components/my_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("H O M E"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: MyDrawer(),
      body: Container(
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
