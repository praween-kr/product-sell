import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_widget/app_string.dart';
import 'package:oninto_flutter/generated/assets.dart';
import 'package:oninto_flutter/model/home_model.dart';

import '../model/onboard_model.dart';

class Homecontroller extends GetxController {
  RxBool HomePass = true.obs;
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
    ]);
  }

  @override
  void onClose() {
    super.onClose();
    //pageController.dispose();
  }

  void onPageChanged(index) {
    pagePosition.value = index;
  }

  void nextScreen(int index) {
    onBoardingData.refresh();
    pageController.nextPage(duration: 300.milliseconds, curve: Curves.ease);
  }
}
