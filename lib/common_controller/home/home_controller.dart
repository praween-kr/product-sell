import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/Socket/app_socket.dart';
import 'package:oninto_flutter/Socket/model/add_bids_histories.dart';
import 'package:oninto_flutter/common_controller/auth/auth_controller.dart';
import 'package:oninto_flutter/generated/assets.dart';
import 'package:oninto_flutter/model/home/home_model.dart';
import 'package:oninto_flutter/model/product/product_details_model.dart';
import 'package:oninto_flutter/model/product/product_model.dart';
import 'package:oninto_flutter/service/api_requests.dart';
import 'package:oninto_flutter/service/local/user_info_global.dart';
import 'package:oninto_flutter/utils/app_print.dart';
import 'package:oninto_flutter/utils/app_timer.dart';
import 'package:oninto_flutter/utils/app_toast_loader.dart';
import 'package:swipable_stack/swipable_stack.dart';

import '../../model/onboard_model.dart';
import '../../utils/helper/camera_helper.dart';
import '../../views/bid_screen/notification_model.dart';

class HomeCatProductController extends GetxController
    implements CameraOnCompleteListener {
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

    // Categorydata = RxList([
    //   HomeModel(
    //     image: Assets.assetsGirl,
    //     Name: "Women",
    //   ),
    //   HomeModel(
    //     image: Assets.assetsShirt,
    //     Name: "Men",
    //   ),
    //   HomeModel(
    //     image: Assets.assetsKids,
    //     Name: "Kids",
    //   ),
    //   HomeModel(
    //     image: Assets.assetsRoom,
    //     Name: "Home & living",
    //   ),
    //   HomeModel(
    //     image: Assets.assetsElectronic,
    //     Name: "Electronic",
    //   ),
    //   HomeModel(
    //     image: Assets.assetsBeauty,
    //     Name: "Beauty",
    //   ),
    //   HomeModel(
    //     image: Assets.assetsAmericanBall,
    //     Name: "Sports",
    //   ),
    //   HomeModel(
    //     image: Assets.assetsDog,
    //     Name: "Pets",
    //   ),
    //   HomeModel(
    //     image: Assets.assetsCard,
    //     Name: "Cards",
    //   ),
    //   HomeModel(
    //     image: Assets.assetsCar,
    //     Name: "Vehicle",
    //   ),
    // ]);
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
  //
  searchProducts() async {
    searchAndFilterApplied.value = true;
    await _getSearchProducts();
  }

  // 1-> endingSoon, 2-> highestPrice, 3-> lowestPrice, 4-> mostBid, 5-> leastBid, 6-> recentBid
  var selectedFilterKey = 1.obs;
  var filtering = false.obs;

  filterProducts() async {
    await _getSearchProducts(
      endingSoon: selectedFilterKey.value == 1,
      highestPrice: selectedFilterKey.value == 2,
      leastBid: selectedFilterKey.value == 3,
      lowestPrice: selectedFilterKey.value == 4,
      mostBid: selectedFilterKey.value == 5,
      recentBid: selectedFilterKey.value == 6,
    );
  }

  _getSearchProducts(
      {bool endingSoon = false,
      bool highestPrice = false,
      bool lowestPrice = false,
      bool mostBid = false,
      bool leastBid = false,
      bool recentBid = false}) async {
    await ApiRequests.getProducts(
        searchKey: searchInput.text.trim(),
        endingSoon: endingSoon,
        highestPrice: highestPrice,
        leastBid: leastBid,
        lowestPrice: lowestPrice,
        mostBid: mostBid,
        recentBid: recentBid,
        data: (data) {
          products.value = data;
        },
        loading: (loading) {
          filtering.value = loading;
        });
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

  ///----------------------- Product Details ----------------------
  var productType = Rx<ProductType?>(null);
  var productDetailsData = Rx<ProductDetailsData?>(null);
  getProductDetails(String productId) async {
    getBidHistories(productId: productId);
    productDetailsData.value = null;
    await ApiRequests.productDetails(productId, data: (data) {
      productDetailsData.value = data;
      productType.value = data?.details?.sellOption == "Auction"
          ? ProductType.BID
          : ProductType.FIX_PRICE;
      bidingEndAfter.value = DateTime.parse(
              "${productDetailsData.value?.details?.startDate ?? "0000-00-00"} ${productDetailsData.value?.details?.bidTime ?? "00:00:00"}")
          .add(Duration(minutes: incrementTimeAfterNewBid.value));
    }, loading: (loading) {
      loadingData.value = loading;
    });
  }

  // Socket
  //// ---- Biding Duration Increment If Any One Bid On ----
  var incrementTimeAfterNewBid = 5.obs; // in minutes
  var bidAlradyEnd = false.obs;
  //
  var bidingDataLoading = false.obs;
  var addBbidingLoading = false.obs;
  var bidAmountInput = TextEditingController(text: '');

  var bidingData = Rx<AddBidsHistory?>(null);

  //-------------------------
  var bidingEndAfter = Rx<DateTime?>(null);
  var bidingTimerStatus = Rx<TimerTypeStatus?>(null);
  int? myBidProduct() {
    if (productDetailsData.value?.details?.sellOption == "Fix Price") {
      return 0; // Buy
    }
    if (bidingData.value?.save?.bidOver == 1 &&
        bidingData.value?.save?.userId == UserStoredInfo().userInfo?.id) {
      return 1; // After Bid Buy
    }

    return null;
  }

  int? bidingActionActive() {
    if (productType.value == ProductType.BID) {
      AppPrint.all(
          "Bid-> controller: bidingTimerStatus-> ${bidingTimerStatus.value}");
      if (bidingTimerStatus.value == TimerTypeStatus.UPCOMING) {
        return 0;
      }
      if (bidingTimerStatus.value == TimerTypeStatus.GOINGON ||
          bidingTimerStatus.value == TimerTypeStatus.GOINGON_NO_BID_YET) {
        return 1;
      }
    }
    return null;
  }
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

  addBidListener(AddBidsHistory? data) {
    bidingData.value = data;
    if (data?.save?.createdAt != null) {
      // Refresh Timer when other user bid on
      bidingEndAfter.value = DateTime.parse(data!.save!.createdAt!)
          .toLocal()
          .add(Duration(minutes: incrementTimeAfterNewBid.value));
    }
    addBbidingLoading.value = false;
  }

  //
  getBidHistories({required String productId}) {
    bidingDataLoading.value = true;
    SocketEmits.getLastBidAndHistory(productId: productId);
  }

  getBidHistoriesListener(AddBidsHistory? data) {
    bidingData.value = data;

    if (data?.save?.createdAt != null) {
      DateTime lastBidTime = DateTime.parse(data!.save!.createdAt!).toLocal();
      DateTime today = DateTime.now();

      Duration temp = lastBidTime.difference(today);
      print(temp.inSeconds);
      if (temp.inSeconds <= 0) {
        bidAlradyEnd.value = true;
      } else {
        bidingEndAfter.value =
            lastBidTime.add(Duration(minutes: incrementTimeAfterNewBid.value));
      }
    }
    bidingDataLoading.value = false;
  }
  //

  bidOver({required String productId}) {
    SocketEmits.bidOver(productId: productId);
  }

  bidOverListener(bool data) {
    socketPrint("Biding over...");
  }

  ///--------- Biding ---------
}

enum ProductType { BID, FIX_PRICE, SHERE }

enum ProductStatus { BIDED_ON }
