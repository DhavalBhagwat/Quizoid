import 'package:app/db/DatabaseHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app/data/entities/lib.dart';

class DataService {

  static DataService? _instance;
  DataService._();
  factory DataService() => getInstance;
  static const _TAG = "DataService";

  static DataService get getInstance {
    if (_instance == null) {
      _instance = new DataService._();
    }
    return _instance!;
  }

  void addNotes(BuildContext context, ENotes note) async {
    DatabaseHelper.getInstance.then((manager) {
      userDao.insertNote(ENotes(videoId: "1234", noteId: _videoController?.value.position.inSeconds.toString(), noteContent: "HHELLO WORLD"));
    });
  }

}
