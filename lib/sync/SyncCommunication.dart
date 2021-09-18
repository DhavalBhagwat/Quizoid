import 'package:firebase_database/firebase_database.dart';
import 'package:app/utils/lib.dart';

class SyncCommunication {

  static SyncCommunication? _instance;
  SyncCommunication._();
  factory SyncCommunication() => getInstance;
  Logger _logger = Logger.getInstance;
  static const _TAG = "SyncCommunication";

  static SyncCommunication get getInstance {
    if (_instance == null) {
      _instance = new SyncCommunication._();
    }
    return _instance!;
  }

  Future<DataSnapshot> getCategories() async {
    return await FirebaseDatabase.instance.reference().child("categories").once();
  }

  Future<DataSnapshot> getQuestions(String quizName) async {
    return await FirebaseDatabase.instance.reference().child(quizName).once();
  }

}
