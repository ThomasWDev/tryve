import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String label;
  final Color color;
  final double widthDivider;
  final double height;
  final TextStyle style;

  const AuthButton(
      {Key key,
      @required this.onPressed,
      this.icon,
      @required this.label,
      @required this.color,
      this.style,
      this.height = 44,
      this.widthDivider = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Text text = Text(
      label,
      style: style ??
          TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w300),
    );

    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: ConstrainedBox(
        constraints: BoxConstraints.tightFor(
            width: MediaQuery.of(context).size.width, height: height),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: color,
              onPrimary: color,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  side: BorderSide(color: color))),
          onPressed: onPressed,
          child: icon != null
              ? Row(
                  children: <Widget>[
                    Icon(
                      icon,
                      color: Colors.white,
                      size: 16,
                    ),
                    Spacer(),
                    text,
                    Spacer(),
                  ],
                )
              : text,
        ),
      ),
    );
  }
}
