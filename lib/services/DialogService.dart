import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:quizoid/ui/dialogs/lib.dart';
import 'package:quizoid/utils/lib.dart';

class DialogService {

  static DialogService? _instance;
  DialogService._();
  factory DialogService() => getInstance;

  static DialogService get getInstance {
    if (_instance == null) {
      _instance = new DialogService._();
    }
    return _instance!;
  }

  void notesDialog(BuildContext context, {VideoPlayerController? controller, Function? callback}) {
    Get.defaultDialog(
        title: "",
        backgroundColor:AppTheme.transparent,
        barrierDismissible: false,
        content: NotesDialog(context: context, controller: controller, callback: callback)
    );
  }

  void exitQuizDialog() {
    Get.defaultDialog(
        title: "",
        backgroundColor:AppTheme.transparent,
        barrierDismissible: false,
        content: ExitQuizDialog()
    );
  }

  void notesBottomDialog({String? note = "", VideoPlayerController? controller}) {
    Get.bottomSheet(
      NotesBottomDialog(controller: controller, note: note),
      barrierColor: AppTheme.transparent,
      backgroundColor: AppTheme.transparent,
      isDismissible: false,
    );
  }

  void answerDialog({String? answer = "", bool? isCorrect = false, Function? callback}) {
    Get.toNamed('/answerDialog', arguments: {'answer': answer, 'isCorrect': isCorrect, 'callback': callback});
  }

}