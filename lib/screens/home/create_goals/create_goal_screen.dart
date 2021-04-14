import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:tryve/components/common_leading.dart';
import 'package:tryve/components/common_loading_overlay.dart';
import 'package:tryve/components/rounded_input.dart';
import 'package:tryve/helpers/nav_helper.dart';
import 'package:tryve/helpers/string_helpers.dart';
import 'package:tryve/helpers/toast_helper.dart';
import 'package:tryve/services/api/models/goal_model.dart';
import 'package:tryve/services/api/parse/goal_api/goal_api.dart';
import 'package:tryve/services/auth/auth_service.dart';
import 'package:tryve/theme/palette.dart';
import 'package:provider/provider.dart';

class CreateGoalScreen extends StatefulWidget {
  static String routeName = "/create_goal";
  CreateGoalScreen({Key key}) : super(key: key);

  @override
  _CreateGoalScreenState createState() => _CreateGoalScreenState();
}

class _CreateGoalScreenState extends State<CreateGoalScreen> {
  TextEditingController _title = TextEditingController();
  TextEditingController _description = TextEditingController();

  DateTime _from = DateTime.now();
  DateTime _to = DateTime.now().add(Duration(days: (365 * 5)));
  DateTimeRange _range;
  bool _loading = false;
  GoalModel goal;

  void _pickDate() async {
    final range = await showDateRangePicker(
        context: context, firstDate: _from, lastDate: _to);

    setState(() {
      _range = range;
    });
  }

  void _submit() async {
    if (_title.text.isNotEmpty && _range != null) {
      setState(() {
        _loading = true;
      });

      goal = GoalModel(
        title: _title.text,
        description: _description.text,
        startDate: _range.start,
        endTime: _range.end,
      );

      final user = context.read<AuthenticationService>().getUser();

      final response = await GoalAPI.createGoal(goal, user.email);

      setState(() {
        _loading = false;
      });

      if (response.success) {
        toast("Goal successfully added");
        pop(context);
      } else {
        print(response.error);
        toast("Couldn't add goal");
      }
    } else {
      toast("Fill all forms !");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CommonLeading(),
        brightness: Brightness.dark,
        elevation: 12.0,
        backgroundColor: Palette.primary,
        title: Text("Create a goal"),
        centerTitle: false,
      ),
      body: CommonLoadingOverlay(
        loading: _loading,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: RoundedInput(
                  controller: _title,
                  backgroundColor: Colors.grey.withOpacity(0.15),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: RoundedInput(
                  controller: _description,
                  backgroundColor: Colors.grey.withOpacity(0.15),
                  hint: "Description",
                  lines: 10,
                  icon: PhosphorIcons.text_align_justify,
                ),
              ),
              ListTile(
                title: Text(
                  "Pick date".toUpperCase(),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                subtitle: Text(
                  _range != null
                      ? "${StringHelpers.formatDate(_range.start)} - ${StringHelpers.formatDate(_range.end)}"
                      : "No dates picked",
                  style: TextStyle(color: Colors.black),
                ),
                onTap: _pickDate,
                trailing: _range != null
                    ? Icon(
                        PhosphorIcons.check_circle,
                        color: Colors.green,
                      )
                    : Icon(
                        PhosphorIcons.x_circle,
                        color: Colors.red,
                      ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Submit"),
        icon: Icon(PhosphorIcons.paper_plane_right),
        onPressed: _submit,
        backgroundColor: Palette.primary,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
