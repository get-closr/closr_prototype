import 'package:flutter/material.dart';

@immutable
class User {
  const User({this.email, @required this.uid});
  final String uid;
  final String email;
}

abstract class AuthService {
  Future<User> currentUser();
  Future<User> signInAnonymously();
  Future<User> signInWithEmailAndPassword(String email, String password);
  Future<User> createUserWithEmailAndPassword(String email, String password);
  Future<void> sendPasswordResetEmail(String email);
  Future<User> signInWithGoogle();
  Future<void> signOut();
  Stream<User> get onAuthStateChanged;
  void dispose();
}
