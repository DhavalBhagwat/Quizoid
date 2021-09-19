import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app/utils/lib.dart';
import 'package:lottie/lottie.dart';

class AnswerDialog extends StatefulWidget {

  @override
  _AnswerDialogState createState() => _AnswerDialogState();

}

class _AnswerDialogState extends State<AnswerDialog> with SingleTickerProviderStateMixin {

  static const String _TAG = "AnswerDialog";
  Function? _callback;
  Timer? _timer;
  int _start = 3;
  AnimationController? _controller;
  Animation<Offset>? _offset;
  bool? _isCorrect;
  String? _answer, _result;

  @override
  void initState() {
    super.initState();
    _initValues();
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.colorPrimaryLight,
      child: Center(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: SlideTransition(
            position: _offset!,
            child: Column(
              children: [
                Lottie.asset(_isCorrect! ? Assets.CORRECT : Assets.INCORRECT),
                SizedBox(height: 12.0),
                Text(
                  "$_answer is $_result",
                  style: TextStyle(fontSize: 24.0, fontStyle: FontStyle.italic),
                ),
                SizedBox(height: 12.0),
                Text(
                  "${Strings.next_question} $_start",
                  style: TextStyle(fontSize: 20.0),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _initValues() {
    _callback =  Get.arguments["callback"];
    _answer =  Get.arguments["answer"];
    _isCorrect = Get.arguments["isCorrect"];
    _result =   _isCorrect! ? "Correct" : "Incorrect";
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _offset = Tween<Offset>(begin: Offset.zero, end: Offset(0.0,  MediaQuery.of(Get.context!).size.height / 2 / 1000)).animate(_controller!);
  }

  void _startTimer() {
    _controller?.forward();
    const oneSec =  Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec, (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            Get.back();
            _callback!();
          });
        } else setState(() => _start--);
      },
    );
  }

}
