import 'package:floor/floor.dart';
import 'package:app/db/lib.dart';

class DatabaseHelper {

  static DatabaseManager? _manager;

  DatabaseHelper._();

  String _TAG = "DatabaseHelper";

  static Future<DatabaseManager> get getInstance async {
    if (_manager == null) _manager = await $FloorDatabaseManager.databaseBuilder(DBConstants.dbName).addMigrations([]).build();
    return _manager!;
  }

  static final migrate1To2 = Migration(1, 2, (database) async {
    //Logger().d(_TAG, "migrate1To2()", message: "Migrating database version from 1 to 2."); //TODO
    await database.transaction((txn) async {
      txn.execute('CREATE TABLE IF NOT EXISTS ${TableNames.NOTES} (id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, videoId TEXT, noteId TEXT, noteContent TEXT)');
    });
  });

}
