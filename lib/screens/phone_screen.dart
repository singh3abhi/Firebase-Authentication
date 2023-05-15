import 'package:firebase_authentication/widgets/custom_button.dart';
import 'package:firebase_authentication/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class PhoneScreen extends StatefulWidget {
  static String routeName = '/phone';
  const PhoneScreen({Key? key}) : super(key: key);

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Login With Number",
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.08),
          CustomTextField(
            keyboardType: TextInputType.number,
            controller: phoneController,
            hintText: 'Enter phone number',
          ),
          const SizedBox(height: 20),
          CustomButton(
            onTap: () {},
            text: 'OK',
          ),
        ],
      ),
    );
  }
}
