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

class SignupScreen extends StatefulWidget {
  final PageController controller;
  SignupScreen({Key key, this.controller}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _agree = true;

  bool _emailError = false;
  bool _passwordError = false;
  bool _signingUp = false;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void _viewTerms() {}

  void _toSignIn() => widget.controller.previousPage(
      curve: Curves.easeIn, duration: Duration(milliseconds: 300));

  void _formReset() {
    setState(() {
      _signingUp = true;
      _emailError = false;
      _passwordError = false;
    });
  }

  void _register() {
    _formReset();

    context
        .read<AuthenticationService>()
        .signUp(
          email: _emailController.text,
          password: _passwordController.text,
          onError: (e) {
            if (AuthenticationErrors.registerEmailError(e)) {
              setState(() {
                _emailError = true;
              });
            }

            if (AuthenticationErrors.registerPasswordError(e)) {
              setState(() {
                _passwordError = true;
              });
            }

            setState(() {
              _signingUp = false;
            });
          },
        )
        .then((success) {
      if (success) {
        setState(() {
          _signingUp = false;
        });
      }
    });
  }

  void _googleLogin() {
    _formReset();

    context.read<AuthenticationService>().signInWithGoogle(onError: () {
      setState(() {
        _signingUp = false;
      });
    }).then((success) {
      if (success) {
        setState(() {
          _signingUp = false;
        });
      }
    });
  }

  Widget _terms() {
    return Align(
        alignment: Alignment.centerLeft,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 22.0,
              height: 22.0,
              child: Checkbox(
                value: _agree,
                onChanged: (value) {
                  setState(() {
                    _agree = !_agree;
                  });
                },
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Row(
              children: <Widget>[
                Text(
                  "I read and agree to ",
                  style: commonBoldStyle.copyWith(
                      color: Colors.grey,
                      letterSpacing: -1,
                      fontSize: 14.5,
                      fontWeight: FontWeight.w400),
                ),
                GestureDetector(
                    onTap: _viewTerms,
                    child: Text(
                      "Terms of Service",
                      style: commonBoldStyle.copyWith(
                          color: Palette.primary,
                          letterSpacing: -1,
                          fontSize: 14.5,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.underline),
                    )),
              ],
            )
          ],
        ));
  }

  Widget _form() {
    return FormWrapper(
      child: Column(
        children: <Widget>[
          Text(
            "Create Account",
            style: commonBoldStyle.copyWith(
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 12),
          BaseInput(
            label: "User Name *",
            icon: Icon(
              PhosphorIcons.at,
              color: Palette.primary,
            ),
          ),
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
                  error: "Email ID already in use",
                )
              : const SizedBox.shrink(),
          BaseInput(
            label: "Password *",
            isPassword: true,
            controller: _passwordController,
          ),
          _passwordError
              ? BaseInputError(
                  error: "Weak password",
                )
              : const SizedBox.shrink(),
          const SizedBox(height: 16),
          _terms(),
          const SizedBox(height: 30),
          AuthButton(
              onPressed: _register,
              label: "Register now",
              color: Palette.primary),
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
            icon: PhosphorIcons.facebook_logo,
          ),
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
    return FlatButton(
      onPressed: _toSignIn,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "Have an account ? ",
            style: commonBoldStyle.copyWith(
              fontSize: 14.5,
            ),
          ),
          Text(
            "Login now ",
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
        loading: _signingUp,
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
