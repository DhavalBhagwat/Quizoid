import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:app/data/podos/lib.dart';
import 'package:app/sync/lib.dart';
import 'package:app/utils/lib.dart';
import 'package:app/services/lib.dart';

class QuestionController extends GetxController with SingleGetTickerProviderMixin {

  static const _TAG = "QuestionController";
  Logger _logger = Logger.getInstance;
  AnimationController? _animationController;
  Animation? animation;
  var isLoading = true.obs;
  var questionNumber = 1.obs;
  PageController? pageController;
  List<Question> questions = [];
  int _numOfCorrectAns = 0;
  int? _correctAns, _selectedAns;
  bool _isAnswered = false;
  List<Map<int, int>>? answersMap = [];

  void _getQuestionsList() async {
    questions.clear();
    isLoading(true);
    await SyncCommunication.getInstance.getQuestions(AppConstants.quizTopic).then((snapshot) {
      if (snapshot.value != null) snapshot.value.forEach((data) {
        questions.add(Question(id: data['id'], question: data['question'], options: List<String>.from(data['options']), answer: data['answer_index']));
      });
    }).catchError((error) {
      _logger.e(_TAG, "getQuestionsList()", message: error.toString());
    }).whenComplete(() {
      isLoading(false);
    });
  }

  @override
  void onInit() {
    pageController = PageController();
    _animationController = AnimationController(duration: Duration(seconds: 5), vsync: this);
    _animationController?.forward().whenComplete(_nextQuestion);
    animation = Tween<double>(begin: 0, end: 1).animate(_animationController!)..addListener(() {
      update();
    });
    _getQuestionsList();
    answersMap?.clear();
    super.onInit();
  }

  @override
  void onClose() {
    questions.clear();
    _animationController?.dispose();
    pageController?.dispose();
    super.onClose();
  }

  void checkAnswer(Question question, int selectedIndex) {
    _isAnswered = true;
    _correctAns = question.answer;
    _selectedAns = selectedIndex;
    if (_correctAns == _selectedAns) {
      _numOfCorrectAns++;
      answersMap?.add({questionNumber.value: _animationController!.lastElapsedDuration!.inSeconds});
    }
    _animationController?.stop();
    DialogService.getInstance.answerDialog(answer: question.options![selectedIndex], isCorrect: _correctAns == _selectedAns, callback: _moveNext);
  }

  void _moveNext() {
    update();
    _nextQuestion();
  }

  void _resetAnimation({bool forward = true}) {
    if (forward) pageController?.nextPage(duration: Duration(milliseconds: 250), curve: Curves.ease);
    _animationController?.reset();
    _animationController?.forward().whenComplete(_nextQuestion);
  }

  void _nextQuestion() {
    if (_isAnswered) {
      if (_correctAns == _selectedAns) {
        if (questionNumber.value != questions.length) {
          _isAnswered = false;
          _resetAnimation();
        } else {
          NavigationService.getInstance.scoreActivity(_numOfCorrectAns, questions.length, answersMap);
        }
      } else _resetAnimation(forward: false);
    } else _resetAnimation();
  }

  void updateQuestionNum(int index) => questionNumber.value = index + 1;

}
