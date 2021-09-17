import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app/data/entities/lib.dart';
import 'package:app/data/bloc/lib.dart';
import 'package:app/db/lib.dart';
import 'package:app/utils/lib.dart';

class DataService {

  static DataService? _instance;
  DataService._();
  factory DataService() => getInstance;
  Logger _logger = Logger.getInstance;
  static const _TAG = "DataService";

  static DataService get getInstance {
    if (_instance == null) {
      _instance = new DataService._();
    }
    return _instance!;
  }

  Future<void> addNote(BuildContext context) async {
    DatabaseHelper.getInstance.then((manager) {
      NotesProvider provider = NotesProvider.getInstance;
      manager.userDao.insertNote(ENotes(videoId: provider.videoId, noteId: provider.noteId, noteContent: provider.noteContent));
    }).catchError((error) {
      _logger.e(_TAG, "addNote()", message: error.toString());
    });
  }

}
