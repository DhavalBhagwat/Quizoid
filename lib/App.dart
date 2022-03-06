import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:quizoid/utils/lib.dart';
import 'package:quizoid/navigation/lib.dart';

class App extends StatefulWidget {

  @override
  _AppState createState() => _AppState();

}

class _AppState extends State<App> {

  static const String _TAG = "App";
  final ThemeData theme = ThemeData();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      scrollBehavior: ScrollPhysicsBehaviour(),
      initialRoute: '/dashboardActivity',
      getPages: Routes.routes,
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          primary: AppTheme.colorPrimary,
          primaryVariant: AppTheme.colorPrimaryDark,
          secondary: AppTheme.colorAccent,
        ),
      ),
    );
  }


}