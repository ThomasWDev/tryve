import 'package:firebase_auth/firebase_auth.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:tryve/services/api/models/goal_model.dart';

const _kObjName = "Goal";
final _goal = ParseObject(_kObjName);

class GoalAPI {
  static Future<ParseResponse> createGoal(GoalModel goal, String email) {
    _goal.set("title", goal.title);
    _goal.set("description", goal.description);
    _goal.set("startDate", goal.startDate);
    _goal.set("endDate", goal.endTime);
    _goal.set("by", email);

    return _goal.save();
  }

  static Future<ParseResponse> getGoals(User user) async {
    final query = QueryBuilder<ParseObject>(_goal)
      ..whereEqualTo('by', user.email);
    final response = await query.query();

    return response;
  }
}
