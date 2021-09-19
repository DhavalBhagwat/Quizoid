import 'package:app/services/lib.dart';
import 'package:app/ui/widgets/lib.dart';
import 'package:app/utils/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ScoreActivity extends StatefulWidget {

  ScoreActivity({
    Key? key,
  }) : super(key: key);

  @override
  _ScoreActivityState createState() => _ScoreActivityState();

}

class _ScoreActivityState extends State<ScoreActivity> {

  List<Map<int, int>>? _answersMap;
  int? _correctAns, _length;

  @override
  void initState() {
    _answersMap = Get.arguments["answersMap"];
    _correctAns = Get.arguments["correctAns"];
    _length = Get.arguments["length"];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(_answersMap.toString());
    return ActivityContainer(
        context: context,
        onBackPressed: () => NavigationService.getInstance.dashboardActivity(),
        isBackAvailable: false,
        title: Strings.score,
        child: Container(
          color: AppTheme.colorPrimaryLight,
          padding: EdgeInsets.all(16.0),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _answersMap!.isNotEmpty ? DataTable(
                decoration: BoxDecoration(border: Border.all(color: AppTheme.nearlyBlack, width: 1)),
                columns: [
                  DataColumn(label: Text("Question No.")),
                  DataColumn(label: Text("Time Taken")),
                ],
                rows: _answersMap!.map((element) => DataRow(
                  cells: <DataCell>[
                    DataCell(Text(element.keys.toString())),
                    DataCell(Text("${element.values.toString().replaceAll("(", "").replaceAll(")", "")} sec")),
                  ],
                )).toList(),
              ) : Text(
                Strings.no_questions_answered,
                style: TextStyle(fontSize: 20),
              ),
              Spacer(flex: 1),
              Text(
                "Total Score : ${_correctAns! * 10}/${_length! * 10}",
                style: TextStyle(fontSize: 20),
              ),
              Spacer(flex: 3),
              TextButton(
                onPressed: () => NavigationService.getInstance.dashboardActivity(),
                child: Text(Strings.go_back),
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(AppTheme.nearlyBlack),
                  backgroundColor: MaterialStateProperty.all<Color>(AppTheme.colorPrimaryDark),
                ),
              ),
              Spacer(flex: 3),
            ],
          ),
        ),
    );
  }

}
