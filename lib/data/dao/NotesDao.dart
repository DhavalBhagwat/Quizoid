import 'package:app/data/entities/ENotes.dart';
import 'package:floor/floor.dart';
import 'package:app/db/lib.dart';

@dao
abstract class NotesDao {

  @Query('SELECT * FROM ${TableNames.NOTES} where videoId = :videoId')
  Future<List<ENotes>> getNotesList(String videoId);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertNote(ENotes info);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateNote(ENotes info);

  @Query('DELETE FROM ${TableNames.NOTES} WHERE videoId = :videoId')
  Future<void> deleteAestheticObv(String videoId);

}