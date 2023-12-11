import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Column(
          children: [
            Icon(Icons.lock),

          ],
          // logo

          //wellcome back messege
          //email textFiled
          //password textFiled
          //sign in button
          // go to register
          ),),
    );
  }
}
