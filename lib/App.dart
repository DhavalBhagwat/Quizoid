import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:app/utils/lib.dart';
import 'package:app/navigation/lib.dart';

class App extends StatefulWidget {

  @override
  _App createState() => _App();

}

class _App extends State<App> {

  static const String _TAG = "App";
  final ThemeData theme = ThemeData();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      scrollBehavior: ScrollPhysicsBehaviour(),
      initialRoute: '/',
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