import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:app/ui/dialogs/lib.dart';
import 'package:app/utils/lib.dart';

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

  // void loadingDialog(BuildContext context, {String message = ""}) {
  //   showDialog(
  //       barrierDismissible: false,
  //       context: context,
  //       builder: (BuildContext context) => LoadingDialog(context: context, message: message)
  //   );
  // }

  void notesDialog(BuildContext context, {VideoPlayerController? controller}) {
    Get.defaultDialog(
        title: "",
        backgroundColor:AppTheme.transparent,
        barrierDismissible: false,
        content: NotesDialog(context: context, controller: controller)
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

}