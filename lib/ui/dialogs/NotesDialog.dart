import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:app/data/bloc/lib.dart';
import 'package:app/utils/lib.dart';
import 'package:app/services/DataService.dart';

class NotesDialog extends StatefulWidget {

  final BuildContext? context;
  final VideoPlayerController? controller;
  final Function? callback;

  NotesDialog({
    @required this.context,
    @required this.controller,
    this.callback,
  });

  @override
  _NotesDialogState createState() => _NotesDialogState();

}

class _NotesDialogState extends State<NotesDialog> {

  NotesProvider? _provider;
  TextEditingController? _remark;
  Logger _logger = Logger.getInstance;
  static const _TAG = "NotesDialog";

  @override
  void initState() {
    super.initState();
    _provider = Provider.of<NotesProvider>(context, listen: false);
    _remark = TextEditingController(text: _provider?.noteContent);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  onPressed: () => _showSnack(),
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
                onPressed: () async => _addNote(context),
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
    );
  }

  void _showSnack() => Get.snackbar(Strings.alert, Strings.coming_soon, snackPosition: SnackPosition.BOTTOM, backgroundColor: AppTheme.colorPrimaryDark);

  void _addNote(BuildContext context) async {
    try {
      await EasyLoading.show(maskType: EasyLoadingMaskType.black, dismissOnTap: false);
      _provider?.noteContent = _remark!.value.text.toString();
      await DataService.getInstance.addNote(context);
      await EasyLoading.dismiss();
      widget.callback!();
      _dismiss(context);
    } catch (error) {
      _logger.e(_TAG, "addNote()", message: error.toString());
      await EasyLoading.dismiss();
      _dismiss(context);
    }
  }

  void _dismiss(BuildContext context) {
    widget.controller?.play();
    Navigator.of(context).pop();
  }

}
