import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_controller/home_controller.dart';
import 'package:oninto_flutter/common_widget/app_text.dart';
import 'package:oninto_flutter/common_widget/color_constant.dart';
import 'package:oninto_flutter/generated/assets.dart';
import 'package:oninto_flutter/routes/routes.dart';
import 'package:oninto_flutter/utills/colors_file.dart';

import '../../../common_widget/appbar.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({
    Key? key,
  }) : super(key: key);
  final controller = Get.put(Homecontroller());

  @override
  Widget build(BuildContext context) {
    if (Get.arguments != null) {
      controller.tabController.value = Get.arguments;
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppbarWidget(
        leading: GestureDetector(
          onTap: () {
            Get.back();
            Get.back();
          },
          child: Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.only(left: 12),
            decoration: BoxDecoration(
                color: AppColor.appcolor,
                borderRadius: BorderRadius.circular(15)),
            child: const Icon(Icons.arrow_back_ios),
          ),
        ),
        heading: "My Products",
        textStyle: const TextStyle(
            fontSize: 20,
            color: blackColor,
            fontWeight: FontWeight.w500,
            fontFamily: "Poppins"),
        action: PopupMenuButton(
          tooltip: "",
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(22))),
          offset: const Offset(0, 20),
          icon: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColor.appcolor),
            ),
            child:
                const Icon(Icons.filter_alt_rounded, color: AppColor.appcolor),
          ),
          onSelected: (value) {
            value();
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              // padding: EdgeInsets.zero,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: AppText(
                      text: "Sort by",
                      textAlign: TextAlign.center,
                      textSize: 12,
                      color: Colors.black,
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                ],
              ),
              value: () {
                Get.toNamed(Routes.filterScreen);
              },
            ),
            PopupMenuItem(
              // padding: EdgeInsets.zero,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: AppText(
                  text: "Sold",
                  textAlign: TextAlign.center,
                  textSize: 12,
                  color: Colors.black,
                ),
              ),

              value: () {},
            ),
            PopupMenuItem(
              //padding: EdgeInsets.zero,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: AppText(
                  text: "New Added",
                  textAlign: TextAlign.center,
                  textSize: 12,
                  color: Colors.black,
                ),
              ),
              value: () {},
            ),
            PopupMenuItem(
              // padding: EdgeInsets.zero,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: AppText(
                  text: "Pending",
                  textAlign: TextAlign.center,
                  textSize: 12,
                  color: Colors.black,
                ),
              ),
              value: () {},
            ),
          ],
        ),
      ),
      body: Obx(
        () => DefaultTabController(
          length: 3,
          initialIndex: controller.tabController.value,
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
                        controller.tabController.value = index;
                      },
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      // indicatorColor: Colors.grey,
                      // labelColor: Colors.black,
                      // unselectedLabelColor: Colors.grey,
                      indicatorWeight: 1,
                      tabs: [
                        Container(
                          height: 40,
                          width: 100,
                          margin: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                              color: controller.tabController.value == 0
                                  ? AppColor.appcolor
                                  : Colors.white,
                              border: Border.all(
                                color: controller.tabController.value == 0
                                    ? AppColor.appcolor
                                    : Colors.grey.shade300,
                              ),
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                            child: AppText(
                              text: "Buy",
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w400,
                              color: controller.tabController.value == 0
                                  ? Colors.white
                                  : Colors.grey.shade500,
                            ),
                          ),
                        ),
                        Container(
                          height: 40,
                          width: 100,
                          margin: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                              color: controller.tabController.value == 1
                                  ? AppColor.appcolor
                                  : Colors.white,
                              border: Border.all(
                                color: controller.tabController.value == 1
                                    ? AppColor.appcolor
                                    : Colors.grey.shade300,
                              ),
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                            child: AppText(
                              text: "Sell",
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w400,
                              color: controller.tabController.value == 1
                                  ? Colors.white
                                  : Colors.grey.shade500,
                            ),
                          ),
                        ),
                        Container(
                          height: 40,
                          width: 100,
                          margin: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                              color: controller.tabController.value == 2
                                  ? AppColor.appcolor
                                  : Colors.white,
                              border: Border.all(
                                color: controller.tabController.value == 2
                                    ? AppColor.appcolor
                                    : Colors.grey.shade300,
                              ),
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                            child: AppText(
                              text: "Co-owner",
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w400,
                              color: controller.tabController.value == 2
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
                      GridView.builder(
                          physics: const ClampingScrollPhysics(),
                          padding: const EdgeInsets.only(top: 20),
                          // padding:
                          //     const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1.1,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 2),
                          itemCount: 6,
                          itemBuilder: (context, index) {
                            //  var data = controller.Categorydata[index];
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Homecontroller controller = Get.find();
                                    controller.productValue.value = 1;
                                    controller.touchTap.value = true;
                                    controller.menu.value = true;
                                    controller.filter.value = false;
                                    Get.toNamed(Routes.bottomScreen);
                                    Map<String, dynamic> data = {
                                      "from": 1,
                                    };
                                    Get.toNamed(Routes.denimScreen,
                                        arguments: data);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        bottom: 10,
                                        left: 20,
                                        right: 20,
                                        top: 7),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(19),
                                        boxShadow: const [
                                          BoxShadow(
                                              color: Color(0xff17000000),
                                              offset: Offset(0, 3),
                                              blurRadius: 6)
                                        ]),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Stack(children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Image.asset(
                                              Assets.assetsGirlJean,
                                              fit: BoxFit.cover,
                                              height: 100,
                                              width: 100,
                                            ),
                                          ),
                                          const Positioned(
                                              right: 0,
                                              top: 5,
                                              child: Icon(Icons.more_vert,
                                                  color: Colors.white)),
                                        ]),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const AppText(
                                          text: "10 mins ago",
                                          textSize: 12,
                                          color: Color(0x4d000000),
                                          fontWeight: FontWeight.w400,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const AppText(
                                          text: "Girl Denim",
                                          textSize: 13,
                                          color: Color(0xff000000),
                                          fontWeight: FontWeight.w500,
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        const AppText(
                                          text: "\$2000",
                                          textSize: 18,
                                          color: Color(0xff000000),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                      GridView.builder(
                          physics: const ClampingScrollPhysics(),
                          padding: const EdgeInsets.only(
                              top: 20, left: 20, right: 20),
                          // padding:
                          //     const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.78,
                                  mainAxisSpacing: 30,
                                  crossAxisSpacing: 30),
                          itemCount: 6,
                          itemBuilder: (context, index) {
                            //  var data = controller.Categorydata[index];
                            return GestureDetector(
                              onTap: () {
                                if (index % 2 == 0) {
                                } else {
                                  Get.toNamed(Routes.productDetailScreen);
                                }
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(19),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Color(0xff17000000),
                                          offset: Offset(0, 3),
                                          blurRadius: 6)
                                    ]),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Stack(children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.asset(
                                          Assets.assetsMobile,
                                          height: 130,
                                          width: 130,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      Positioned(
                                          left: 5,
                                          top: 5,
                                          right: 0,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              index % 2 == 0
                                                  ? Container(
                                                      height: 20,
                                                      width: 50,
                                                      decoration: BoxDecoration(
                                                          color: const Color(
                                                              0xff30E165),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: const Center(
                                                        child: AppText(
                                                          text: "Sold",
                                                          textSize: 10,
                                                          color: Colors.white,
                                                        ),
                                                      ))
                                                  : Container(),
                                              const Icon(Icons.more_vert,
                                                  color: Colors.white)
                                            ],
                                          )),
                                    ]),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              AppText(
                                                text: "10 mins ago",
                                                textSize: 12,
                                                color: Color(0x4d000000),
                                                fontWeight: FontWeight.w400,
                                              ),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              AppText(
                                                text: "Girl Denim",
                                                textSize: 13,
                                                color: Color(0xff000000),
                                                fontWeight: FontWeight.w500,
                                              ),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              AppText(
                                                text: "\$2000",
                                                textSize: 18,
                                                color: Color(0xff000000),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Icon(
                                                Icons.favorite,
                                                color: AppColor.appcolor,
                                                size: 12,
                                              ),
                                              AppText(
                                                text: "12",
                                                textSize: 12,
                                                color: Color(0x4d000000),
                                                fontWeight: FontWeight.w500,
                                              ),
                                              Icon(
                                                Icons.remove_red_eye_outlined,
                                                color: AppColor.appcolor,
                                                size: 12,
                                              ),
                                              AppText(
                                                text: "199",
                                                textSize: 13,
                                                color: Color(0x4d000000),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                      GridView.builder(
                          physics: const ClampingScrollPhysics(),
                          padding: const EdgeInsets.only(
                              top: 20, left: 20, right: 20),
                          // padding:
                          //     const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.76,
                                  mainAxisSpacing: 30,
                                  crossAxisSpacing: 30),
                          itemCount: 6,
                          itemBuilder: (context, index) {
                            //  var data = controller.Categorydata[index];
                            return GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.gyradosScreen);
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(19),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Color(0xff17000000),
                                          offset: Offset(0, 3),
                                          blurRadius: 6)
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Stack(children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.asset(
                                            Assets.assetsGyradox,
                                            height: 130,
                                            width: 130,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Positioned(
                                            left: 5,
                                            top: 5,
                                            right: 0,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                    height: 20,
                                                    width: 50,
                                                    decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xff30E165),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: const Center(
                                                      child: AppText(
                                                        text: "Sold",
                                                        textSize: 10,
                                                        color: Colors.white,
                                                      ),
                                                    )),
                                              ],
                                            )),
                                      ]),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AppText(
                                            text: "10 mins ago",
                                            textSize: 12,
                                            color: Color(0x4d000000),
                                            fontWeight: FontWeight.w400,
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          AppText(
                                            text: "Gyarados EX",
                                            textSize: 13,
                                            color: Color(0xff000000),
                                            fontWeight: FontWeight.w500,
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          AppText(
                                            text: "\$300",
                                            textSize: 18,
                                            color: Color(0xff000000),
                                            fontWeight: FontWeight.w500,
                                          ),
                                          SizedBox(
                                            height: 1,
                                          ),
                                          AppText(
                                            text: "Sold on : 29 May 2023",
                                            textSize: 10,
                                            color: Color(0x4d000000),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
