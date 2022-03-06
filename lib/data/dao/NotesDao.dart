import 'package:floor/floor.dart';
import 'package:quizoid/db/lib.dart';
import 'package:quizoid/data/entities/lib.dart';

@dao
abstract class NotesDao {

  @Query('SELECT * FROM ${TableNames.NOTES} where videoId = :videoId')
  Future<List<ENotes>> getNotesList(String videoId);

  @Query('SELECT * FROM ${TableNames.NOTES} where noteId = :noteId AND videoId = :videoId')
  Future<ENotes?> getNote(String noteId, String videoId);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertNote(ENotes info);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateNote(ENotes info);

  @Query('DELETE FROM ${TableNames.NOTES} WHERE videoId = :videoId')
  Future<void> deleteAestheticObv(String videoId);

}