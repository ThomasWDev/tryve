import 'package:flutter/cupertino.dart' show CupertinoActivityIndicator;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LogoWidget extends StatelessWidget {
  final double height;

  const LogoWidget({
    Key key,
    this.height = 120,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      "images/logo_big.svg",
      height: height,
      placeholderBuilder: (context) {
        return CupertinoActivityIndicator(
          radius: height / 5,
        );
      },
    );
  }
}
