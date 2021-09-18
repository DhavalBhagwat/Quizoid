import 'package:get/get.dart';
import 'package:app/ui/activities/lib.dart';

class Routes {

  static final routes = [
    GetPage(name: '/', page: () => SplashActivity()),
    GetPage(name: '/dashboardActivity', page: () => DashboardActivity()),
    GetPage(name: '/videoActivity', page: () => VideoActivity()),
    GetPage(name: '/quizActivity', page: () => QuizActivity()),
    GetPage(name: '/quizFinishedActivity', page: () => QuizFinishedActivity()),
  ];

}
