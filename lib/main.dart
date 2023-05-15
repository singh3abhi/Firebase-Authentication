import 'package:firebase_authentication/screens/login_email_password.dart';
import 'package:firebase_authentication/screens/login_screen.dart';
import 'package:firebase_authentication/screens/phone_screen.dart';
import 'package:firebase_authentication/screens/signup_email_password_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Firebase Auth Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginScreen(),
      routes: {
        EmailPasswordSignUp.routeName: (context) => const EmailPasswordSignUp(),
        EmailPasswordLogin.routeName: (context) => const EmailPasswordLogin(),
        PhoneScreen.routeName: (context) => const PhoneScreen(),
      },
    );
  }
}
