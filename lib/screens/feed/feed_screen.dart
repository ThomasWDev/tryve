import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tryve/components/icon_btn_with_counter.dart';
import 'package:tryve/theme/palette.dart';

class FeedScreen extends StatefulWidget {
  static String routeName = "/feed";
  FeedScreen({Key key}) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen>
    with SingleTickerProviderStateMixin {
  List<int> _likes = [];

  ScrollController _scrollController = ScrollController();
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this,
        duration: Duration(
          milliseconds: 200,
        ),
        value: 1.0);

    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        _animationController.reverse();
      }
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        _animationController.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: RefreshIndicator(
              onRefresh: () async {},
              color: Palette.primary,
              child: CustomScrollView(
                controller: _scrollController,
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 18.0, top: 36.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ShaderMask(
                                shaderCallback: (bounds) => LinearGradient(
                                        colors: [
                                      Palette.primaryDark,
                                      Palette.mango,
                                    ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight)
                                    .createShader(Rect.fromLTWH(
                                        0, 0, bounds.width, bounds.height)),
                                child: Text(
                                  "My feed",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 32,
                                      letterSpacing: -1,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                "All of your personalised posts in all place",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                          IconBtnWithCounter(
                            icon: PhosphorIcons.heart,
                            press: () {},
                            iconColor: Colors.pink,
                            numOfitem: _likes.length,
                            size: 36,
                            top: 3,
                          )
                        ],
                      ),
                    ),
                  ),
                  SliverStaggeredGrid.countBuilder(
                    crossAxisCount: 4,
                    itemCount: 20,
                    itemBuilder: (BuildContext context, int index) =>
                        GestureDetector(
                      onTap: () {
                        if (_likes.contains(index)) {
                          setState(() {
                            _likes.remove(index);
                          });
                        } else {
                          setState(() {
                            _likes.add(index);
                          });
                        }
                      },
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: new Image.network(
                                "https://source.unsplash.com/random/200x200?sig=$index",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          _likes.contains(index)
                              ? Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: Colors.black.withOpacity(0.6),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      PhosphorIcons.thumbs_up,
                                      color: Colors.green,
                                      size: 40,
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink()
                        ],
                      ),
                    ),
                    staggeredTileBuilder: (int index) =>
                        new StaggeredTile.count(2, index.isEven ? 2 : 1),
                    mainAxisSpacing: 12.0,
                    crossAxisSpacing: 12.0,
                  )
                ],
              )),
        ),
      ),
      floatingActionButton: AnimatedFAB(
        controller: _animationController,
      ),
    );
  }
}

class AnimatedFAB extends StatelessWidget {
  final AnimationController controller;
  const AnimatedFAB({Key key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      child: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.white,
        child: IconWithCounter(
          icon: PhosphorIcons.chat,
          iconColor: Palette.primary,
          numOfitem: 6,
        ),
      ),
      builder: (BuildContext context, Widget child) {
        return Transform.scale(
          scale: controller.value,
          child: child,
        );
      },
    );
  }
}
