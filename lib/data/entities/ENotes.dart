import 'package:floor/floor.dart';
import 'package:app/db/lib.dart';

@Entity(tableName: TableNames.NOTES)
class ENotes {

  @PrimaryKey(autoGenerate: true)
  int? id;
  String? videoId = "";
  String? noteId = "";
  String? noteContent = "";

  ENotes({
    this.id,
    this.videoId,
    this.noteId,
    this.noteContent
  });

  Map toJson() => {
    'id': id,
    'videoId': videoId,
    'noteId': noteId,
    'noteContent': noteContent,
  };

}
