import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_controller/home_controller.dart';
import 'package:oninto_flutter/common_widget/appbar.dart';
import 'package:oninto_flutter/common_widget/color_constant.dart';
import 'package:oninto_flutter/generated/assets.dart';
import 'package:oninto_flutter/routes/routes.dart';
import 'package:oninto_flutter/utills/colors_file.dart';
import 'package:oninto_flutter/utills/common_appbar.dart';

class NavBarMsgScreen extends StatelessWidget {
  NavBarMsgScreen({super.key});
  final Homecontroller controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: CommonAppbarWidget(
        leading: const Text(""),
        heading: "Message",
        textStyle: const TextStyle(
            fontSize: 20,
            color: blackColor,
            fontWeight: FontWeight.w500,
            fontFamily: "Poppins"),
      ),
      body: DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Column(
          children: [
            Obx(() => TabBar(
                    splashFactory: NoSplash.splashFactory,
                    overlayColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                      // Use the default focused overlay color
                      return states.contains(MaterialState.focused)
                          ? null
                          : Colors.transparent;
                    }),
                    onTap: (index) {
                      controller.messageController.value = index;
                    },
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    indicator:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    // indicatorColor: Colors.grey,
                    // labelColor: Colors.black,
                    // unselectedLabelColor: Colors.grey,
                    indicatorWeight: 1,
                    tabs: [
                      Container(
                        height: 42,
                        width: 148,
                        margin: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            color: controller.messageController.value == 0
                                ? AppColor.appcolor
                                : Colors.white,
                            border: Border.all(
                              color: controller.messageController.value == 0
                                  ? AppColor.appcolor
                                  : Colors.grey.shade300,
                            ),
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: AppText(
                            text: "Community",
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400,
                            color: controller.messageController.value == 0
                                ? Colors.white
                                : Colors.grey.shade500,
                          ),
                        ),
                      ),
                      Container(
                        height: 42,
                        width: 148,
                        margin: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            color: controller.messageController.value == 1
                                ? AppColor.appcolor
                                : Colors.white,
                            border: Border.all(
                              color: controller.messageController.value == 1
                                  ? AppColor.appcolor
                                  : Colors.grey.shade300,
                            ),
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: AppText(
                            text: "Messages",
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400,
                            color: controller.messageController.value == 1
                                ? Colors.white
                                : Colors.grey.shade500,
                          ),
                        ),
                      ),
                    ])),
            Expanded(
              child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    ListView.builder(
                        itemCount: 2,
                        shrinkWrap: true,
                        itemBuilder: (context, position) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 35.0, vertical: 15.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Get.toNamed(Routes.gyaradoMsgScreen);
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            Assets.assetsCrowd,
                                            height: 57.0,
                                            width: 57.0,
                                          ),
                                          const SizedBox(
                                            width: 12.0,
                                          ),
                                          const AppText(
                                            text: "Gyarado EX",
                                            textSize: 15.0,
                                            color: AppColor.blackColor,
                                            style: AppTextStyle.medium,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10.0,
                                                vertical: 10.0),
                                            decoration: const BoxDecoration(
                                              color: AppColor.appcolor,
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Center(
                                              child: AppText(
                                                text: "2",
                                                color: AppColor.white,
                                                textSize: 10.0,
                                                style: AppTextStyle.regular,
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                color: AppColor.blackColor.withOpacity(0.1),
                                height: 1.0,
                                thickness: 1.0,
                              )
                            ],
                          );
                        }),
                    ListView.builder(
                        itemCount: 4,
                        shrinkWrap: true,
                        itemBuilder: (context, position) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 35.0, vertical: 15.0),
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Get.toNamed(Routes.messageScreen);
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              Image.asset(
                                                Assets.assetsGirlJean,
                                                height: 57.0,
                                                width: 57.0,
                                              ),
                                              const SizedBox(
                                                width: 12.0,
                                              ),
                                              Column(
                                                children: [
                                                  const AppText(
                                                    text: "Men Tshirt",
                                                    textSize: 15.0,
                                                    color: AppColor.blackColor,
                                                    style: AppTextStyle.title,
                                                  ),
                                                  const SizedBox(
                                                    height: 7.0,
                                                  ),
                                                  AppText(
                                                    text: "Send Images",
                                                    textSize: 12.0,
                                                    color: AppColor.blackColor
                                                        .withOpacity(0.3),
                                                    style: AppTextStyle.medium,
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10.0,
                                                        vertical: 10.0),
                                                decoration: const BoxDecoration(
                                                  color: AppColor.appcolor,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Center(
                                                  child: AppText(
                                                    text: "2",
                                                    color: AppColor.white,
                                                    textSize: 10.0,
                                                    style: AppTextStyle.regular,
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                color: AppColor.blackColor.withOpacity(0.1),
                                height: 1.0,
                                thickness: 1.0,
                              )
                            ],
                          );
                        })
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
