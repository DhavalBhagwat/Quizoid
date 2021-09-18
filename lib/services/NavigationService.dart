import 'package:app/data/podos/lib.dart';
import 'package:get/get.dart';

class NavigationService {

  static NavigationService? _instance;
  NavigationService._();
  factory NavigationService() => getInstance;

  static NavigationService get getInstance {
    if (_instance == null) {
      _instance = new NavigationService._();
    }
    return _instance!;
  }

  void videoActivity(VideoCategory category) => Get.toNamed('/videoActivity', arguments: {'category': category});

  void dashboardActivity() => Get.toNamed('/dashboardActivity');

  void quizActivity() => Get.toNamed('/quizActivity');

}