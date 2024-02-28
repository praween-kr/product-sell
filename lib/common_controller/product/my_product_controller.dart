import 'package:get/get.dart';
import 'package:oninto_flutter/model/product/my_purchase_share_details_model.dart';
import 'package:oninto_flutter/model/product/product_details_model.dart';
import 'package:oninto_flutter/model/product/product_model.dart';
import 'package:oninto_flutter/service/api_requests.dart';
import 'package:oninto_flutter/utils/app_print.dart';
import 'package:oninto_flutter/utils/app_type_status.dart';

import '../../model/product/my_purchase_share_model.dart';
import '../../model/product/product_fav_view_model.dart';

class MyProductController extends GetxController {
  var loadingData = false.obs;
  var tabController = 0.obs;

  // My Products List
  var myProducts = <Product>[].obs;
  var myBuyProducts = <Product>[].obs;
  var mySellProducts = <Product>[].obs;
  var myCoOwnerProducts = <Product>[].obs;
  var myPhysicalProducts = <Product>[].obs;
  //Product Details
  var productDetailsData = Rx<ProductDetailsData?>(null);
  var shippingProductStatus = Rx<int?>(null);

  /// ------ API Call ------
  getMyProducts(
      {bool sold = false,
      bool newAdded = false,
      bool pending = false,
      bool filter = false}) async {
    int type = 3;
    if (tabController.value == 0) {
      type = 3;
    } else if (tabController.value == 2) {
      type = 4;
    } else if (tabController.value == 3) {
      type = 2;
    } else if (tabController.value == 4) {
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
      currentShippedProductStatus.value =
          data?.details?.userTransactionInfo?.shippedProductStatus ??
              ProductShippingStatus.pending;
      productDetailsData.value = data;
    }, loading: (loading) {
      loadingData.value = loading;
    });
  }

  /// Likes And Views Screen
  var isViews = true.obs;
  var productTitle = "".obs;
  var reactionOnProduct = Rx<ProductFavViewModel?>(null);
  getPrductReactions(String productId, {required String productName}) async {
    productTitle.value = productName;
    ApiRequests.getViewsAndLikesOfProduct(
      id: productId,
      data: (data) {
        reactionOnProduct.value = data;
      },
      loading: (loading) {
        loadingData.value = loading;
      },
    );
  }

  // All My Shares Product Models====================
  var activeShareTab = true.obs;
  // var myPurchaseShares = Rx<MySharesModel?>(null);
  var myActivePurchaseShares = <MyShare>[].obs;
  var myUnActivePurchaseShares = <MyShare>[].obs;
  getAllMyPurchaseShares() async {
    await ApiRequests.getAllMyPurchaseShares(
      data: (data) {
        if (data != null) {
          myActivePurchaseShares.value = data.sharelistNotSoldAdmin ?? [];
          myUnActivePurchaseShares.value = data.sharelistSoldAdmin ?? [];
        }
      },
      loading: (loading) {
        loadingData.value = loading;
      },
    );
  }

  // Deatils of My Share Product Model
  var purchaseShareDetails = Rx<PurchaseShareDetails?>(null);
  // var totalShares = 0.obs;
  // var totalInvestment = 0.0.obs;
  getPurchaseShareDetails(String id) async {
    await ApiRequests.getMyPurchaseShareDetails(
      id,
      data: (data) {
        purchaseShareDetails.value = data;
      },
      loading: (loading) {
        loadingData.value = loading;
      },
    );
  }

  // Shipping product status update by seller -- shipped from seller
  var currentShippedProductStatus = Rx<int>(ProductShippingStatus.pending);
  shippingProductStatusUpdate({
    required String productId,
    required String transactionId,
    required int shippedStatus,
  }) async {
    bool success = await ApiRequests.shippedPoductStatusUpdate(
        productId: productId,
        shippedProductStatus: shippedStatus,
        transactionId: transactionId);
    if (success) {
      AppPrint.info("Successfully updated shipping product status");
      currentShippedProductStatus.value = shippedStatus;
    }
    return success;
  }
}
