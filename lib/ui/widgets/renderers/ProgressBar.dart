import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:quizoid/data/controller/lib.dart';
import 'package:quizoid/utils/lib.dart';

class ProgressBar extends StatelessWidget {

  const ProgressBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 20,
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.colorAccent, width: 1),
        borderRadius: BorderRadius.circular(50),
      ),
      child: GetBuilder<QuestionController>(
        init: QuestionController(),
        builder: (controller) {
          return Stack(
            children: [
              LayoutBuilder(
                builder: (context, constraints) => Container(
                  width: constraints.maxWidth * controller.animation?.value,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppTheme.grey, AppTheme.darkGrey],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              Positioned.fill(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0 / 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${(controller.animation?.value * 5).round()} sec",
                        style: TextStyle(fontSize: 12.0, color: AppTheme.nearlyWhite),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

}
