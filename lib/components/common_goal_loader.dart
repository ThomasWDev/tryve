import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tryve/components/icon_btn_with_counter.dart';
import 'package:tryve/theme/palette.dart';

class CommonGoalLoader extends StatelessWidget {
  final Color baseColor;
  final Color highlightColor;

  const CommonGoalLoader({Key key, this.baseColor, this.highlightColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Shimmer.fromColors(
        baseColor: baseColor != null
            ? baseColor
            : Theme.of(context).scaffoldBackgroundColor,
        highlightColor:
            highlightColor != null ? highlightColor : Colors.grey.shade300,
        enabled: true,
        child: Container(
          decoration: BoxDecoration(
            color:
                highlightColor != null ? highlightColor : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(6.0),
          ),
        ),
      ),
    );
  }
}

class CommonGoalLoaderSection extends StatelessWidget {
  final Color baseColor;
  final Color highlightColor;
  const CommonGoalLoaderSection({Key key, this.baseColor, this.highlightColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 284,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          Shimmer.fromColors(
            baseColor: baseColor != null
                ? baseColor
                : Theme.of(context).scaffoldBackgroundColor,
            highlightColor:
                highlightColor != null ? highlightColor : Colors.grey.shade300,
            enabled: true,
            child: ListTile(
              title: Text(
                "Your Goal List :",
                style: TextStyle(
                    fontSize: 22,
                    color: Palette.darkTextShade1,
                    fontWeight: FontWeight.w500),
              ),
              trailing: IconBtnWithCounter(
                icon: PhosphorIcons.list,
                press: () {},
                numOfitem: 10,
                iconColor: Colors.grey,
              ),
            ),
          ),
          CommonGoalLoader(),
          CommonGoalLoader(),
          CommonGoalLoader(),
        ],
      ),
    );
  }
}
