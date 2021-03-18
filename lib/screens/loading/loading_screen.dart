import 'package:flutter/material.dart';
import 'package:tryve/components/logo.dart';
import 'package:tryve/components/system_theme_wrapper.dart';
import 'package:tryve/constants/constants.dart';
import 'package:tryve/helpers/nav_helper.dart';
import 'package:tryve/services/auth/auth_layer_screen.dart';

class LoadingScreen extends StatefulWidget {
  static String routeName = "/loading_screen";
  LoadingScreen({Key key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    _redirect(toHome: false);
  }

  void _redirect({bool toHome = true}) {
    Future.delayed(kRedirectDur).then((_) {
      replacePage(newPage: AuthLayerScreen.routeName, context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SystemThemeWrapper(
      child: Scaffold(
        body: Center(
          child: LogoWidget(
            height: 100,
          ),
        ),
      ),
    );
  }
}
