import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:tryve/components/auth_button.dart';
import 'package:tryve/helpers/nav_helper.dart';
import 'package:tryve/screens/verify/authentication_method_screen.dart';
import 'package:tryve/theme/palette.dart';

const double h = 220;

class CompleteVerificationScreen extends StatelessWidget {
  static String routeName = "/complete_verification";
  const CompleteVerificationScreen({Key key}) : super(key: key);

  Widget _text() {
    final base = TextStyle(
      fontSize: 26,
      color: Colors.black,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      child: Column(
        children: [
          Text(
            "Authentication Complete !",
            style: base.copyWith(color: Palette.primary),
          ),
          Text(
            "Isn't it easy to verify ?",
            style: base,
          ),
        ],
      ),
    );
  }

  Widget _check() {
    return Container(
      width: h,
      height: h,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Palette.primaryDark, Palette.primary, Palette.mango],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 40,
                offset: Offset(0.0, 8.0))
          ]),
      child: Center(
        child: Icon(
          PhosphorIcons.check_bold,
          size: 120,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _btn(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 38,
      ),
      child: AuthButton(
          onPressed: () => pushPage(
              newPage: AuthenticationMethodScreen.routeName, context: context),
          label: "Complete",
          color: Palette.primary),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [_check(), _text(), _btn(context)],
        ),
      ),
    );
  }
}
