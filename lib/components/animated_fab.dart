import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:tryve/helpers/nav_helper.dart';
import 'package:tryve/screens/message/message_screen.dart';
import 'package:tryve/theme/palette.dart';

class AnimatedFAB extends StatelessWidget {
  final AnimationController controller;
  final VoidCallback onPressed;

  final Color backgroundColor;
  final Icon icon;

  const AnimatedFAB(
      {Key key,
      @required this.controller,
      this.onPressed,
      this.backgroundColor,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      child: FloatingActionButton(
        onPressed: onPressed ??
            () => pushPage(newPage: MessageScreen.routeName, context: context),
        backgroundColor: backgroundColor ?? Colors.white,
        child: icon ??
            Icon(
              PhosphorIcons.plus,
              color: Palette.primary,
            ),
      ),
      builder: (BuildContext context, Widget child) {
        return Transform.scale(
          scale: controller.value,
          child: child,
        );
      },
    );
  }
}
