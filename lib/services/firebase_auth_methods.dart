import 'package:firebase_authentication/screens/login_screen.dart';
import 'package:firebase_authentication/utils/showOtpDialog.dart';
import 'package:firebase_authentication/utils/showSnackBar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth;
  FirebaseAuthMethods(this._auth);

  User get user => _auth.currentUser!;

  //State Persistence
  Stream<User?> get authState => FirebaseAuth.instance.authStateChanges();
  // FirebaseAuth.instance.userChanges();
  // FirebaseAuth.instance.idTokenCHanges();

  // Email Sign Up
  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (context.mounted) {
        await sendEmailVerification(context);
      }
    } on FirebaseAuthException catch (e) {
      if (email.isEmpty || password.isEmpty) {
        showSnackBar(context, 'Enter Email and Password');
      } else {
        showSnackBar(context, e.message!);
      }
    }
  }

  // Email Login
  Future<void> loginWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (context.mounted && !_auth.currentUser!.emailVerified) {
        _auth.currentUser!.sendEmailVerification();
        showSnackBar(context, 'Email Not Verified');
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  // Reset Login Password
  Future<void> forgotLoginPassword({
    required String email,
    required BuildContext context,
  }) async {
    try {
      await _auth.sendPasswordResetEmail(
        email: email,
      );
      if (context.mounted) {
        showSnackBar(context, 'Reset password email sent');
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      if (email.isEmpty) {
        showSnackBar(context, 'Enter Email Address');
      } else if (e.code == 'user-not-found') {
        showSnackBar(context, 'Email does not exist');
      } else {
        showSnackBar(context, e.message!);
      }
    } catch (e) {
      showSnackBar(context, 'An error occurred');
      Navigator.pop(context);
    }
  }

  // Email Verification
  Future<void> sendEmailVerification(BuildContext context) async {
    try {
      _auth.currentUser!.sendEmailVerification();
      showSnackBar(context, 'Email Verification Sent');
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  // Phone sign in
  Future<void> phoneSignIn({
    required BuildContext context,
    required String phoneNumber,
  }) async {
    TextEditingController codeController = TextEditingController();

    if (kIsWeb) {
      //// Works only for Web Version
      ConfirmationResult result = await _auth.signInWithPhoneNumber(phoneNumber);

      // Displaying Otp Dialog
      if (context.mounted) {
        showOtpDialog(
          context: context,
          codeController: codeController,
          onPressed: () async {
            PhoneAuthCredential credential = PhoneAuthProvider.credential(
              verificationId: result.verificationId,
              smsCode: codeController.text.trim(),
            );

            await _auth.signInWithCredential(credential);
            if (context.mounted) Navigator.of(context).pop();
          },
        );
      }
    } else {
      // For Android and IOS
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        // verificationCompleted -> It automatically checks the otp (works in android)
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (e) {
          showSnackBar(context, e.message!);
        },
        // codesent -> User has to enter otp manually
        codeSent: ((String verificationId, int? resendToken) async {
          showOtpDialog(
            context: context,
            codeController: codeController,
            onPressed: () async {
              PhoneAuthCredential credential = PhoneAuthProvider.credential(
                verificationId: verificationId,
                smsCode: codeController.text.trim(),
              );

              await _auth.signInWithCredential(credential);
              if (context.mounted) Navigator.pushNamed(context, LoginScreen.routeName);
            },
          );
        }),
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    }
  }

  // Google Sign In
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      if (kIsWeb) {
        // For Web
        GoogleAuthProvider googleProvider = GoogleAuthProvider();
        // scope any 1
        googleProvider.addScope('https://www.googleapis.com/auth/contacts.readonly');

        await _auth.signInWithPopup(googleProvider);
      } else {
        // For Android and IOS
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

        final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

        if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
          // Create a new credential

          final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth?.accessToken,
            idToken: googleAuth?.idToken,
          );
          UserCredential userCredential = await _auth.signInWithCredential(credential);

          if (userCredential.user != null) {
            if (userCredential.additionalUserInfo!.isNewUser) {
              //Sign up processes
              print('signed in');
            } else {
              // Login Processes
              print('Logged in');
            }
          }
        }
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  // Anonymous Sign In
  Future<void> signInAnonymously(BuildContext context) async {
    try {
      await _auth.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  // Sign Out
  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  // Delete Account
  Future<void> deleteAccount(BuildContext context) async {
    try {
      await _auth.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }
}
