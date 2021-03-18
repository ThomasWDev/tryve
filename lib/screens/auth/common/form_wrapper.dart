import 'package:flutter/material.dart';

class FormWrapper extends StatelessWidget {
  final Widget child;
  const FormWrapper({Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: Offset(0.0, 8.0),
                blurRadius: 30)
          ]),
      child: child,
    );
  }
}
