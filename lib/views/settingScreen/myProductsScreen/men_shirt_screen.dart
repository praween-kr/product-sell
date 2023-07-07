import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_controller/home_controller.dart';
import 'package:oninto_flutter/common_widget/appbar.dart';
import 'package:oninto_flutter/common_widget/common_button.dart';
import 'package:oninto_flutter/generated/assets.dart';
import 'package:oninto_flutter/routes/routes.dart';
import 'package:oninto_flutter/utills/common_appbar.dart';

import '../../../common_widget/color_constant.dart';
import '../../../utills/colors_file.dart';

class MenshirtScreen extends StatelessWidget {
  MenshirtScreen({super.key}) {
    // controller.timerDialog();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.menu.value) {
        controller.timerDialog();
      } else {
        return;
      }
    });
  }
  final controller = Get.put(Homecontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppbarWidget(
        heading: "Men Black Tshirt",
        textStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontSize: 18,
            fontFamily: "Poppins"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Stack(children: [
              Image.asset(Assets.assetsFashion),
              Positioned(
                  left: 20,
                  top: MediaQuery.of(context).size.height * 0.30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        Assets.assetsMen,
                        height: 80,
                        width: 80,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Image.asset(
                        Assets.assetsBack,
                        height: 80,
                        width: 80,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Image.asset(
                        Assets.assetsShop,
                        height: 80,
                        width: 80,
                      ),
                    ],
                  )),
            ]),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const AppText(
                        text:
                            "Men's Black Oversized T-shirt \nPhoto-Matched, Signed",
                        textSize: 15,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.messageScreen);
                        },
                        child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                color: AppColor.appcolor,
                                borderRadius: BorderRadius.circular(20)),
                            child: const Icon(
                              Icons.message,
                              color: Colors.white,
                            )),
                      )
                    ],
                  ),
                  const Row(
                    children: [
                      Icon(Icons.star, color: AppColor.appcolor),
                      SizedBox(
                        width: 5,
                      ),
                      AppText(
                        text: "/4.5",
                        textSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0x4d000000),
                        fontFamily: "Poppins",
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: AppText(
                          text: "Current Bid :",
                          textSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff9F9F9F),
                          fontFamily: "Poppins",
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const AppText(
                            text: "\$2000",
                            textSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontFamily: "Poppins",
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const AppText(
                            text: "Min \$2000",
                            textSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Color(0x1e000000),
                            fontFamily: "Poppins",
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.biddingScreen);
                            },
                            child: RichText(
                                text: const TextSpan(
                                    text: "20 Bid ",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Poppins"),
                                    children: [
                                  TextSpan(
                                      text: "Show bid history",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Poppins",
                                          fontSize: 12,
                                          color: Colors.black,
                                          decoration: TextDecoration.underline))
                                ])),
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: AppText(
                          text: "Current Bid :",
                          textSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff9F9F9F),
                          fontFamily: "Poppins",
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          RichText(
                              text: const TextSpan(
                                  text: "12D 11H 15M | ",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Poppins"),
                                  children: [
                                TextSpan(
                                    text: "Thu, 5/25/23, 3:00 AM",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Poppins",
                                      fontSize: 12,
                                      color: Color(0xff908A8A),
                                    ))
                              ])),
                          const SizedBox(
                            height: 5,
                          ),
                          RichText(
                              text: const TextSpan(
                                  text: "Extended Bidding Interval ",
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: Color(0xff908A8A),
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Poppins"),
                                  children: [
                                TextSpan(
                                    text: "30 minutes",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Poppins",
                                      fontSize: 11,
                                      color: Colors.black,
                                    ))
                              ])),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            const Divider(
              color: Color(0x66000000),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      AppText(
                        text: "Category : ",
                        textSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff9F9F9F),
                        fontFamily: "Poppins",
                      ),
                      AppText(
                        text: "girl",
                        textSize: 12,
                        fontWeight: FontWeight.w400,
                        color: blackColor,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      AppText(
                        text: "Sub Category : ",
                        textSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff9F9F9F),
                        fontFamily: "Poppins",
                      ),
                      AppText(
                        text: "Jean",
                        textSize: 12,
                        fontWeight: FontWeight.w400,
                        color: blackColor,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      AppText(
                        text: "Color :  ",
                        textSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff9F9F9F),
                        fontFamily: "Poppins",
                      ),
                      AppText(
                        text: " Blue",
                        textSize: 12,
                        fontWeight: FontWeight.w400,
                        color: blackColor,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      AppText(
                        text: "Brand : ",
                        textSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff9F9F9F),
                        fontFamily: "Poppins",
                      ),
                      AppText(
                        text: " Tommy",
                        textSize: 12,
                        fontWeight: FontWeight.w400,
                        color: blackColor,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
            const Divider(
              color: Color(0x66000000),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20, left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: "Condition",
                    textSize: 15,
                    fontWeight: FontWeight.w400,
                    color: AppColor.appcolor,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  AppText(
                    text: "New with tags",
                    textSize: 13,
                    fontWeight: FontWeight.w400,
                    color: blackColor,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  AppText(
                    text:
                        "A brand-new, unused item with tags attached\nor in the original packing.",
                    textSize: 12,
                    fontWeight: FontWeight.w400,
                    lineHeight: 1.3,
                    color: Color(0x4d000000),
                    fontFamily: "Poppins",
                  ),
                ],
              ),
            ),
            const Divider(
              color: Color(0x66000000),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
              ),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 20,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            AppText(
                              text: "Size :",
                              textSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0x4d000000),
                            ),
                            AppText(
                              text: "XL / 42 / 14",
                              textSize: 12,
                              fontWeight: FontWeight.w400,
                              color: blackColor,
                              fontFamily: "Poppins",
                            )
                          ],
                        ),
                        Row(
                          children: [
                            AppText(
                              text: "Location  :",
                              textSize: 12,
                              color: Color(0x4d000000),
                              fontWeight: FontWeight.w400,
                            ),
                            AppText(
                              text: "Lorem Ipsum California",
                              textSize: 12,
                              fontWeight: FontWeight.w400,
                              color: blackColor,
                              fontFamily: "Poppins",
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            AppText(
                              text: "Posted Date :",
                              textSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0x4d000000),
                            ),
                            AppText(
                              text: "26 May 2020",
                              textSize: 12,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Poppins",
                              color: blackColor,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Image.asset(Assets.assetsSale),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20, left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: "Item Description",
                    textSize: 13,
                    fontFamily: "Poppins",
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  AppText(
                      text: "Comfort Experience comfort to greates",
                      textSize: 13,
                      fontFamily: "Poppins",
                      color: Color(0x4d000000)),
                  SizedBox(
                    height: 10,
                  ),
                  AppText(
                    text: "Quick Bid :",
                    textSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff9F9F9F),
                  )
                ],
              ),
            ),
            Obx(
              () => controller.sub.value
                  ? CommonButton(
                      height: 50,
                      radius: 15,
                      margin:
                          const EdgeInsets.only(left: 20, right: 20, top: 20),
                      color: AppColor.appcolor,
                      text: "Edit Bid",
                      textStyle: const TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Poppins"),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CommonButton(
                            height: 50,
                            width: 150,
                            radius: 18,
                            color: AppColor.appcolor,
                            text: "Bid \$2500",
                            textStyle: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Poppins"),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          CommonButton(
                            height: 50,
                            width: 150,
                            color: AppColor.appcolor,
                            radius: 18,
                            text: "Bid \$3500",
                            textStyle: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Poppins"),
                          ),
                        ],
                      ),
                    ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
