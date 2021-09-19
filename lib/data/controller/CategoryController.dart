import 'package:get/get.dart';
import 'package:app/utils/lib.dart';
import 'package:app/data/podos/lib.dart';
import 'package:app/sync/lib.dart';

class CategoryController extends GetxController {

  var isLoading = true.obs;
  var categoryList = [].obs;
  static const String _TAG = "CategoryController";

  CategoryController();

  @override
  void onInit() {
    _getCategoryList();
    super.onInit();
  }

  void _getCategoryList() async {
    categoryList.clear();
    isLoading(true);
    await SyncCommunication.getInstance.getCategories().then((data) {
      if (data.value != null) {
        categoryList.clear();
        for (var data in data.value) {
          categoryList.add(VideoCategory(data["name"], data["videoId"], data["videoUrl"], data["quizUrl"]));
        }
      }
    }).catchError((error) {
      Logger.getInstance.e(_TAG, "getCategoryList()", message: error.toString());
    }).whenComplete(() {
      isLoading(false);
    });
  }

  @override
  void onClose() {
    if (categoryList.isNotEmpty) categoryList.clear();
    super.onClose();
  }

}