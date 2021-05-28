import 'package:flutter/material.dart';
import 'package:tryve/theme/palette.dart';

class CommonChatAvar extends StatelessWidget {
  final String url;
  final bool isActive;
  final double radius;
  final double activeRadius;

  const CommonChatAvar({
    Key key,
    @required this.url,
    this.isActive = false,
    this.radius = 40,
    this.activeRadius = 8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(url),
          radius: radius,
          backgroundColor: Palette.primary,
        ),
        isActive
            ? Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: CircleAvatar(
                    radius: activeRadius,
                    backgroundColor: Colors.green,
                  ),
                ))
            : const SizedBox.shrink()
      ],
    );
  }
}
