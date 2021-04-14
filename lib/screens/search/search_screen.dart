import 'package:flutter/material.dart';
import 'package:tryve/components/custom_clip_shape.dart';
import 'package:tryve/components/section_slider.dart';
import 'package:tryve/components/system_theme_wrapper.dart';
import 'package:tryve/screens/search/search_input.dart';

class SearchScreen extends StatefulWidget {
  static String routeName = "/search";
  SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SystemThemeWrapper(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              CustomClipShape(
                childDivider: 1,
                child: Column(
                  children: <Widget>[
                    SearchInput(),
                    const SizedBox(
                      height: 12,
                    ),
                    SectionSlider(
                      name: "Favorites",
                      style: titleStyle.copyWith(color: Colors.white),
                      buttonStyle:
                          buttonStyleBase.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              SectionSlider(
                name: "Trending now",
              ),
              SectionSlider(
                name: "Sponsored",
              ),
              SectionSlider(
                name: "Category",
              ),
              SectionSlider(
                name: "Fashion",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
