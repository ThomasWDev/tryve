import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:tryve/helpers/nav_helper.dart';
import 'package:tryve/screens/verify/verify_sub_screen.dart';
import 'package:tryve/services/api/mock.dart';
import 'package:tryve/theme/palette.dart';

final TextStyle titleStyle =
    TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold);

final TextStyle buttonStyleBase = TextStyle(color: Palette.primary);

class VerifyScreenSlider extends StatelessWidget {
  final String name;
  final TextStyle style;
  final TextStyle buttonStyle;
  final List<String> images = SearchSectionMock.images;

  VerifyScreenSlider({
    Key key,
    @required this.name,
    this.style,
    this.buttonStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                name,
                style: style ?? titleStyle,
              ),
              TextButton(
                child: Text(
                  "See all",
                  style: buttonStyle ?? buttonStyleBase,
                ),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            height: 320,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Align(
                  alignment: Alignment.topCenter,
                  child: _VerifyScreenSliderView(
                    url: images[index],
                  ),
                );
              },
              itemCount: images.length,
            ),
          )
        ],
      ),
    );
  }
}

class _VerifyScreenSliderView extends StatelessWidget {
  final String url;
  const _VerifyScreenSliderView({
    Key key,
    @required this.url,
  }) : super(key: key);

  Widget _image() {
    return Stack(
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: Offset(0, 10),
                    blurRadius: 10)
              ],
              image:
                  DecorationImage(image: NetworkImage(url), fit: BoxFit.cover)),
        ),
        Positioned(
            top: 10,
            left: 10,
            child: Container(
              margin: const EdgeInsets.only(top: 6.0, right: 8.0),
              decoration: BoxDecoration(
                  color: Palette.primary,
                  borderRadius: BorderRadius.circular(100.0)),
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
              child: Text(
                "Recruting expires D-2",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            )),
        Positioned(
            bottom: 10,
            left: 10,
            child: Container(
              margin: const EdgeInsets.only(top: 6.0, right: 8.0),
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(100.0)),
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: Text(
                "10k steps",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ))
      ],
    );
  }

  Widget _info() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 12,
        ),
        Text(
          "Going to the gym",
          style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.w500,
              letterSpacing: -1),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Row(
              children: [
                Icon(
                  PhosphorIcons.star_fill,
                  color: Palette.mango,
                  size: 20,
                ),
                const SizedBox(
                  width: 6,
                ),
                Text(
                  "4.96",
                  style: TextStyle(
                      fontSize: 17, color: Colors.black.withOpacity(0.8)),
                )
              ],
            ),
            Row(
              children: [
                const SizedBox(
                  width: 6,
                ),
                CircleAvatar(
                  radius: 4,
                  backgroundColor: Colors.black.withOpacity(0.6),
                ),
                const SizedBox(
                  width: 6,
                ),
                Text(
                  "169 signed up",
                  style: TextStyle(
                      fontSize: 17, color: Colors.black.withOpacity(0.8)),
                )
              ],
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget _card(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(100.0)),
      child: Text(label),
    );
  }

  Widget _cards() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _card("27/07 - 08/09"),
        _card("2w"),
        _card("3D"),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => pushPageWidget(
          newPage: VerifySubScreen(
            image: url,
          ),
          context: context),
      child: Container(
        width: 220,
        margin: const EdgeInsets.only(right: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_image(), _info(), _cards()],
        ),
      ),
    );
  }
}
