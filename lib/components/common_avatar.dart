import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:tryve/theme/palette.dart';

class CommonAvatar extends StatelessWidget {
  final double radius;
  final bool showBorder;
  final String url;
  const CommonAvatar(
      {Key key, this.radius = 70, this.showBorder = true, this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: showBorder
              ? Border.all(
                  color: Colors.white,
                  width: 5,
                )
              : Border.all(width: 0, color: Colors.transparent),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: Offset(0.0, 8.0),
                blurRadius: 40)
          ]),
      child: url != null
          ? CircleAvatar(
              backgroundImage: NetworkImage(url),
              backgroundColor: Palette.primary,
              radius: radius,
            )
          : CircleAvatar(
              backgroundColor: Colors.white,
              radius: radius,
              child: Center(
                child: Icon(
                  PhosphorIcons.user,
                  color: Colors.black,
                  size: 50,
                ),
              ),
            ),
    );
  }
}
