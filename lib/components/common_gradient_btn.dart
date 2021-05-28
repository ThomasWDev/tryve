import 'package:flutter/material.dart';

class CommonGradientBtn extends StatelessWidget {
  final String label;
  final double width;
  final double height;
  final VoidCallback onTap;
  const CommonGradientBtn({
    Key key,
    @required this.onTap,
    @required this.label,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        height: height ?? 60,
        width: width ?? MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFff0f7b),
              Color(0xFFf89b29),
            ],
          ),
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.18),
                offset: Offset(0.0, 8.0),
                blurRadius: 40,
                spreadRadius: 20),
          ],
        ),
        child: Center(
          child: Text(
            label.toUpperCase(),
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
