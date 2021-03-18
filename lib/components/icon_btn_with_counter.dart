import 'package:flutter/material.dart';

class IconBtnWithCounter extends StatelessWidget {
  const IconBtnWithCounter({
    Key key,
    @required this.icon,
    this.numOfitem = 0,
    this.radius = 46.0,
    @required this.press,
    this.iconColor = Colors.white,
    this.size = 24.0,
    this.top = -3.0,
  }) : super(key: key);

  final IconData icon;
  final int numOfitem;
  final GestureTapCallback press;
  final double radius;
  final Color iconColor;
  final double size;
  final double top;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: press,
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Container(
            padding: EdgeInsets.all(12),
            height: radius,
            width: radius,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: size,
            ),
          ),
          Positioned(
            top: top,
            left: 0,
            child: Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                color: Color(0xFFFF4848),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  "$numOfitem",
                  style: TextStyle(
                    fontSize: 10,
                    height: 1,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class IconWithCounter extends StatelessWidget {
  final IconData icon;
  final int numOfitem;
  final double radius;
  final Color iconColor;
  const IconWithCounter(
      {Key key, this.icon, this.numOfitem, this.radius, this.iconColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: [
        Container(
          padding: EdgeInsets.all(12),
          height: radius,
          width: radius,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: iconColor,
          ),
        ),
        if (numOfitem != 0)
          Positioned(
            top: 4,
            left: 4,
            child: Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                color: Color(0xFFFF4848),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  "$numOfitem",
                  style: TextStyle(
                    fontSize: 10,
                    height: 1,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
      ],
    );
  }
}
