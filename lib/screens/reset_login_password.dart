import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/services/firebase_auth_methods.dart';
import 'package:firebase_authentication/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  static String routeName = '/reset-login-password';
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    super.dispose();
  }

  void resetPassword() {
    if (context.mounted) {
      FirebaseAuthMethods(FirebaseAuth.instance).forgotLoginPassword(
        email: emailController.text,
        context: context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Reset Password",
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
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: resetPassword,
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
              "Send Request",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
