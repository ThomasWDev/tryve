import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart' show CupertinoActivityIndicator;

class CommonLoader extends StatelessWidget {
  final double radius;
  final bool android;
  const CommonLoader({Key key, this.radius = 20, this.android = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (android) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.white),
        ),
      );
    }

    return CupertinoActivityIndicator(
      radius: radius,
    );
  }
}
