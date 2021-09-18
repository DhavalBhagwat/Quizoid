import 'dart:async';
import 'package:app/services/NavigationService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app/services/lib.dart';
import 'package:app/utils/lib.dart';

class DashboardActivity extends StatefulWidget {

  @override
  _DashboardActivityState createState() => _DashboardActivityState();

}

class _DashboardActivityState extends State<DashboardActivity> {

  static const String _TAG = "DashboardActivity";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
child:         TextButton(onPressed: () { NavigationService.getInstance.videoActivity(
  videoId: "VID0001",
  url: "https://assets.mixkit.co/videos/preview/mixkit-daytime-city-traffic-aerial-view-56-large.mp4"
); }, child: Text("VIDEO PRESS"),)
        ,      ),
    );
  }

}