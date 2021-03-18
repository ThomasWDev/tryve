import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String label;
  final Color color;
  final double widthDivider;

  const AuthButton(
      {Key key,
      @required this.onPressed,
      this.icon,
      @required this.label,
      @required this.color,
      this.widthDivider = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Text text = Text(
      label,
      style: TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.w300),
    );

    return ButtonTheme(
      minWidth: MediaQuery.of(context).size.width / widthDivider,
      height: 44,
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        child: RaisedButton(
          color: color,
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
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
              side: BorderSide(color: color)),
        ),
      ),
    );
  }
}
