import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app/data/podos/lib.dart';
import 'package:app/utils/lib.dart';
import 'package:app/ui/widgets/lib.dart';
import 'package:app/services/DialogService.dart';
import 'package:app/data/controller/lib.dart';
import 'package:app/services/lib.dart';

class QuizActivity extends StatefulWidget {

  const QuizActivity({
    Key? key,
  }) : super(key: key);

  @override
  _QuizActivityState createState() => _QuizActivityState();

}

class _QuizActivityState extends State<QuizActivity> {

  static const _TAG = "QuizActivity";
  Logger _logger = Logger.getInstance;
  VideoCategory? _category;
  late QuestionController _controller;

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
      onBackPressed: () => DialogService.getInstance.exitQuizDialog(),
      title: _category!.name + " " + Strings.quiz,
      child: Obx(() => _controller.isLoading.value ? LoadingIndicator() : _buildQuizForm(context)
      )
    );
  }

  Widget _buildQuizForm(BuildContext context) => Column(
    children: [
      Padding(
        padding: EdgeInsets.all(20.0),
        child: ProgressBar(),
      ),
      SizedBox(height: 20.0),
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
      SizedBox(height: 20.0),
      Expanded(
        flex: 2,
        child: PageView.builder(
          physics: NeverScrollableScrollPhysics(),
          controller: _controller.pageController,
          onPageChanged: _controller.updateQuestionNum,
          itemCount: _controller.questions.length,
          itemBuilder: (context, index) => QuestionCard(question: _controller.questions[index]),
        ),
      ),
    ],
  );

}