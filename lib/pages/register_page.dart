import 'package:flutter/material.dart';
import 'package:project_zeta/components/my_button.dart';
import 'package:project_zeta/components/my_square.dart';
import 'package:project_zeta/components/my_textfiled.dart';
import 'package:project_zeta/services/auth_service.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final Function()? onTap;
  RegisterPage({super.key, this.onTap});
  void signup(BuildContext context) async {
    final authService = AuthService();

    if (_passwordController.text == _confirmPasswordController.text) {
      try {
        await authService.createUserWithEmailAndPassword(
            _emailController.text, _passwordController.text);
      } catch (e) {
        showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
            content: Text(e.toString()),
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Password not match"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            // logo
            Image.asset("lib/images/Z.png", height: 100, width: 100),
            const SizedBox(
              height: 50,
            ),
            //welcome back

            Text(
              "W E L C O M E",
              style: TextStyle(
                  fontSize: 28,
                  color: Theme.of(context).colorScheme.inversePrimary),
            ),

            const SizedBox(
              height: 50,
            ),
            //email Textfiled
            MyTextField(
              hintText: "Enter your Email ",
              obscureText: false,
              controller: _emailController,
            ),

            const SizedBox(
              height: 10,
            ),
            //password Textfiled
            MyTextField(
              hintText: "Password",
              obscureText: true,
              controller: _passwordController,
            ),
            const SizedBox(
              height: 10,
            ),
            //confirm password Textfiled
            MyTextField(
              hintText: "Confirm Password",
              obscureText: true,
              controller: _confirmPasswordController,
            ),
            const SizedBox(
              height: 10,
            ),
            // login button
            MyButton(onTap: () => signup(context), text: "Sign Up"),
            const SizedBox(
              height: 10,
            ),
            //rigister now

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already a member?"),
                GestureDetector(
                  onTap: onTap,
                  child: const Text(
                    "Login now",
                    style: TextStyle(color: Colors.blue),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            // apple and google sign in
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SqureTile(
                  imagePath: "lib/images/google.png",
                  onTap: () => AuthService().signInWithGoogle(),
                ),
                const SizedBox(width: 20),
                const SqureTile(
                  imagePath: "lib/images/apple.png",
                  onTap: null,
                ),
                const SizedBox(width: 20),
                const SqureTile(
                  imagePath: "lib/images/ms.png",
                  onTap: null,
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
