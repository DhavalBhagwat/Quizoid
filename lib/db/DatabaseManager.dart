import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:quizoid/data/entities/lib.dart';
import 'package:quizoid/db/lib.dart';
import 'package:quizoid/data/dao/lib.dart';
part 'DatabaseManager.g.dart';

@Database(version: DBConstants.dbVersion, entities: [
  ENotes
])

abstract class DatabaseManager extends FloorDatabase {

  NotesDao get userDao;

  @override
  StreamController<String> get changeListener => super.changeListener;

}
