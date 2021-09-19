import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:app/utils/lib.dart';

class NotesBottomDialog extends StatelessWidget {

  final VideoPlayerController? controller;
  final String? note;
  static const _TAG = "NotesBottomDialog";

  NotesBottomDialog({
    @required this.controller,
    @required this.note,
  });
//
//   @override
//   _NotesDialogState createState() => _NotesDialogState();
//
// }
//
// class _NotesDialogState extends State<NotesBottomDialog> {

  //Logger _logger = Logger.getInstance;
//  static const _TAG = "NotesBottomDialog";

  // @override
  // void initState() {
  //   super.initState();
  // }decoration: BoxDecoration(
  //           borderRadius: BorderRadius.only(topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0)),
  //           color: AppTheme.nearlyWhite,
  //         ),

  @override
  Widget build(BuildContext context) {
    return Container(

    child:  Container(
      color: Colors.grey[900],
      height: 250,
      child: Column(
        children: <Widget>[
          Text(
            note!,
            style: TextStyle(color: Colors.white),
          ),
          MaterialButton(
            color: Colors.grey[800],
            onPressed: () {
              controller?.play();
              AppConstants.isNoteShown = false;
              Navigator.of(context).pop();
            },
            child: Text(
              'Check Flight',
              style: TextStyle(color: Colors.white),
            ),
          )
          //SheetButton(),
        ],
      ),
    )
    );
  }

}
