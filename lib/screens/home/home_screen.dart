import 'package:bezier_chart/bezier_chart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:tryve/components/common_loader.dart';
import 'package:tryve/components/custom_clip_shape.dart';
import 'package:tryve/components/icon_btn_with_counter.dart';
import 'package:tryve/components/system_theme_wrapper.dart';
import 'package:tryve/helpers/nav_helper.dart';
import 'package:tryve/helpers/string_helpers.dart';
import 'package:tryve/screens/home/create_goals/create_goal_screen.dart';
import 'package:tryve/screens/upcoming_challenges/upcoming_challenges_screen.dart';
import 'package:tryve/services/api/mock.dart';
import 'package:tryve/services/api/parse/goal_api/goal_api.dart';
import 'package:tryve/services/auth/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:tryve/theme/palette.dart';
import 'package:tryve/theme/theme.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  User _user;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _user = context.read<AuthenticationService>().getUser();
  }

  GlobalKey _key = GlobalKey();

  List<Color> _pieColor(int order) {
    if (order == 0) {
      return [Colors.purple, Colors.green, Colors.red];
    } else if (order == 1) {
      return [Colors.green, Colors.red, Colors.purple];
    } else {
      return [Colors.red, Colors.green, Colors.purple];
    }
  }

  Widget _pieChart(String label, int order) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 30,
                offset: Offset(0.0, 5.0))
          ]),
      child: PieChart(
        dataMap: ChartMock.pieData,
        animationDuration: Duration(milliseconds: 800),
        chartRadius: 80,
        chartType: ChartType.ring,
        initialAngleInDegree: 0,
        ringStrokeWidth: 18,
        centerText: label,
        legendOptions: LegendOptions(showLegends: false),
        chartValuesOptions: ChartValuesOptions(
            showChartValueBackground: false,
            showChartValues: false,
            chartValueStyle: TextStyle(
                fontSize: 12, color: Colors.black, fontWeight: FontWeight.w400),
            showChartValuesOutside: false),
        colorList: _pieColor(order),
      ),
    );
  }

  Widget _pieCharts() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _pieChart("Category", 0),
        _pieChart("Difficulty", 1),
        _pieChart("Success", 2),
      ],
    );
  }

  Widget _chart() {
    return BezierChart(
      fromDate: ChartMock.fromDate,
      toDate: ChartMock.toDate,
      bezierChartScale: BezierChartScale.WEEKLY,
      selectedDate: ChartMock.toDate,
      series: [
        BezierLine(
            label: "\$",
            onMissingValue: (value) {
              if (value.day.isEven) {
                return 1400.0;
              }
              return 700.0;
            },
            data: ChartMock.data,
            dataPointFillColor: Palette.primary,
            lineColor: Palette.primary)
      ],
      config: BezierChartConfig(
          verticalIndicatorStrokeWidth: 3.0,
          verticalIndicatorColor: Palette.primary,
          showVerticalIndicator: true,
          verticalIndicatorFixedPosition: false,
          backgroundColor: Colors.white,
          startYAxisFromNonZeroValue: true,
          updatePositionOnTap: true,
          displayLinesXAxis: true,
          xAxisTextStyle: TextStyle(color: Colors.black, fontSize: 10),
          bubbleIndicatorColor: Palette.darkCard,
          bubbleIndicatorValueStyle: TextStyle(color: Colors.white),
          physics: BouncingScrollPhysics()),
    );
  }

  Widget _chartBox() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: Offset(0, 5.0),
                blurRadius: 40)
          ]),
      child: Stack(
        children: <Widget>[
          _chart(),
          Positioned(
            top: 0,
            left: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  ChartMock.value,
                  style: commonBoldStyle.copyWith(
                    fontSize: 28,
                  ),
                ),
                Text(
                  ChartMock.desc,
                  style: commonBoldStyle.copyWith(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _goalsHeader(int count) {
    return ListTile(
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
        numOfitem: count,
        iconColor: Colors.grey,
      ),
    );
  }

  Widget _goalsList() {
    return FutureBuilder(
      future: GoalAPI.getGoals(_user),
      builder: (context, AsyncSnapshot<ParseResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.success) {
            if (snapshot.data.result != null) {
              return Column(
                children: [
                  _goalsHeader((snapshot.data.results).length),
                  Column(
                    children: (snapshot.data.result as List<dynamic>)
                        .map((goal) => _GoalCard(goal: goal))
                        .toList(),
                  ),
                ],
              );
            } else {
              return const SizedBox.shrink();
            }
          } else {
            return const SizedBox.shrink();
          }
        } else {
          return SizedBox(
            height: 200,
            child: CommonLoader(),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SystemThemeWrapper(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              CustomClipShape(
                key: _key,
                child: _chartBox(),
                bottom: _pieCharts(),
                bottomPos: 20,
                heightAdder: 90,
              ),
              _goalsList(),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: "Add a goal",
          child: Icon(PhosphorIcons.plus),
          onPressed: () {
            pushPageAwait(newPage: CreateGoalScreen.routeName, context: context)
                .then((_) {
              setState(() {});
            });
          },
          backgroundColor: Palette.primary,
        ),
      ),
    );
  }
}

class _GoalCard extends StatelessWidget {
  final dynamic goal;
  const _GoalCard({Key key, @required this.goal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => pushPage(
          newPage: UpcomingChallengesScreen.routeName, context: context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  offset: Offset(0.0, 2.0),
                  blurRadius: 20)
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  goal['title'],
                  style: TextStyle(
                      fontSize: 22,
                      color: Palette.primaryDark,
                      letterSpacing: -1),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  "${StringHelpers.formatDate(goal['startDate'])} - ${StringHelpers.formatDate(goal['endDate'])}",
                  style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
                ),
              ],
            ),
            IconButton(
              icon: Icon(
                PhosphorIcons.dots_three_vertical,
              ),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
