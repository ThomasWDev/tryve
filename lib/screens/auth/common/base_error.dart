import 'package:flutter/material.dart';

class BaseInputError extends StatelessWidget {
  final String error;
  const BaseInputError({Key key, @required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          error,
          style: TextStyle(
            color: Colors.red,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
