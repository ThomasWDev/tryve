import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tryve/components/common_gradient_btn.dart';
import 'package:tryve/components/common_leading.dart';
import 'package:tryve/components/common_loading_overlay.dart';
import 'package:tryve/helpers/nav_helper.dart';
import 'package:tryve/helpers/string_helpers.dart';
import 'package:tryve/helpers/toast_helper.dart';
import 'package:tryve/screens/auth/link_sent_screen.dart';
import 'package:tryve/theme/palette.dart';

class ResetPasswordScreen extends StatefulWidget {
  static String routeName = "/reset_pass";

  final String email;
  const ResetPasswordScreen({
    Key key,
    this.email = '',
  }) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  bool _sending = false;
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.email,
    );
  }

  void _resetPass() async {
    setState(() {
      _sending = true;
    });

    if (_controller.text.isNotEmpty &&
        StringHelpers.isEmail(_controller.text)) {
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: _controller.text);

        toast("Link sent");
        replaceWidget(
            newPage: LinkSentScreen(
              email: _controller.text,
            ),
            context: context);
      } catch (e) {
        setState(() {
          _sending = false;
        });

        toast("Couldn't send link");
      }
    } else {
      setState(() {
        _sending = false;
      });
      toast("Enter a valid mail");
    }
  }

  Widget _input() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 4.0),
      decoration: BoxDecoration(
          color: Palette.background,
          border: Border.all(
            width: 2,
            color: Colors.grey.withOpacity(0.4),
          ),
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 40,
              offset: Offset(0.0, 2.0),
            )
          ]),
      child: TextField(
        autocorrect: false,
        controller: _controller,
        decoration: InputDecoration(
          hintText: "Email address",
          border: InputBorder.none,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonLoadingOverlay(
      loading: _sending,
      child: Scaffold(
        appBar: AppBar(
          leading: CommonLeading(
            color: Colors.black,
          ),
          elevation: 0.0,
          backgroundColor: Palette.background,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Reset password",
                style: GoogleFonts.montserrat().copyWith(
                  fontSize: 38,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Enter the email address associated with your account and we will send a link to your email to reset your password .",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              _input(),
              const SizedBox(
                height: 30,
              ),
              CommonGradientBtn(onTap: _resetPass, label: "send link"),
            ],
          ),
        ),
      ),
    );
  }
}
