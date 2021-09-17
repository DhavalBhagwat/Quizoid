import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app/ui/dialogs/lib.dart';
import 'package:video_player/video_player.dart';

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
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => NotesDialog(context: context, controller: controller)
    );
  }


// void addNotes(BuildContext context, ENotes note) async {
//   await   _manager!.userDao.insertNote(ENotes(videoId: "1234", noteId: _videoController?.value.position.inSeconds.toString(), noteContent: "HHELLO WORLD"));
//
// }

}