import 'package:get/get.dart';

import '../../../common_controller/home/home_controller.dart';
import '../../../model/product/product_model.dart';
import '../../../routes/routes.dart';
import '../../../utils/app_type_status.dart';

gotoProductDetaiesScreen(ProductModel product) {
  if (product.type == TypeOfProduct.share) {
    // Share Product
    Map<String, dynamic> data = {"from": 0};
    if (HomeCatProductController().initialized) {
      Get.find<HomeCatProductController>()
          .emitShareProductDetails((product.id ?? '').toString());
    } else {
      Get.put(HomeCatProductController())
          .emitShareProductDetails((product.id ?? '').toString());
    }
    Get.toNamed(Routes.publicShareProductDetails, arguments: data);
  } else {
    Map<String, dynamic> data = {"from": 0};
    if (HomeCatProductController().initialized) {
      Get.find<HomeCatProductController>()
          .getProductDetails((product.id ?? '').toString());
    } else {
      Get.put(HomeCatProductController())
          .getProductDetails((product.id ?? '').toString());
    }
    Get.toNamed(Routes.productDetailsScreen, arguments: data);
  }
}
