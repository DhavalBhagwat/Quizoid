import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app/services/lib.dart';

class ExitQuizDialog extends StatelessWidget {

  ExitQuizDialog({
    Key? key
  });

  static const _TAG = "ExitQuizDialog";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: Text(
            "Are you sure you want to quit the quiz? All your progress will be lost."),
        title: Text("Warning!"),
        actions: <Widget>[
    FlatButton(
    child: Text("Yes"),
    onPressed: () {
    NavigationService.getInstance.dashboardActivity();
    },
    ),
    FlatButton(
    child: Text("No"),
    onPressed: () {

    Navigator.pop(context, true);
    },
    )]);
  }


}
