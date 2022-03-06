import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizoid/data/podos/lib.dart';
import 'package:quizoid/utils/lib.dart';
import 'package:quizoid/ui/widgets/lib.dart';
import 'package:quizoid/services/lib.dart';
import 'package:quizoid/data/controller/lib.dart';
import 'package:quizoid/services/lib.dart';

class QuizActivity extends StatefulWidget {

  const QuizActivity({
    Key? key,
  }) : super(key: key);

  @override
  _QuizActivityState createState() => _QuizActivityState();

}

class _QuizActivityState extends State<QuizActivity> {

  static const _TAG = "QuizActivity";
  VideoCategory? _category;
  late QuestionController _controller;
  bool _isList = true;

  @override
  void initState() {
    _category = Get.arguments["category"];
    _controller = Get.put(QuestionController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ActivityContainer(
      context: context,
      action: _viewSwitch(context),
      onBackPressed: () => DialogService.getInstance.exitQuizDialog(),
      title: _category!.name + " " + Strings.quiz,
      child: Obx(() => _controller.isLoading.value ? LoadingIndicator() : _buildQuizForm(context)
      )
    );
  }

  Widget _viewSwitch(BuildContext context) => IconButton(
    icon: Icon(
      !_isList ? Icons.dashboard : Icons.view_agenda,
      size: 24.0,
    ),
    color: AppTheme.colorAccent,
    onPressed: () {
      setState(() => _isList = !_isList);
      },
  );

  Widget _buildQuizForm(BuildContext context) => Container(
    color: AppTheme.colorPrimaryLight,
    child: Column(
      children: [
        Padding(
          padding: EdgeInsets.all(20.0),
          child: ProgressBar(),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text.rich(
            TextSpan(
              text: "Question ${_controller.questionNumber.value}",
              children: [
                TextSpan(
                  text: "/${_controller.questions.length}",
                ),
              ],
            ),
          ),
        ),
        Divider(thickness: 1.5),
        Expanded(
          flex: 2,
          child: PageView.builder(
            physics: NeverScrollableScrollPhysics(),
            controller: _controller.pageController,
            onPageChanged: _controller.updateQuestionNum,
            itemCount: _controller.questions.length,
            itemBuilder: (context, index) => QuestionCard(question: _controller.questions[index], isList: _isList),
          ),
        ),
      ],
    ),
  );

}