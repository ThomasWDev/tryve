import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:tryve/components/auth_button.dart';
import 'package:tryve/components/common_loading_overlay.dart';
import 'package:tryve/components/logo.dart';
import 'package:tryve/screens/auth/common/base_error.dart';
import 'package:tryve/screens/auth/common/base_input.dart';
import 'package:tryve/screens/auth/common/form_wrapper.dart';
import 'package:tryve/services/auth/auth_service.dart';
import 'package:tryve/theme/palette.dart';
import 'package:tryve/theme/theme.dart';
import 'package:provider/provider.dart';

class SigninScreen extends StatefulWidget {
  final PageController controller;
  SigninScreen({Key key, this.controller}) : super(key: key);

  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  bool _emailError = false;
  bool _passwordError = false;
  bool _loggingIn = false;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void _toForgotPass() {}

  void _formReset() {
    setState(() {
      _loggingIn = true;
      _emailError = false;
      _passwordError = false;
    });
  }

  void _emailLogin() {
    _formReset();

    context
        .read<AuthenticationService>()
        .signIn(
            email: _emailController.text,
            password: _passwordController.text,
            onError: (e) {
              if (AuthenticationErrors.signInEmailError(e)) {
                setState(() {
                  _emailError = true;
                });
              }

              if (AuthenticationErrors.signInPasswordError(e)) {
                setState(() {
                  _passwordError = true;
                });
              }

              setState(() {
                _loggingIn = false;
              });
            })
        .then((success) async {
      if (success) {
        setState(() {
          _loggingIn = false;
        });
      }
    });
  }

  void _googleLogin() {
    _formReset();

    context.read<AuthenticationService>().signInWithGoogle(onError: () {
      setState(() {
        _loggingIn = false;
      });
    }).then((success) async {
      if (success) {
        await context.read<AuthenticationService>().getParseUserID();
        setState(() {
          _loggingIn = false;
        });
      }
    });
  }

  void _toSignUp() => widget.controller
      .nextPage(curve: Curves.easeIn, duration: Duration(milliseconds: 300));

  Widget _form() {
    return FormWrapper(
      child: Column(
        children: <Widget>[
          Text(
            "Hello",
            style: commonBoldStyle.copyWith(
              fontSize: 32,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Login to your account",
            style: commonBoldStyle.copyWith(
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 12),
          BaseInput(
            label: "Email ID *",
            icon: Icon(
              PhosphorIcons.at,
              color: Palette.primary,
            ),
            controller: _emailController,
          ),
          _emailError
              ? BaseInputError(
                  error: "User with this email not found !",
                )
              : const SizedBox.shrink(),
          BaseInput(
            label: "Password *",
            isPassword: true,
            controller: _passwordController,
          ),
          _passwordError
              ? BaseInputError(
                  error: "Wrong password",
                )
              : const SizedBox.shrink(),
          const SizedBox(height: 8),
          Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                  onTap: _toForgotPass,
                  child: Text(
                    "Forgot your password",
                    style: commonBoldStyle.copyWith(
                        color: Colors.grey,
                        fontSize: 13.5,
                        fontWeight: FontWeight.w400),
                  ))),
          const SizedBox(height: 30),
          AuthButton(
              onPressed: _emailLogin, label: "Login", color: Palette.primary),
          Text(
            "OR",
            style: commonBoldStyle.copyWith(
                color: Colors.grey,
                fontSize: 13.5,
                fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 8),
          AuthButton(
              onPressed: () {},
              label: "Facebook",
              color: Palette.fbBlue,
              icon: PhosphorIcons.facebook_logo),
          AuthButton(
            onPressed: _googleLogin,
            label: "Google",
            color: Palette.googleRed,
            icon: PhosphorIcons.google_logo,
          ),
        ],
      ),
    );
  }

  Widget _signUpText() {
    return TextButton(
      onPressed: _toSignUp,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "Don't have an account ? ",
            style: commonBoldStyle.copyWith(
              fontSize: 14.5,
            ),
          ),
          Text(
            "Sign up now ",
            style: commonBoldStyle.copyWith(
                fontSize: 14.5,
                decoration: TextDecoration.underline,
                color: Palette.primary),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommonLoadingOverlay(
        loading: _loggingIn,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[LogoWidget(), _form(), _signUpText()],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
