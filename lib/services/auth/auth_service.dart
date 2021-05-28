import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:tryve/services/api/models/user_model.dart';
import 'package:tryve/services/api/parse/user_api/user_api.dart';

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
      String name,
      String password,
      Function(FirebaseAuthException) onError}) async {
    try {
      await UserAPI.createUser(
          UserModel(email: email, displayName: name, social: false));
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      return true;
    } on FirebaseAuthException catch (e) {
      onError(e);
      return false;
    }
  }

  Future<bool> signInWithGoogle({
    Function(FirebaseAuthException exception) onError,
  }) async {
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      final exists = await UserAPI.accountExists(googleUser.email);
      if (!exists) {
        await UserAPI.createUser(UserModel(
            email: googleUser.email,
            displayName: googleUser.displayName,
            social: true,
            socialImage: googleUser.photoUrl));
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      try {
        await _firebaseAuth.signInWithCredential(credential);

        return true;
      } on FirebaseAuthException catch (e) {
        onError(e);
        return false;
      }
    } catch (_) {
      onError(null);
      return false;
    }
  }

  Future<bool> signInWithFacebook({
    Function(FirebaseAuthException exception) onError,
  }) async {
    try {
      final facebookLogin = FacebookLogin();
      final result = await facebookLogin.logIn(['email', 'public_profile']);
      final response = await http.get(
          "https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${result.accessToken.token}");
      final data = jsonDecode(response.body);

      final exists = await UserAPI.accountExists(data['email']);
      if (!exists) {
        await UserAPI.createUser(UserModel(
            email: data['email'],
            displayName: data['name'],
            social: true,
            socialImage: data['picture']['data']['url']));
      }

      final FacebookAuthCredential credential =
          FacebookAuthProvider.credential(result.accessToken.token);

      try {
        await _firebaseAuth.signInWithCredential(credential);

        return true;
      } on FirebaseAuthException catch (e) {
        onError(e);
        return false;
      }
    } catch (_) {
      onError(null);
      return false;
    }
  }

  User getUser() {
    return _firebaseAuth.currentUser;
  }

  Future<ParseResponse> getParseUser() {
    return UserAPI.getUserbyMail(this.getUser().email);
  }

  Future<String> getParseUserID() async {
    return (await this.getParseUser()).result[0]['objectId'];
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
