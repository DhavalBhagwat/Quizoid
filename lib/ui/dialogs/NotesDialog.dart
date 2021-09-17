import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:app/data/bloc/lib.dart';
import 'package:app/utils/lib.dart';

class NotesDialog extends StatefulWidget {

  final BuildContext? context;
  final VideoPlayerController? controller;

  NotesDialog({
    @required this.context,
    @required this.controller,
  });

  @override
  _NotesDialogState createState() => _NotesDialogState();

}

class _NotesDialogState extends State<NotesDialog> {

  NotesProvider? _provider;
  TextEditingController? _remark;

  @override
  void initState() {
    super.initState();
    _provider = Provider.of<NotesProvider>(context, listen: false);
    _remark = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 4.0,
      backgroundColor: AppTheme.lightBackground,
      child: Container(
        padding: EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 16),
        decoration: BoxDecoration(
          color: AppTheme.lightBackground,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(Strings.create),
                ),
                Container(
                  child: IconButton(
                      icon: Icon(Icons.clear),
                      color: AppTheme.grey,
                      onPressed: () => _dismiss(context)
                  ),
                  transform: Matrix4.translationValues(12, 0, 0),
                ),
              ],
            ),

            SizedBox(height: 8.0),

            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: AppTheme.nearlyWhite,
              ),
              margin: EdgeInsets.symmetric(vertical: 5),
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: TextFormField(
                controller: _remark,
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: Strings.insert_text_here,
                ),
              ),
            ),

            SizedBox(height: 8.0),

            Row(
              children: [
                Container(
                  child: TextButton(
                    onPressed: () {
                      //TODO
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.image_outlined),
                        Text(Strings.upload_attachments)
                      ],
                    ),
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(AppTheme.nearlyBlack),
                      backgroundColor: MaterialStateProperty.all<Color>(AppTheme.transparent),
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),

            Row(
              children: [
                TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(AppTheme.darkGrey),
                    backgroundColor: MaterialStateProperty.all<Color>(AppTheme.transparent),
                  ),
                  onPressed: () async {
                    //TODO
                  },
                  child: Text(
                    Strings.save,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _addNote(BuildContext context) {
    //TODO
  }

  void _dismiss(BuildContext context) {
    widget.controller?.play();
    Navigator.of(context).pop();
  }

}
