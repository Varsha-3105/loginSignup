import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../model/user_model.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

 Future<void> signupUser(UserModel user, String password, BuildContext context) async {
  try {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: user.email,
      password: password,
    );

    //Store user data in `task` collection
    await _firestore.collection('task').doc(userCredential.user!.uid).set(user.toMap());

    Navigator.pushReplacementNamed(context, '/home');
  } catch (e) {
    _showError(context, e.toString());
  }
}


  Future<void> loginUser(String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      DocumentSnapshot userDoc = await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      if (userDoc.exists) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        _showError(context, "User data not found.");
      }
    } catch (e) {
      _showError(context, "Login failed: $e");
    }
  }

  Future<void> resetPassword(String email, BuildContext context) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Reset link sent to your email.")));
    } catch (e) {
      _showError(context, e.toString());
    }
  }

  void _showError(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(content: Text(message)),
    );
  }
}