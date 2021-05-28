import 'package:flutter/material.dart';
import 'package:tryve/components/common_gradient_btn.dart';
import 'package:tryve/helpers/nav_helper.dart';
import 'package:tryve/screens/auth/auth_root.dart';
import 'package:tryve/screens/auth/reset_pass_screen.dart';
import 'package:tryve/theme/palette.dart';

class LinkSentScreen extends StatelessWidget {
  final String email;
  const LinkSentScreen({Key key, this.email}) : super(key: key);

  Widget _iconView() {
    return Container(
      width: 130,
      height: 130,
      child: Center(
        child: Icon(
          Icons.email,
          color: Palette.primary,
          size: 60,
        ),
      ),
      decoration: BoxDecoration(
        color: Palette.primary.withOpacity(0.15),
        borderRadius: BorderRadius.circular(28.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _iconView(),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              child: Text(
                "We hae sent a password reset link at ${email ?? "your email"} . You can find this in your inbox .",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            CommonGradientBtn(
              onTap: () {
                pushWidgetWhileRemove(
                    newPage: AuthRootScreen(), context: context);
              },
              label: "login now",
              width: 300,
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: () {
                  replaceWidget(
                      newPage: ResetPasswordScreen(
                        email: email,
                      ),
                      context: context);
                },
                child: Text(
                  "Try another email address",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ))
          ],
        ),
      ),
    );
  }
}
