import 'package:get/get.dart';
import 'package:app/ui/activities/lib.dart';
import 'package:app/ui/dialogs/lib.dart';

class Routes {

  static final routes = [
    GetPage(name: '/dashboardActivity', page: () => DashboardActivity()),
    GetPage(name: '/videoActivity', page: () => VideoActivity()),
    GetPage(name: '/quizActivity', page: () => QuizActivity()),
    GetPage(name: '/answerDialog', page: () => AnswerDialog()),
    GetPage(name: '/scoreActivity', page: () => ScoreActivity()),
  ];

}
