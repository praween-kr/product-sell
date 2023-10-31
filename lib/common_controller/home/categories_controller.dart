import 'package:get/get.dart';
import 'package:oninto_flutter/model/home/category_model.dart';
import 'package:oninto_flutter/service/api_requests.dart';

class CategoriesController extends GetxController {
  var loadingData = false.obs;
  var loadingSubData = false.obs;

  var categoriesList = <CategoryModel>[].obs;
  var subCategoriesList = <CategoryModel>[].obs;
  var selectedCategory = Rx<CategoryModel?>(null);

  getCategories() async {
    await ApiRequests.getCategories(
      data: (data) {
        categoriesList.value = data;
      },
      loading: (loading) async {
        if (!loading) {
          await Future.delayed(const Duration(seconds: 3));
        }
        loadingData.value = loading;
      },
    );
  }

  getSubCategories(String categoryId) async {
    await ApiRequests.getSubCategories(
      categoryId,
      data: (data) {
        subCategoriesList.value = data;
      },
      loading: (loading) async {
        if (!loading) {
          await Future.delayed(const Duration(seconds: 3));
        }
        loadingSubData.value = loading;
      },
    );
  }
}
