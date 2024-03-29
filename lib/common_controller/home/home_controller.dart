import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/Socket/app_socket.dart';
import 'package:oninto_flutter/Socket/model/add_bids_histories.dart';
import 'package:oninto_flutter/common_controller/auth/auth_controller.dart';
import 'package:oninto_flutter/common_controller/product/payment_methods.dart';
import 'package:oninto_flutter/generated/assets.dart';
import 'package:oninto_flutter/model/home/home_model.dart';
import 'package:oninto_flutter/model/product/product_details_model.dart';
import 'package:oninto_flutter/model/product/product_model.dart';
import 'package:oninto_flutter/service/api_requests.dart';
import 'package:oninto_flutter/utils/app_print.dart';
import 'package:oninto_flutter/utils/app_timer.dart';
import 'package:oninto_flutter/utils/app_toast_loader.dart';
import 'package:oninto_flutter/utils/app_type_status.dart';
import 'package:swipable_stack/swipable_stack.dart';

import '../../model/onboard_model.dart';
import '../../utils/helper/camera_helper.dart';
import '../../views/bid_screen/notification_model.dart';

class HomeCatProductController extends GetxController
    implements
        CameraOnCompleteListener,
        AppBidSocketListener,
        AppShareSocketListener {
  var seeAllUserBuyShares = false.obs;
  // RxBool homePass = true.obs;
  // RxBool Switch = false.obs;
  RxBool upload = false.obs;

  var coOwnerController = 0.obs;
  var messageController = 0.obs;
  var timer = false.obs;
  var imagePath = "".obs;
  late PageController pageController;
  late CameraHelper cameraHelper;
  var menu = false.obs;
  var heartColor = false.obs;
  var touchTap = false.obs;

  /// o for menu and 1 for filter selected
  var selectValue = 0.obs;
  var filter = false.obs;
  var sub = false.obs;
  var track = false.obs;
  var trackupload = false.obs;

  var controller = SwipableStackController();

  RxList<CommonModel> onBoardingData = RxList([]);
  RxInt pagePosition = RxInt(0);

  // VIew Pouduct -> Share, Bid
  var currentViewProductType = Rx<int?>(null);
  @override
  void onInit() {
    cameraHelper = CameraHelper(this);
    // Timer.periodic(const Duration(seconds: 3), (Timer timer) {
    //   if (pagePosition < 2) {
    //     pagePosition++;
    //     pageController.animateToPage(pagePosition.value,
    //         duration: const Duration(milliseconds: 350), curve: Curves.easeIn);
    //   } else {
    //     pagePosition.value = 2;
    //   }
    // });
    super.onInit();
    pageController = PageController(initialPage: pagePosition.value);
    onBoardingData = RxList([
      CommonModel(
          image: Assets.assetsHome1,
          title: "Login Your Details",
          description:
              "Lorem Ipsum is simply dummy text of \nthe printing and typesetting industry.\nLorem Ipsum is simply dummy text of \nthe printing and typesetting industry."),
      CommonModel(
          image: Assets.assetsHome2,
          title: "Add Your Product",
          description:
              "Lorem Ipsum is simply dummy text of \nthe printing and typesetting industry.\nLorem Ipsum is simply dummy text of \nthe printing and typesetting industry."),
      CommonModel(
          image: Assets.assetsHome3,
          title: "Sold Your Product",
          description:
              "Lorem Ipsum is simply dummy text of \nthe printing and typesetting industry.\nLorem Ipsum is simply dummy text of \nthe printing and typesetting industry."),
    ]);

    //
    getHomeData();
  }

  void onPageChanged(index) {
    pagePosition.value = index;
    if (index == 2) {
      1.delay(() => NavigateTo.login());
    }
  }

  void nextScreen(int index) {
    onBoardingData.refresh();
    pageController.nextPage(duration: 300.milliseconds, curve: Curves.ease);
  }

  @override
  void onSuccessFile(File file, String fileType) {
    imagePath.value = file.path;
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();

    scrollController = ScrollController();
    paginationListener();
  }

  void reset() {
    imagePath.value = "";
  }

  ///-----------------------====================-----------------------
  var homeData = Rx<HomeModel?>(null);
  var loadingData = false.obs;
  var searchAndFilterApplied = false.obs;
  //
  var searchInput = TextEditingController(text: '');

  var notificationList = <NotificationModel>[].obs;

  var loadingNotification = false.obs;

  RxInt isSelectedNotification = (-1).obs;
  getNotificationListing() async {
    await ApiRequests.getNotificationListing(data: (data) {
      notificationList.value = data;
    }, loading: (loading) {
      loadingNotification.value = loading;
    });
  }

  deleteNotification({required String notificationId}) async {
    bool success =
        await ApiRequests.deleteNotification(notificationId: notificationId);
    if (success) {
      notificationList.removeAt(isSelectedNotification.value);
      notificationList.refresh();
      isSelectedNotification.value = -1;
      AppPrint.error("Notification Delete successfully!");
    } else {
      AppPrint.error("Failed to delete");
    }
  }

  getHomeData() async {
    await ApiRequests.getHomeData(data: (data) {
      homeData.value = data;
    }, loading: (loading) {
      loadingData.value = loading;
    });
  }

  var products = <ProductModel>[].obs;
  // Filter by product type [1 for bid, 2 for fixed, 3 for share]
  searchProducts({
    bool isSearchFilter = true,
    int? productType,
    //page
    int? pageno,
    Function(bool)? pageLoading,
    Function? nodata,
  }) async {
    searchAndFilterApplied.value = isSearchFilter;
    await _getSearchProducts(
        productType: productType,
        pageno: pageno,
        pageLoading: pageLoading,
        nodata: nodata);
  }

  // 1-> endingSoon, 2-> highestPrice, 3-> lowestPrice, 4-> mostBid, 5-> leastBid, 6-> recentBid
  var selectedFilterKey = 1.obs;
  var filtering = false.obs;

  filterProducts(
      //page
      {
    int? pageno,
    Function(bool)? pageLoading,
    Function? nodata,
  }) async {
    await _getSearchProducts(
      endingSoon: selectedFilterKey.value == 1,
      highestPrice: selectedFilterKey.value == 2,
      leastBid: selectedFilterKey.value == 3,
      lowestPrice: selectedFilterKey.value == 4,
      mostBid: selectedFilterKey.value == 5,
      recentBid: selectedFilterKey.value == 6,
      pageno: pageno,
      pageLoading: pageLoading,
      nodata: nodata,
    );
  }

  _getSearchProducts({
    bool endingSoon = false,
    bool highestPrice = false,
    bool lowestPrice = false,
    bool mostBid = false,
    bool leastBid = false,
    bool recentBid = false,
    int? productType,
    //page
    int? pageno,
    Function(bool)? pageLoading,
    Function? nodata,
  }) async {
    await ApiRequests.getProducts(
      searchKey: searchInput.text.trim(),
      endingSoon: endingSoon,
      highestPrice: highestPrice,
      leastBid: leastBid,
      lowestPrice: lowestPrice,
      mostBid: mostBid,
      recentBid: recentBid,
      productType: productType,
      pageno: pageno,
      data: (data) {
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
        // filtering.value = loading;
        if (pageno != null) {
          if (pageLoading != null) pageLoading(loading);
        } else {
          filtering.value = loading;
        }
      },
    );
  }

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

  ///----------------------- Product Details ----------------------
  var productType = Rx<String?>(null);
  var productDetailsData = Rx<ProductDetailsData?>(null);
  getProductDetails(String productId) async {
    getBidHistories(productId: productId);
    productDetailsData.value = null;
    await ApiRequests.productDetails(productId, data: (data) {
      productDetailsData.value = data;
      productType.value = data?.details?.sellOption == "Auction"
          ? ProductType.biding
          : ProductType.fixedPrice;
      // bidingEndAfter.value = DateTime.parse(
      //         "${productDetailsData.value?.details?.startDate ?? "0000-00-00"} ${productDetailsData.value?.details?.bidTime ?? "00:00:00"}")
      //     .add(Duration(minutes: incrementTimeAfterNewBid.value));
    }, loading: (loading) {
      loadingData.value = loading;
    });
  }

  // Socket
  //// ---- Biding ----
  //
  var bidingDataLoading = false.obs;
  var addBbidingLoading = false.obs;
  var bidAmountInput = TextEditingController(text: '');

  var bidingData = Rx<AddBidsHistory?>(null);
  //-------------------------
  // var bidingEndAfter = Rx<DateTime?>(null);
  var bidingTimerStatus = Rx<TimerTypeStatus?>(null);
  //-----------------

  addBid(
      {required String productId,
      required double bidPrice,
      required double lastBidPrice}) {
    if (bidPrice <= 0.0) {
      AppToast.show("Please add bid amount");
      return;
    } else if (bidPrice <= lastBidPrice) {
      AppToast.show("Please add more then last price");
      return;
    }
    socketPrint("$productId != " " && $bidPrice");
    if (productId != "" && bidPrice > 0.0) {
      addBbidingLoading.value = true;
      SocketEmits.addBid(productId: productId, bidPrice: bidPrice);
      //
      Get.back();
      bidAmountInput.clear();
    }
  }

  @override
  addBidListener(AddBidsHistory? data) {
    bidingData.value = data;
    if (data?.save?.createdAt != null) {
      // Refresh Timer when other user bid on
      // bidingEndAfter.value = DateTime.parse(data!.save!.createdAt!)
      //     .toLocal()
      //     .add(Duration(minutes: incrementTimeAfterNewBid.value));
    }
    addBbidingLoading.value = false;
  }

  //
  getBidHistories({required String productId}) {
    bidingDataLoading.value = true;
    SocketEmits.getLastBidAndHistory(productId: productId);
  }

  @override
  getBidHistoriesListener(AddBidsHistory? data) {
    bidingData.value = data;

    if (data?.save?.bidOver.toString() == '1') {
      bidingTimerStatus.value = TimerTypeStatus.END;
    }

    bidingDataLoading.value = false;
  }
  //

  bidOver({required String productId}) {
    SocketEmits.bidOver(productId: productId);
  }

  @override
  bidOverListener(bool data) {
    socketPrint("Biding over...");
  }

  ///--------- Biding ---------
  ///--------- Buy Product ----

  ///--- Share Product Socket ------
  @override
  listenerShareProductDetails(ProductDetailsData? data) async {
    socketPrint("Get Share Product: $data");
    productDetailsData.value = null;
    productDetailsData.value = data;
    loadingData.value = false;
  }

  emitShareProductDetails(String productId) {
    loadingData.value = true;
    SocketEmits.getShareProductData(productId: productId);
  }

  // Purchage Share
  TextEditingController sharesInput = TextEditingController(text: '');
  @override
  listenerPurchageProductShare(String? shareId, bool success) async {
    AppLoader.hide();
    if (success && shareId != null) {
      emitShareProductDetails(shareId.toString());
    }
  }

  var makingPayment = false.obs;
  emitPurchageProductShare(int totalShares) {
    // if (!makingPayment.value) {
    makingPayment.value = true;
    if (productDetailsData.value?.details?.id != null &&
        productDetailsData.value?.details?.price != null) {
      if (sharesInput.text.trim() == '' ||
          int.parse(sharesInput.text.trim()) <= 0) {
        sharesInput.clear();
        AppToast.show("Please add share quantity");
        return;
      } else if ((sharesInput.text.trim())[0] == '0') {
        sharesInput.clear();
        AppToast.show("Please enter valid share quantity");
        return;
      } else if (int.parse((sharesInput.text.trim())) > totalShares) {
        sharesInput.clear();
        AppToast.show(
            "Please enter share quantity less then $totalShares shares");
        return;
      }
      double price = double.parse(
          (productDetailsData.value?.details?.price ?? '0').toString());
      int quantity = int.parse(sharesInput.text);
      // Stripe Payment Call
      AppPaymentMethods.stripePayment(
        amount: price * quantity,
        shareQty: quantity,
        productId: (productDetailsData.value?.details?.id ?? '').toString(),
        type: TypeOfProduct.share,
        success: (transactionId) {
          sharesInput.clear();
          // After Success of payment
          // Purchase Share Socket Emit
          AppLoader.show();
          // AppPaymentMethods.stripeWebhookConfirmPayment(transactionId);
          SocketEmits.purchaseProductShare(
              productId:
                  (productDetailsData.value?.details?.id ?? '').toString(),
              shares: int.parse(sharesInput.text),
              perSharePrice: double.parse(
                  (productDetailsData.value?.details?.price ?? '0')
                      .toString()));

          makingPayment.value = false;
        },
      );
    }
    // }
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

  getNextPage({
    bool isFromFilter = false,
    bool isSearchFilter = true,
    String? categoryId,
    String? subCategoryId,
    int? productType,
  }) async {
    if (!nextPageIsLoading.value) {
      if (isFromFilter) {
        await filterProducts(
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
      } else {
        await searchProducts(
            isSearchFilter: isSearchFilter,
            productType: productType,
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
  }
  // ----------------------------------------------------------------
}

// enum ProductType { BID, FIX_PRICE, SHERE }

// enum ProductStatus { BIDED_ON }
