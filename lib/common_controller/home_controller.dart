import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_controller/auth/auth_controller.dart';
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
  // RxBool homePass = true.obs;
  // RxBool Switch = false.obs;
  RxBool upload = false.obs;
  var tabController = 1.obs;
  var coOwnerController = 0.obs;
  var messageController = 0.obs;
  var timer = false.obs;
  var imagePath = "".obs;
  late PageController pageController;
  late CameraHelper cameraHelper;
  var menu = false.obs;
  var heartColor = false.obs;
  var touchTap = false.obs;

  var searchInput = Rx<TextEditingController>(TextEditingController(text: ''));

  /// o for menu and 1 for filter selected
  var selectValue = 0.obs;
  var filter = false.obs;
  var sub = false.obs;
  var track = false.obs;
  var trackupload = false.obs;
  RxInt productValue = 0.obs;
  String value = "";

  var controller = SwipableStackController();

  RxList<CommonModel> onBoardingData = RxList([]);
  RxList<HomeModel> Categorydata = RxList([]);
  RxInt pagePosition = RxInt(0);

  @override
  void onInit() {
    cameraHelper = CameraHelper(this);
    Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (pagePosition < 2) {
        pagePosition++;
        pageController.animateToPage(
          pagePosition.value,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      } else {
        pagePosition.value = 2;
      }
    });
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
    // TODO: implement onClose
    //pageController.dispose();
    super.onClose();
  }

  void reset() {
    imagePath.value = "";
  }

  Future bidHistoryDialog() async {
    print("clicked---- ");
    return showDialog(
        barrierDismissible: true,
        useSafeArea: false,
        context: Get.context!,
        builder: (BuildContext context) {
          return GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Material(
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
                          const SizedBox(
                            height: 10,
                          ),
                          const AppText(
                            text: "Bid Now",
                            textSize: 15,
                            color: blackColor,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // Center(
                          //   child: IntrinsicWidth(
                          //     child: AppTextField(
                          //       textAlign: TextAlign.center,
                          //       textInputType: TextInputType.number,
                          //       inputFormatters: <TextInputFormatter>[
                          //         FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                          //       ],
                          //       maxLines: 3,
                          //       containerColor: AppColor.textfield,
                          //       hintStyle: const TextStyle(
                          //         color: AppColor.blackColor,
                          //         fontWeight: FontWeight.w400,
                          //         fontFamily: "Poppins",
                          //       ),
                          //       contentPadding: const EdgeInsets.symmetric(
                          //           vertical: 20,horizontal: 20
                          //       ),
                          //       prefix: const Icon(Icons.attach_money,
                          //         color: AppColor.blackColor,size: 18,),
                          //     ),
                          //   ),
                          // ),
                          Container(
                            decoration: BoxDecoration(
                              color: AppColor.textfield,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: IntrinsicWidth(
                                child: TextField(
                                  cursorColor: AppColor.blackColor,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                      RegExp("[0-9]"),
                                    ),
                                    LengthLimitingTextInputFormatter(5)
                                  ],
                                  keyboardType: TextInputType.number,
                                  textAlignVertical: TextAlignVertical.center,
                                  style: const TextStyle(
                                      color: AppColor.blackColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20),
                                  decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 20, horizontal: 20),
                                      hintText: "2500",
                                      hintStyle: TextStyle(
                                          color: AppColor.blackColor
                                              .withOpacity(0.2),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20),
                                      prefixIcon: const Icon(
                                        Icons.attach_money_outlined,
                                        color: AppColor.blackColor,
                                      ),
                                      border: InputBorder.none,
                                      prefixIconConstraints:
                                          const BoxConstraints(
                                        maxWidth: 20,
                                        maxHeight: 40,
                                      )),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          const AppText(
                            text: "Minimum \$2000",
                            textSize: 10,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Poppins",
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Row(
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
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          ListView.builder(
                              itemCount: 5,
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return const Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                      ),
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
                          GestureDetector(
                            onTap: () {
                              Get.back();
                              sub.value = true;
                              // Get.back();
                              Get.toNamed(Routes.menshirtScreen);
                            },
                            child: CommonButton(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              color: AppColor.appcolor,
                              text: "Confirm",
                              radius: 15,
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Poppins",
                                  fontSize: 15,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          );
        });
  }

  ///-----------------------====================-----------------------
}
