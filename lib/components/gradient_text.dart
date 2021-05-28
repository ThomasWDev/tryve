import 'package:flutter/material.dart';

class GradientText extends StatelessWidget {
  final List<Color> colors;
  final String text;
  final TextStyle style;
  const GradientText(
      {Key key,
      @required this.colors,
      @required this.text,
      @required this.style})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
              colors: colors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight)
          .createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
      child: Text(
        text,
        style: style,
      ),
    );
  }
}
