import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:app/utils/lib.dart';

class NotesBottomDialog extends StatefulWidget {

  final BuildContext? context;
  final VideoPlayerController? controller;
  final String? note;

  NotesBottomDialog({
    @required this.context,
    @required this.controller,
    @required this.note,
  });

  @override
  _NotesDialogState createState() => _NotesDialogState();

}

class _NotesDialogState extends State<NotesBottomDialog> {

  Logger _logger = Logger.getInstance;
  static const _TAG = "NotesBottomDialog";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 250,
      color: Colors.white54,
      alignment: Alignment.center,
      child: Text(widget.note!),
    );

    // return Dialog(
    //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
    //   elevation: 4.0,
    //   backgroundColor: AppTheme.lightBackground,
    //   child: Container(
    //     padding: EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 16),
    //     decoration: BoxDecoration(
    //       color: AppTheme.lightBackground,
    //       shape: BoxShape.rectangle,
    //       borderRadius: BorderRadius.circular(8.0),
    //     ),
    //     child: ListView(
    //       scrollDirection: Axis.vertical,
    //       shrinkWrap: true,
    //       children: [
    //         Row(
    //           children: [
    //             Expanded(
    //               child: Text(Strings.create),
    //             ),
    //             Container(
    //               child: IconButton(
    //                   icon: Icon(Icons.clear),
    //                   color: AppTheme.grey,
    //                   onPressed: () => _dismiss(context)
    //               ),
    //               transform: Matrix4.translationValues(12, 0, 0),
    //             ),
    //           ],
    //         ),
    //
    //         SizedBox(height: 8.0),
    //
    //         Container(
    //           decoration: BoxDecoration(
    //             borderRadius: BorderRadius.circular(8.0),
    //             color: AppTheme.nearlyWhite,
    //           ),
    //           margin: EdgeInsets.symmetric(vertical: 5),
    //           width: double.maxFinite,
    //           padding: EdgeInsets.symmetric(horizontal: 5),
    //           child: TextFormField(
    //             controller: _remark,
    //             keyboardType: TextInputType.multiline,
    //             maxLines: 5,
    //             decoration: InputDecoration(
    //               border: InputBorder.none,
    //               hintText: Strings.insert_text_here,
    //             ),
    //           ),
    //         ),
    //
    //         SizedBox(height: 8.0),
    //
    //         Row(
    //           children: [
    //             Container(
    //               child: TextButton(
    //                 onPressed: () {
    //                   //TODO : add snack
    //                   print("COMING SOON");
    //                 },
    //                 child: Row(
    //                   mainAxisSize: MainAxisSize.min,
    //                   mainAxisAlignment: MainAxisAlignment.start,
    //                   children: [
    //                     Icon(Icons.image_outlined),
    //                     Text(Strings.upload_attachments)
    //                   ],
    //                 ),
    //                 style: ButtonStyle(
    //                   foregroundColor: MaterialStateProperty.all(AppTheme.nearlyBlack),
    //                   backgroundColor: MaterialStateProperty.all<Color>(AppTheme.transparent),
    //                 ),
    //               ),
    //             ),
    //             Spacer(),
    //           ],
    //         ),
    //
    //         Row(
    //           children: [
    //             TextButton(
    //               style: ButtonStyle(
    //                 foregroundColor: MaterialStateProperty.all(AppTheme.darkGrey),
    //                 backgroundColor: MaterialStateProperty.all<Color>(AppTheme.transparent),
    //               ),
    //               onPressed: () async => _addNote(context),
    //               child: Text(
    //                 Strings.save,
    //                 style: TextStyle(fontSize: 16.0),
    //               ),
    //             ),
    //             Spacer(),
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }

}
