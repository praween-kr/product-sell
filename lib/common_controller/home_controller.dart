import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_widget/app_string.dart';
import 'package:oninto_flutter/generated/assets.dart';
import 'package:oninto_flutter/model/home_model.dart';
import 'package:oninto_flutter/routes/routes.dart';
import '../model/onboard_model.dart';

class Homecontroller extends GetxController {
  RxBool homePass = true.obs;
  RxBool Switch = false.obs;
  var tabController = 0.obs;
  late PageController pageController;

  RxList<CommonModel> onBoardingData = RxList([]);
  RxList<HomeModel> Categorydata = RxList([]);

  RxInt pagePosition = RxInt(0);

  @override
  void onInit() {
    super.onInit();

    pageController = PageController(initialPage: pagePosition.value);
    onBoardingData = RxList([
      CommonModel(
          image: Assets.assetshome1,
          title: "Login Your Details",
          description: AppStrings.Onboarding),
      CommonModel(
          image: Assets.assetshome2,
          title: "Add Your Product",
          description: AppStrings.Onboarding),
      CommonModel(
          image: Assets.assetshome3,
          title: "Sold Your Product",
          description: AppStrings.Onboarding),
    ]);
    Categorydata = RxList([
      HomeModel(
        image: Assets.assetgirl,
        Name: "Women",
      ),
      HomeModel(
        image: Assets.assetshirt,
        Name: "Men",
      ),
      HomeModel(
        image: Assets.assetkids,
        Name: "Kids",
      ),
      HomeModel(
        image: Assets.assetroom,
        Name: "Home & living",
      ),
      HomeModel(
        image: Assets.assetelectronic,
        Name: "Electronic",
      ),
      HomeModel(
        image: Assets.assetbeauty,
        Name: "Beauty",
      ),
      HomeModel(
        image: Assets.assetamericanball,
        Name: "Sports",
      ),
      HomeModel(
        image: Assets.assetdog,
        Name: "Pets",
      ),
      HomeModel(
        image: Assets.assetcard,
        Name: "Cards",
      ),
      HomeModel(
        image: Assets.assetcar,
        Name: "Vehicle",
      ),
    ]);
  }

  void onPageChanged(index) {
    pagePosition.value = index;
  }

  void nextScreen(int index) {
    onBoardingData.refresh();
    pageController.nextPage(duration: 300.milliseconds, curve: Curves.ease);
  }
}
