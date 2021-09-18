import 'dart:async';
import 'package:app/services/NavigationService.dart';
import 'package:app/ui/widgets/lib.dart';
import 'package:firebase_database/firebase_database.dart';
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
  late DatabaseReference _reference;


  @override
  void initState() {
    _db();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ActivityContainer(context: null,
    title: "",
    onBackPressed: () => Navigator.of(context).pop(),
    child: CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16.0, vertical: 8.0),
            child: Text(
              "Select a category to start the quiz",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0),
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.all(16.0),
          sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0),
              delegate: SliverChildBuilderDelegate(
                _buildCategoryItem,
                childCount: categories.length,
              )),
        ),
      ],
    ),);
  }

  void _db() async {
      _reference = FirebaseDatabase.instance.reference().child('categories');
     _reference.keepSynced(true);
      _reference.once().then((DataSnapshot data) => print(data.value));
   // _reference.onValue.listen((event) {Logger.getInstance.d(_TAG, "initState()", message: event.snapshot.value);});
   // Query needsSnapshot = FirebaseDatabase.instance.reference().child('categories');

 //   print(needsSnapshot.); // to debug and see if data is returned

    // List<Need> needs;
    //
    // Map<dynamic, dynamic> values = needsSnapshot.data.value;
    // values.forEach((key, values) {
    //   needs.add(values);
    // });
    //
    // return needs;
  }

  final List<Category> categories = [
    Category(9,"General Knowledge",),
    Category(10,"Books",),
    Category(11,"Film",),
    Category(12,"Music",),
    Category(13,"Musicals & Theatres",),
    Category(14,"Television",),
    Category(9,"General Knowledge",),
    Category(10,"Books",),
    Category(11,"Film",),
    Category(12,"Music",),
    Category(13,"Musicals & Theatres",),
    Category(14,"Television",),
  ];


}