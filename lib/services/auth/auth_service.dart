import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<bool> signIn(
      {String email,
      String password,
      Function(FirebaseAuthException) onError}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      onError(e);
      return false;
    }
  }

  Future<bool> signUp(
      {String email,
      String password,
      Function(FirebaseAuthException) onError}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      onError(e);
      return false;
    }
  }

  Future<bool> signInWithGoogle({
    VoidCallback onError,
  }) async {
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _firebaseAuth.signInWithCredential(credential);
      return true;
    } catch (_) {
      onError();
      return false;
    }
  }

  User getUser() {
    return _firebaseAuth.currentUser;
  }
}

class AuthenticationErrors {
  static bool signInEmailError(FirebaseAuthException e) {
    if (e.code == 'user-not-found') {
      return true;
    } else {
      return false;
    }
  }

  static bool signInPasswordError(FirebaseAuthException e) {
    if (e.code == 'wrong-password') {
      return true;
    } else {
      return false;
    }
  }

  static bool registerEmailError(FirebaseAuthException e) {
    if (e.code == 'email-already-in-use') {
      return true;
    } else {
      return false;
    }
  }

  static bool registerPasswordError(FirebaseAuthException e) {
    if (e.code == 'weak-password') {
      return true;
    } else {
      return false;
    }
  }
}
