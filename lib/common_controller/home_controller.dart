import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_widget/app_string.dart';
import 'package:oninto_flutter/generated/assets.dart';

import '../model/onboard_model.dart';

class Homecontroller extends GetxController {
  Rx HomePass = true.obs;
  Rx Switch = false.obs;

  late PageController pageController;

  RxList<CommonModel> onBoardingData = RxList([]);

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
          image: Assets.assetshome1,
          title: "Sold Your Product",
          description: AppStrings.Onboarding),
    ]);
  }

  @override
  void onClose() {
    super.onClose();
    pageController.dispose();
  }

  void onPageChanged(index) {
    pagePosition.value = index;
  }

  void nextScreen(int index) {
    onBoardingData.refresh();
    pageController.nextPage(duration: 300.milliseconds, curve: Curves.ease);
  }
}
