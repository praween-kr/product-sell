import 'package:get/get.dart';
import 'package:oninto_flutter/model/home/category_model.dart';
import 'package:oninto_flutter/model/product/product_details_model.dart';
import 'package:oninto_flutter/model/product/product_model.dart';
import 'package:oninto_flutter/service/api_requests.dart';
import 'package:oninto_flutter/utills/app_print.dart';

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
        loadingSubData.value = loading;
      },
    );
  }

  //-------Products-------
  var listViewTab = false.obs;
  // var menu = false.obs;
  // var touchTap = false.obs;
  var filter = false.obs;
  var heartColor = false.obs;
  var selectValue = 0.obs;
  //
  var products = <ProductModel>[].obs;
  var productDetailsData = Rx<ProductDetailsData?>(null);
  //

  getProductDetails(String productId) async {
    await ApiRequests.productDetails(productId, data: (data) {
      productDetailsData.value = data;
    }, loading: (loading) {
      loadingData.value = loading;
    });
  }

  getProducts(
      {String? categoryId,
      String? subCategoryId,
      int? pageno,
      int? limit}) async {
    await ApiRequests.getProducts(
        categoryId: categoryId,
        subCategoryId: subCategoryId,
        data: (data) async {
          if (pageno != null) {
            if (data.isEmpty) {
              noMoreData.value = true;
              await Future.delayed(const Duration(seconds: 3));
              noMoreData.value = false;
            } else {
              products.addAll(data);
              products.refresh();
            }
          } else {
            products.value = data;
          }
        },
        loading: (loading) {
          if (pageno != null) {
            nextPageIsLoading.value = loading;
          } else {
            loadingData.value = loading;
          }
        });
  }

  // Pagination
  var pageno = 0.obs;
  var limit = 10.obs;
  var nextPageIsLoading = false.obs;
  var noMoreData = false.obs;

  getNextProducts(
      {String? categoryId,
      String? subCategoryId,
      int? pageno,
      int? limit}) async {
    await getProducts(
        categoryId: categoryId,
        subCategoryId: subCategoryId,
        limit: limit,
        pageno: pageno);
  }

  var localFavourites = <String, bool>{}.obs;

  addProductAsFavourite(String productId) async {
    bool success = await ApiRequests.addProductAsFavourite(
      productId,
      loading: (loading) {},
      status: (status) {
        AppPrint.info("Add product as a favourite- $status");
        localFavourites.addAll({productId: status});
        localFavourites.refresh();
      },
    );
  }
}
