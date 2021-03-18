import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:tryve/components/icon_btn_with_counter.dart';
import 'package:tryve/theme/palette.dart';

class CustomClipShape extends StatelessWidget {
  final double height;

  final Widget child;
  final Widget header;
  final Widget bottom;
  final double bottomPos;
  final double heightAdder;

  final double childDivider;
  final double appBarDivider;

  const CustomClipShape(
      {Key key,
      this.height = 400.0,
      this.child,
      this.header,
      this.bottom,
      this.bottomPos = 20,
      this.heightAdder = 0,
      this.childDivider = 1.8,
      this.appBarDivider = 3.8})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height + heightAdder,
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: ClipPathClass(),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: height,
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Palette.primaryDark,
                  Palette.mango,
                ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
              ),
            ),
          ),
          Positioned(
              top: 0,
              left: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  header != null
                      ? header
                      : Container(
                          height: height / appBarDivider,
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Spacer(),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 10,
                              ),
                              Text(
                                "TRYVE",
                                style: TextStyle(
                                    fontSize: 38,
                                    color: Colors.white,
                                    fontStyle: FontStyle.italic,
                                    letterSpacing: 6,
                                    fontWeight: FontWeight.w600),
                              ),
                              Spacer(),
                              IconBtnWithCounter(
                                icon: PhosphorIcons.chat,
                                press: () {},
                                numOfitem: 6,
                              )
                            ],
                          ),
                        ),
                  child != null
                      ? Container(
                          height: height / childDivider,
                          width: MediaQuery.of(context).size.width,
                          child: child)
                      : const SizedBox.shrink()
                ],
              )),
          bottom != null
              ? Positioned(
                  bottom: bottomPos,
                  left: 0,
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width, child: bottom))
              : Positioned(child: const SizedBox.shrink())
        ],
      ),
    );
  }
}

class ClipPathClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 30);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstPoint = Offset(size.width / 2, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstPoint.dx, firstPoint.dy);

    var secondControlPoint = Offset(size.width - (size.width / 4), size.height);
    var secondPoint = Offset(size.width, size.height - 30);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondPoint.dx, secondPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
