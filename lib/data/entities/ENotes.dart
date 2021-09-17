import 'package:floor/floor.dart';
import 'package:app/db/lib.dart';

@Entity(tableName: TableNames.NOTES)
class ENotes {

  @PrimaryKey(autoGenerate: true)
  int id;
  String videoId = "";
  String noteId = "";
  String noteContent = "";

  ENotes({
    this.id = -1,
    required this.videoId,
    required this.noteId,
    required this.noteContent
  });

}
