import 'package:flutter/material.dart';
import 'package:tryve/components/system_theme_wrapper.dart';

class VerifyScreen extends StatefulWidget {
  static String routeName = "/verify";
  VerifyScreen({Key key}) : super(key: key);

  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  @override
  Widget build(BuildContext context) {
    return SystemThemeWrapper(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Verify"),
        ),
      ),
    );
  }
}
