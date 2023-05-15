import 'package:firebase_authentication/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class EmailPasswordSignUp extends StatefulWidget {
  const EmailPasswordSignUp({super.key});
  static String routeName = '/signup-email-password';

  @override
  State<EmailPasswordSignUp> createState() => _EmailPasswordSignUpState();
}

class _EmailPasswordSignUpState extends State<EmailPasswordSignUp> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Sign Up',
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.08),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextField(
              keyboardType: TextInputType.text,
              controller: emailController,
              hintText: 'Enter your email',
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextField(
              keyboardType: TextInputType.text,
              controller: passwordController,
              hintText: 'Enter your password',
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
              textStyle: MaterialStateProperty.all(
                const TextStyle(color: Colors.white),
              ),
              minimumSize: MaterialStateProperty.all(
                Size(MediaQuery.of(context).size.width / 2.5, 50),
              ),
            ),
            child: const Text(
              "Sign Up",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
