import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:bezier_chart/bezier_chart.dart';

const _GOALS = 6;

const kNumOfItem = 12;

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

class ChatMessages {
  List<ChatMessage> messages() => List.generate(
      kNumOfItem,
      (index) => ChatMessage(
          url: faker.image.image(),
          userName: faker.person.name(),
          message: faker.lorem.sentence(),
          date: faker.date.dateTime(),
          isPremium: index.isEven));
}

class ChatMessage {
  final String url;
  final String userName;
  final String message;
  final DateTime date;
  final bool isPremium;

  ChatMessage(
      {@required this.url,
      @required this.userName,
      @required this.message,
      @required this.date,
      @required this.isPremium});
}
