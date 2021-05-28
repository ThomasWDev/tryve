import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:bezier_chart/bezier_chart.dart';

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

class AuthenticationMehodMocks {
  static List<String> images = [
    "https://source.unsplash.com/xXofYCc3hqc/200x200/",
    "https://source.unsplash.com/gcqXcSYNmhk/200x200/",
    "https://source.unsplash.com/0UjcyAvHc-4/200x200/",
    "https://source.unsplash.com/ObQC-0wf2JE/200x200/",
    "https://source.unsplash.com/lj1cQ2gv4wE/200x200/",
    "https://source.unsplash.com/650MB7-RURY/200x200/",
  ];

  static String bodyText = """
  - 2021.8.24(Mon) - 2017.8.27(Thurs) Abs Photo Authentication
  - Abs Recognition comment on the authentication shot has more 'APPROVE then OPPOSE will consider success

  * You will not be able to participate in this challenge among successful participants who made abs in july.

  * Those who successeded more than 2 times in the abs Challenge you will not be able to participate

  * Pictures posted before te last week of August will noot be processed .

  * The time of comment is 8/28(Friday) 9 o'clock will result announced 8/29(Sat) Day 12:30
  """;

  static String footerText = """
  Authentication available day

  Authentication frequency\t\t\tUntil 8:30 time

  Authentication time available\t\t\t 24hrs

  number of auth / day\t\t\t 1 time

  Authentication interval\t\t\t No limits

  Photobooks available\t\t\t Impossible
  
  Certified shot release\t\t\t released/public
  """;
}
