import 'package:app/data/podos/lib.dart';
import 'package:app/utils/lib.dart';
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

  void videoActivity(VideoCategory category) {
    AppConstants.quizTopic = category.name;
    Get.toNamed('/videoActivity', arguments: {'category': category});
  }

  void dashboardActivity() {
    AppConstants.quizTopic = "";
    Get.toNamed('/dashboardActivity');
  }

  void quizActivity(VideoCategory category) {
    AppConstants.quizTopic = category.name;
    Get.toNamed('/quizActivity', arguments: {'category': category});
  }

  void quizFinishedActivity(List<Question> questions, Map<int, dynamic> answers) => Get.toNamed('/quizFinishedActivity', arguments: {'questions': questions, 'answers': answers});

}