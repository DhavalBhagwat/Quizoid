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
    await database.transaction((txn) async {
      txn.execute('CREATE TABLE IF NOT EXISTS ${TableNames.NOTES} (id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, videoId TEXT, noteId TEXT, noteContent TEXT)');
    });
  });

}
