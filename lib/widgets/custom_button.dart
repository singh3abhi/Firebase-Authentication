import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.onTap, required this.text});

  final VoidCallback onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    Color kBackgroundColor = Colors.blue;

    if (text == 'Google Sign In') {
      kBackgroundColor = Colors.red;
    }
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 40),
        backgroundColor: kBackgroundColor,
      ),
      onPressed: onTap,
      child: Text(text),
    );
  }
}
