import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:quizoid/utils/lib.dart';

class NotesBottomDialog extends StatelessWidget {

  final VideoPlayerController? controller;
  final String? note;
  static const _TAG = "NotesBottomDialog";

  NotesBottomDialog({
    @required this.controller,
    @required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.colorAccent,
      padding: EdgeInsets.all(20.0),
      height: 200,
      child: Column(
        children: <Widget>[
          Spacer(),
          Text(
            note!,
            style: TextStyle(color: AppTheme.nearlyWhite, fontSize: 18.0),
          ),
          Spacer(),
          MaterialButton(
            color: AppTheme.colorPrimaryDark,
            onPressed: () {
              controller?.play();
              AppConstants.isNoteShown = false;
              Navigator.of(context).pop();
            },
            child: Text(
              Strings.dismiss,
              style: TextStyle(color: AppTheme.nearlyBlack),
            ),
          ),
        ],
      ),
    );
  }

}
