import 'dart:io';
import 'package:flutter/foundation.dart';

class UserModel {
  final String email;
  final String displayName;
  final String description;
  final bool social;
  final String socialImage;
  final File image;

  UserModel(
      {@required this.email,
      @required this.displayName,
      @required this.social,
      this.description,
      this.socialImage,
      this.image});
}
