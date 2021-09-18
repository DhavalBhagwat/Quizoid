import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';

abstract class IVideoListener {

  List<OptionItem> getVideoOptions(BuildContext context);

  Future<void> initializePlayer();

  void getAssignedNotes();

  void videoNotesListener();

  void videoDurationListener();

}