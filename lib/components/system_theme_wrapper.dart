import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tryve/theme/theme.dart';

class SystemThemeWrapper extends StatelessWidget {
  final Widget child;
  const SystemThemeWrapper({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: systemTheme,
      child: child,
    );
  }
}
