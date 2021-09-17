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


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        builder: EasyLoading.init(),
        debugShowCheckedModeBanner: false,
        scrollBehavior: ScrollPhysicsBehaviour(),
        initialRoute: '/',
        getPages: Routes.routes
    );

    //   Material(
    //   child: MaterialApp(
    //     builder: (context, child) {
    //       return ScrollConfiguration(
    //         behavior: ScrollPhysicsBehaviour(),
    //         child: child!,
    //       );
    //     },
    //     debugShowCheckedModeBanner: false,
    //     // theme: ThemeData(
    //     //     primaryColor: AppTheme.colorPrimary,
    //     //     primaryColorDark: AppTheme.colorPrimaryDark,
    //     //     accentColor: AppTheme.colorAccent
    //     // ),
    //     home: VideoActivity(),
    //     initialRoute: "/",
    //    // onGenerateRoute: RouteGenerator.generateRoute,
    //   ),
    // );
  }


}