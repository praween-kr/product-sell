import 'package:get/get.dart';
import 'package:oninto_flutter/model/product/product_details_model.dart';
import 'package:oninto_flutter/model/product/product_model.dart';
import 'package:oninto_flutter/service/api_requests.dart';

class MyProductController extends GetxController {
  var loadingData = false.obs;
  var tabController = 0.obs;
  // My Products List
  var myProducts = <ProductModel>[].obs;
  var myBuyProducts = <ProductModel>[].obs;
  var mySellProducts = <ProductModel>[].obs;
  var myCoOwnerProducts = <ProductModel>[].obs;
  var myPhysicalProducts = <ProductModel>[].obs;
  //Product Details
  var productDetailsData = Rx<ProductDetailsData?>(null);

  /// ------ API Call ------
  getMyProducts(
      {bool sold = false,
      bool newAdded = false,
      bool pending = false,
      bool filter = false}) async {
    int type = 3;
    if (tabController.value == 0) {
      type = 3;
    } else if (tabController.value == 1) {
      type = 4;
    } else if (tabController.value == 2) {
      type = 2;
    } else if (tabController.value == 3) {
      type = 1;
    }
    await ApiRequests.getMyProducts(
      type: type,
      newAdded: newAdded,
      pending: pending,
      sold: sold,
      loading: (loading) async {
        loadingData.value = loading;
      },
      data: (data) {
        if (filter) {
          myProducts.value = data;
        } else {
          if (type == 3) {
            myBuyProducts.value = data;
          } else if (type == 4) {
            mySellProducts.value = data;
          } else if (type == 2) {
            myCoOwnerProducts.value = data;
          } else if (type == 1) {
            myPhysicalProducts.value = data;
          }
        }
      },
    );
  }

  getProductDetails(String productId) async {
    await ApiRequests.productDetails(productId, data: (data) {
      productDetailsData.value = data;
    }, loading: (loading) {
      loadingData.value = loading;
    });
  }
}
