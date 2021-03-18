import 'package:flutter/material.dart';
import 'package:tryve/screens/auth/auth_root.dart';
import 'package:tryve/screens/root/root_screen.dart';
import 'package:tryve/services/auth/auth_wrapper.dart';

class AuthLayerScreen extends StatelessWidget {
  static String routeName = "/auth_layer";
  const AuthLayerScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthWrapper(loggedOut: AuthRootScreen(), loggedIn: RootScreen());
  }
}
