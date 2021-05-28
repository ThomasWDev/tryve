import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tryve/theme/palette.dart';

ThemeData globalTheme(BuildContext context) => ThemeData(
      primaryColor: Palette.primary,
      scaffoldBackgroundColor: Palette.background,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );

final TextStyle commonBoldStyle = TextStyle(
    fontWeight: FontWeight.bold,
    letterSpacing: -1,
    fontSize: 16,
    color: Colors.black);

final TextStyle tryveHeader = TextStyle(
    fontSize: 38,
    color: Colors.white,
    fontStyle: FontStyle.italic,
    letterSpacing: 6,
    fontWeight: FontWeight.w600);

final systemTheme =
    SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent);
