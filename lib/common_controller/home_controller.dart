

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_widget/app_string.dart';
import 'package:oninto_flutter/generated/assets.dart';
import 'package:oninto_flutter/model/home_model.dart';
import '../model/onboard_model.dart';
import '../utills/helper/camera_helper.dart';

class Homecontroller extends GetxController
    implements CameraOnCompleteListener {
  RxBool homePass = true.obs;
  RxBool Switch = false.obs;
  RxBool upload = false.obs;
  var tabController = 0.obs;
  var messageController = 0.obs;
  var imagePath = "".obs;
  late PageController pageController;
  late CameraHelper cameraHelper;

  RxList<CommonModel> onBoardingData = RxList([]);
  RxList<HomeModel> Categorydata = RxList([]);

  RxInt pagePosition = RxInt(0);

  @override
  void onInit() {
    cameraHelper = CameraHelper(this);
    super.onInit();
    pageController = PageController(initialPage: pagePosition.value);
    onBoardingData = RxList([
      CommonModel(
          image: Assets.assetsHome1,
          title: "Login Your Details",
          description: AppStrings.Onboarding),
      CommonModel(
          image: Assets.assetsHome2,
          title: "Add Your Product",
          description: AppStrings.Onboarding),
      CommonModel(
          image: Assets.assetsHome3,
          title: "Sold Your Product",
          description: AppStrings.Onboarding),
    ]);
    Categorydata = RxList([
      HomeModel(
        image: Assets.assetsGirl,
        Name: "Women",
      ),
      HomeModel(
        image: Assets.assetsShirt,
        Name: "Men",
      ),
      HomeModel(
        image: Assets.assetsKids,
        Name: "Kids",
      ),
      HomeModel(
        image: Assets.assetsRoom,
        Name: "Home & living",
      ),
      HomeModel(
        image: Assets.assetsElectronic,
        Name: "Electronic",
      ),
      HomeModel(
        image: Assets.assetsBeauty,
        Name: "Beauty",
      ),
      HomeModel(
        image: Assets.assetsAmericanBall,
        Name: "Sports",
      ),
      HomeModel(
        image: Assets.assetsDog,
        Name: "Pets",
      ),
      HomeModel(
        image: Assets.assetsCard,
        Name: "Cards",
      ),
      HomeModel(
        image: Assets.assetsCar,
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



  @override
  void onSuccessFile(File file, String fileType) {
    imagePath.value = file.path;
  }

  void reset() {
    imagePath.value = "";
  }
}
