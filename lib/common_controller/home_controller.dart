import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_widget/app_string.dart';
import 'package:oninto_flutter/generated/assets.dart';
import 'package:oninto_flutter/model/home_model.dart';
import 'package:oninto_flutter/routes/routes.dart';
import 'package:oninto_flutter/utills/colors_file.dart';
import 'package:swipable_stack/swipable_stack.dart';
import '../common_widget/app_text.dart';
import '../common_widget/color_constant.dart';
import '../common_widget/common_button.dart';
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
  var menu = false.obs;
  var controller = SwipableStackController();

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

  Future timerDialog() async {
    print("clicked---- ");

    return showDialog(
        barrierDismissible: true,
        useSafeArea: false,
        context: Get.context!,
        builder: (BuildContext context) {
          return Material(
            type: MaterialType.transparency,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    margin: const EdgeInsets.only(left: 30, right: 30),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black,
                            offset: Offset(
                              0.0,
                              0.0,
                            ),
                            blurRadius: 5.0,
                            spreadRadius: 0.0,
                          ), //BoxShadow
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 0.0,
                            spreadRadius: 0.0,
                          ), //BoxShadow
                        ],
                        // borderRadius: BorderRadius.all(Radius.circular(17)),
                        color: Colors.white),
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 20, right: 20, left: 20),
                    child: Column(
                      children: [
                        const AppText(
                          text: "Bid Now",
                          textSize: 15,
                          color: blackColor,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w400,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AppText(
                              text: "\$",
                              textSize: 14,
                              color: blackColor,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Poppins",
                            ),
                            AppText(
                              text: "2000",
                              textSize: 20,
                              color: blackColor,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Poppins",
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const AppText(
                          text: "Minimum \$2000",
                          textSize: 10,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Poppins",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const AppText(
                              text: "Bid History",
                              textSize: 12,
                              color: blackColor,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Poppins",
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.biddingScreen);
                              },
                              child: const AppText(
                                text: "See all",
                                textSize: 10,
                                color: blackColor,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Poppins",
                              ),
                            ),
                          ],
                        ),
                        ListView.builder(
                            itemCount: 5,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return const Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 20, right: 20, top: 20),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        AppText(
                                          text: "J*******th",
                                          textSize: 15,
                                          fontFamily: "Poppins",
                                          color: blackColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        AppText(
                                          text: "\$2100",
                                          textSize: 15,
                                          color: AppColor.appcolor,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider()
                                ],
                              );
                            }),
                        CommonButton(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          color: AppColor.appcolor,
                          text: "Confirm",
                          radius: 15,
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily: "Poppins",
                              fontSize: 15,
                              color: Colors.white),
                        ),
                      ],
                    )),
              ],
            ),
          );
        });
  }
}
