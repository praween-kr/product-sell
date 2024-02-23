import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/model/home/category_model.dart';
import 'package:oninto_flutter/model/product/product_details_model.dart';
import 'package:oninto_flutter/model/product/product_model.dart';
import 'package:oninto_flutter/service/api_requests.dart';
import 'package:oninto_flutter/utils/app_print.dart';

class CategoriesController extends GetxController {
  var loadingData = false.obs;
  var loadingSubData = false.obs;

  var categoriesList = <CategoryModel>[].obs;
  var subCategoriesList = <CategoryModel>[].obs;
  var selectedCategory = Rx<CategoryModel?>(null);
  var selectedSubCategory = Rx<CategoryModel?>(null);

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
  var swapingIndex = 0.obs;
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
      Function(bool)? pageLoading,
      Function? nodata,
      int? productType}) async {
    swapingIndex.value = 0;
    await ApiRequests.getProducts(
        categoryId: categoryId,
        subCategoryId: subCategoryId,
        limit: limit.value,
        pageno: pageno,
        productType: productType,
        data: (data) async {
          if (pageno != null) {
            if (data.isEmpty && nodata != null) {
              nodata();
            } else {
              products.addAll(data);
              products.refresh();
            }
          } else {
            products.value = data;
            clearPagination();
          }
        },
        loading: (loading) {
          if (pageno != null) {
            if (pageLoading != null) pageLoading(loading);
          } else {
            loadingData.value = loading;
          }
        });
  }

  ///
  var localFavourites = <String, bool>{}.obs;

  addProductAsFavourite(String productId) async {
    await ApiRequests.addProductAsFavourite(
      productId,
      loading: (loading) {},
      status: (status) {
        AppPrint.info("Add product as a favourite- $status");
        localFavourites.addAll({productId: status});
        localFavourites.refresh();
      },
    );
  }

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    paginationListener();
  }

  // --------------- Pagination ------------------------------------
  var pageno = 0.obs;
  var limit = 5.obs;
  var nextPageIsLoading = false.obs;
  var noMoreData = false.obs;
  ScrollController? scrollController;
  paginationListener() {
    if (scrollController != null) {
      scrollController?.addListener(() async {
        if (scrollController?.position.maxScrollExtent ==
            scrollController?.position.pixels) {
          AppPrint.all("dddddd-d-d-d-d---d");
          getNextPage();
        }
      });
    }
  }

  clearPagination() {
    pageno.value = 0;
    nextPageIsLoading.value = false;
    noMoreData.value = false;
  }

  getNextPage({String? categoryId, String? subCategoryId}) async {
    if (!nextPageIsLoading.value) {
      await getProducts(
          categoryId: categoryId,
          subCategoryId: subCategoryId,
          pageno: ++pageno.value,
          pageLoading: (loading) async {
            if (noMoreData.value && !loading) {
              await Future.delayed(const Duration(seconds: 1));
            }
            nextPageIsLoading.value = loading;
          },
          nodata: () async {
            noMoreData.value = true;
          });
    }
  }
  // ----------------------------------------------------------------
}
