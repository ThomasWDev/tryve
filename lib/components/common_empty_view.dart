import 'package:flutter/material.dart';

class CommonEmptyView extends StatelessWidget {
  final String message;
  const CommonEmptyView({Key key, this.message = "Empty here"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          'images/no-data.png',
          height: MediaQuery.of(context).size.height / 3,
        ),
        const SizedBox(
          height: 12,
        ),
        Text(
          message,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Colors.black.withOpacity(0.7),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }
}
