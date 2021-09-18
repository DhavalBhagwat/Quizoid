import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app/ui/widgets/lib.dart';
import 'package:app/utils/lib.dart';

class QuizActivity extends StatefulWidget {

  final String? videoId;
  final String? url;

  const QuizActivity({
    Key? key,
    this.videoId = "VID0001",
    this.url = "https://assets.mixkit.co/videos/preview/mixkit-daytime-city-traffic-aerial-view-56-large.mp4",
  }) : super(key: key);

  @override
  _QuizActivityState createState() => _QuizActivityState();

}

class _QuizActivityState extends State<QuizActivity> {

  static const _TAG = "QuizActivity";
  Logger _logger = Logger.getInstance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the QuizActivity object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Flutter Demo Home Page"),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 4,
              child: Container(color: AppTheme.lightBlue,),

            )

          ],
        ));
  }


  @override
  void dispose() {
    super.dispose();
  }

}
