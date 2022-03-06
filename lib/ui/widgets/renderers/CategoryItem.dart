import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizoid/data/podos/lib.dart';
import 'package:quizoid/services/lib.dart';
import 'package:quizoid/utils/lib.dart';

class CategoryItem extends StatelessWidget {

  final VideoCategory? category;

  const CategoryItem({
    @required this.category,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 1.0,
      highlightElevation: 1.0,
      onPressed: () => NavigationService.getInstance.videoActivity(category!),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      color: AppTheme.colorAccent,
      textColor: AppTheme.nearlyWhite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            category!.name,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

}
