import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizoid/services/lib.dart';
import 'package:quizoid/utils/lib.dart';

class ExitQuizDialog extends StatelessWidget {

  ExitQuizDialog({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppTheme.lightBackground,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Text(Strings.warning, style: TextStyle(fontSize: 22.0)),
          SizedBox(height: 16.0),
          Text(Strings.quit_quiz),
          SizedBox(height: 8.0),
          Row(
            children: [
              TextButton(
                child: Text(Strings.yes, style: TextStyle(color: AppTheme.colorAccent)),
                onPressed: () => NavigationService.getInstance.dashboardActivity(),
              ),
              Spacer(),
              TextButton(
                child: Text(Strings.no, style: TextStyle(color: AppTheme.colorAccent)),
                onPressed: () => Navigator.pop(context, true),
              )
            ],
          ),
        ],
      ),
    );
  }

}
