import 'package:flutter/material.dart';
import 'package:tryve/components/custom_clip_shape.dart';
import 'package:tryve/components/system_theme_wrapper.dart';

class AuthenticationMethodScreen extends StatefulWidget {
  static String routeName = "/auth_method_screen";
  AuthenticationMethodScreen({Key key}) : super(key: key);

  @override
  _AuthenticationMethodScreenState createState() =>
      _AuthenticationMethodScreenState();
}

class _AuthenticationMethodScreenState
    extends State<AuthenticationMethodScreen> {
  @override
  Widget build(BuildContext context) {
    return SystemThemeWrapper(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [CustomClipShape()],
        ),
      ),
    ));
  }
}
