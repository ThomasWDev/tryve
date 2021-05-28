import 'package:firebase_auth/firebase_auth.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

const _kObjName = "Goal";
final _goal = ParseObject(_kObjName);

class GoalAPI {
  static Future<ParseResponse> allGoals() {
    return _goal.getAll();
  }

  static Future<ParseResponse> getGoals(String cat) async {
    final query = QueryBuilder<ParseObject>(_goal)..whereEqualTo('type', cat);
    final response = await query.query();

    return response;
  }

  static Future<ParseResponse> getGoalById(String id) {
    return _goal.getObject(id);
  }

  static Future<dynamic> getUserGoals() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    final _user = ParseObject("Person");
    final query = QueryBuilder<ParseObject>(_user)
      ..whereEqualTo('email', _auth.currentUser.email);
    final response = await query.query();

    if (response.success) {
      final data = response.result[0]['goals'];
      if (data == null) {
        return [];
      } else {
        return data;
      }
    } else {
      return [];
    }
  }
}
