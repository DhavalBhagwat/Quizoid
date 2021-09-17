import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotesProvider extends ChangeNotifier {

  static NotesProvider? _instance;
  NotesProvider._();
  static const _TAG = "NotesProvider";
  factory NotesProvider() => getInstance;


  static NotesProvider get getInstance {
    if (_instance == null) {
      _instance = new NotesProvider._();
    }
    return _instance!;
  }

  int? _id;
  String? _videoId = "";
  String? _noteId = "";
  String? _noteContent = "";

  String get videoId => _videoId!;

  String get noteId => _noteId!;

  String get noteContent => _noteContent!;

  int get id => _id!;

  set id(int value) {
    _id = value;
    notifyListeners();
  }

  set videoId(String value) {
    _videoId = value;
    notifyListeners();
  }

  set noteId(String value) {
    _noteId = value;
    notifyListeners();
  }

  set noteContent(String value) {
    _noteContent = value;
    notifyListeners();
  }

  Future<void> set(String? videoId, String? noteId, String? noteContent, {int id = -1}) async {
    this.id = id;
    this.videoId = videoId!;
    this.noteId = noteId!;
    this.noteContent = noteContent!;
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'videoId': videoId,
    'noteId': noteId,
    'noteContent': noteContent,
  };

  void reset() {
    id = -1;
    videoId = "";
    noteId = "";
    noteContent = "";
  }

}


