import 'package:bezier_chart/bezier_chart.dart';

const _GOALS = 6;

class ChartMock {
  static final fromDate = DateTime.now().subtract(Duration(days: 7));
  static final toDate = DateTime.now();

  static final date1 = DateTime.now().subtract(Duration(days: 1));
  static final date2 = DateTime.now().subtract(Duration(days: 2));
  static final date3 = DateTime.now().subtract(Duration(days: 5));

  static final List<DataPoint<DateTime>> data = [
    DataPoint<DateTime>(value: 2000, xAxis: date1),
    DataPoint<DateTime>(value: 2600, xAxis: date2),
    DataPoint<DateTime>(value: 1200, xAxis: date3),
  ];

  static final String value = "\$1,209.40";
  static final String desc = "Open , P&L (+709.50%)";

  static final Map<String, double> pieData = {
    "A": 6,
    "B": 2,
    "C": 2,
  };
}

class GoalsMock {
  static int count = _GOALS;
  static List<Goal> goals = List.generate(_GOALS, (index) {
    if (index.isEven) {
      return Goal(
        title: "Overflow the piggy bank",
        date: "$index/5/2021",
      );
    } else {
      return Goal(
        title: "Invest in the bank of piggy",
        date: "$index/5/2021",
      );
    }
  });
}

class Goal {
  final String title;
  final String date;

  Goal({this.title, this.date});
}

class SearchSectionMock {
  static List<String> images = List.generate(
      8, (index) => "https://source.unsplash.com/random/200x200?sig=$index");
}
