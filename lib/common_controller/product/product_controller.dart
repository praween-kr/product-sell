import 'package:get/get.dart';
import 'package:oninto_flutter/model/product/product_details_model.dart';
import 'package:oninto_flutter/service/api_requests.dart';

class ProductController extends GetxController {
  var loadingdata = false.obs;
  var productDetails = Rx<ProductDetails?>(null);
  var tabController = 0.obs;

  /// ------ API Call ------
  getProductDetails(String productId) async {
    await ApiRequests.productDetails(productId, data: (data) {
      productDetails.value = data;
    }, loading: (loading) {
      loadingdata.value = loading;
    });
  }
}
