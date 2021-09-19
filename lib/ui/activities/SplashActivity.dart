import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app/services/lib.dart';
import 'package:app/utils/lib.dart';

class SplashActivity extends StatefulWidget {

  @override
  _SplashActivityState createState() => _SplashActivityState();

}

class _SplashActivityState extends State<SplashActivity> {

  static const String _TAG = "SplashActivity";

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () async {
      NavigationService.getInstance.dashboardActivity();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightRed,
      body: Container(),
    );
  }

}
