import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizoid/ui/widgets/lib.dart';
import 'package:quizoid/data/controller/lib.dart';
import 'package:quizoid/utils/lib.dart';

class DashboardActivity extends StatefulWidget {

  DashboardActivity({
    Key? key
  }) : super(key: key);

  @override
  _DashboardActivityState createState() => _DashboardActivityState();

}

class _DashboardActivityState extends State<DashboardActivity> {

  static const String _TAG = "DashboardActivity";
  CategoryController? _controller;

  @override
  void initState() {
    _controller = Get.put(CategoryController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ActivityContainer(
        context: context,
        title: Strings.select_category,
        isBackAvailable: false,
        onBackPressed: () => Navigator.of(context).pop(),
        child: Obx(() => Container(
          color: AppTheme.colorPrimaryLight,
          child: _controller!.isLoading.value ? LoadingIndicator() : GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12.0,
              crossAxisSpacing: 12.0,
              childAspectRatio: 1.0,
            ),
            padding: EdgeInsets.all(16.0),
            physics: NeverScrollableScrollPhysics(),
            itemCount: _controller?.categoryList.length,
            itemBuilder: (BuildContext context, int index) => CategoryItem(category: _controller?.categoryList[index]),
          ),
        )),
    );
  }

}