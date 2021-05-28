import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

class CommonLeading extends StatelessWidget {
  final Color color;
  const CommonLeading({Key key, this.color = Colors.white}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(
          PhosphorIcons.caret_left,
          color: color,
        ),
        onPressed: () => Navigator.of(context).pop());
  }
}
