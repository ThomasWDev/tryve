import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:tryve/theme/palette.dart';

class BaseInput extends StatefulWidget {
  final String label;
  final Widget icon;
  final bool isPassword;
  final bool isForm;
  final TextEditingController controller;
  BaseInput({
    Key key,
    @required this.label,
    this.icon,
    this.isPassword = false,
    this.isForm = false,
    this.controller,
  }) : super(key: key);

  @override
  _BaseInputState createState() => _BaseInputState();
}

class _BaseInputState extends State<BaseInput> {
  bool showPassword = false;

  @override
  void initState() {
    super.initState();
    showPassword = widget.isPassword;
  }

  Widget _passwordButton() {
    return GestureDetector(
      child: !showPassword
          ? Icon(
              PhosphorIcons.eye_slash,
              color: Palette.primary,
            )
          : Icon(
              PhosphorIcons.eye,
              color: Palette.primary,
            ),
      onTap: () {
        setState(() {
          showPassword = !showPassword;
        });
      },
    );
  }

  Widget _input() {
    final InputDecoration inputDecoration = InputDecoration(
      labelText: widget.label,
      suffix: widget.isPassword ? _passwordButton() : widget.icon,
    );

    if (widget.isForm) {
      return TextFormField(
        decoration: inputDecoration,
        obscureText: showPassword,
      );
    }

    return TextField(
      decoration: inputDecoration,
      obscureText: showPassword,
      controller: widget.controller ?? TextEditingController(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _input();
  }
}
