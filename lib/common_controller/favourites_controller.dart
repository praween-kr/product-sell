import 'package:get/get.dart';
import 'package:oninto_flutter/model/product/product_details_model.dart';
import 'package:oninto_flutter/model/settings/my_favourite_product_model.dart';
import 'package:oninto_flutter/service/api_requests.dart';
import 'package:oninto_flutter/utils/app_print.dart';

class FavouritesController extends GetxController {
  var loadingData = false.obs;

  var myFavProducts = <MyFavProduct>[].obs;

  getFavouriteProducts() async {
    await ApiRequests.getFavouriteProducts(
      data: (data) {
        myFavProducts.value = data;
      },
      loading: (loading) {
        loadingData.value = loading;
      },
    );
  }

  @override
  void onInit() {
    super.onInit();
    getFavouriteProducts();
  }

  var removingProduct = "".obs;

  var localFavourites = ''.obs;

  addProductAsFavourite(String productId, int index,
      {bool typeRemove = true}) async {
    await ApiRequests.addProductAsFavourite(
      productId,
      loading: (loading) async {
        if (loading) {
          if (typeRemove) {
            await Future.delayed(const Duration(seconds: 1));
            myFavProducts.removeAt(index);
            myFavProducts.refresh();
            removingProduct.value = "";
          }
        } else {
          if (typeRemove) {
            removingProduct.value = productId;
          }
        }
      },
      status: (status) {
        AppPrint.info("Add product as a favourite- $status");
        if (!typeRemove) {
          localFavourites.value = status ? productId : "";
          AppPrint.all("localFavourites: ${localFavourites.value}");
        }
      },
    );
  }

  //--------
  var productDetailsData = Rx<ProductDetailsData?>(null);

  getProductDetails(String productId) async {
    await ApiRequests.productDetails(productId, data: (data) {
      productDetailsData.value = data;
    }, loading: (loading) {
      loadingData.value = loading;
    });
  }
}
