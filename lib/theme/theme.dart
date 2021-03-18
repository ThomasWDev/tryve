import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tryve/theme/palette.dart';

final globalTheme = ThemeData(
  primaryColor: Palette.primary,
  scaffoldBackgroundColor: Palette.background,
  visualDensity: VisualDensity.adaptivePlatformDensity,
);

final TextStyle commonBoldStyle = TextStyle(
  fontWeight: FontWeight.bold,
  letterSpacing: -1,
  fontSize: 16,
);

final systemTheme =
    SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent);
