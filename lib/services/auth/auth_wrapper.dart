import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatelessWidget {
  final Widget loggedOut;
  final Widget loggedIn;
  const AuthWrapper(
      {Key key, @required this.loggedOut, @required this.loggedIn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      return loggedIn;
    } else {
      return loggedOut;
    }
  }
}
