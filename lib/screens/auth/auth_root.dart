import 'package:flutter/material.dart';
import 'package:tryve/screens/auth/sign_in_screen.dart';
import 'package:tryve/screens/auth/sign_up_screen.dart';

class AuthRootScreen extends StatelessWidget {
  static String routeName = "/auth_root";

  final PageController _controller = PageController();

  AuthRootScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controller,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        SigninScreen(
          controller: _controller,
        ),
        SignupScreen(
          controller: _controller,
        ),
      ],
    );
  }
}
