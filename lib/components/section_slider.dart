import 'package:flutter/material.dart';
import 'package:tryve/services/api/mock.dart';
import 'package:tryve/theme/palette.dart';

final TextStyle titleStyle =
    TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold);

final TextStyle buttonStyleBase = TextStyle(color: Palette.primary);

class SectionSlider extends StatelessWidget {
  final String name;
  final TextStyle style;
  final TextStyle buttonStyle;
  final List<String> images = SearchSectionMock.images;

  SectionSlider({
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
              FlatButton(
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
            height: 160,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Align(
                  alignment: Alignment.topCenter,
                  child: ImageView(
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

class ImageView extends StatelessWidget {
  final String url;
  const ImageView({
    Key key,
    @required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 140,
      margin: const EdgeInsets.only(right: 12.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: Offset(0, 10),
                blurRadius: 10)
          ],
          image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover)),
    );
  }
}
