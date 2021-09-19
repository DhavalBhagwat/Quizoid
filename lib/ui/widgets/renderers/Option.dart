import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:app/data/controller/lib.dart';
import 'package:app/utils/lib.dart';

class Option extends StatelessWidget {

  final String? text;
  final int? index;
  final VoidCallback? onTap;

  const Option({
    Key? key,
    @required this.text,
    @required this.index,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionController>(
      init: QuestionController(),
      builder: (QuestionController controller) => InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            border: Border.all(color: AppTheme.grey),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            "${index! + 1}. $text",
            style: TextStyle(color: AppTheme.grey, fontSize: 16),
            overflow: TextOverflow.ellipsis,
            maxLines: 4,
          ),
        ),
      ),
    );
  }

}
