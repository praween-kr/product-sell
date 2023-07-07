import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_controller/home_controller.dart';
import 'package:oninto_flutter/common_widget/app_text.dart';
import 'package:oninto_flutter/common_widget/color_constant.dart';
import 'package:oninto_flutter/common_widget/common_button.dart';
import 'package:oninto_flutter/generated/assets.dart';
import 'package:oninto_flutter/routes/routes.dart';
import 'package:swipable_stack/swipable_stack.dart';

class HomeScreen extends StatelessWidget {
  Map<String, dynamic>? data;
  HomeScreen({Key? key, required this.data}) : super(key: key);
  final controller = Get.put(Homecontroller());

  @override
  Widget build(BuildContext context) {
    print("data ${data}");
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.only(
            top: 60,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          text: "  Hello, jenny",
                          textSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.amberAccent,
                            ),
                            AppText(
                              text: "Street albert, california",
                              textSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0x80000000),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 30,
                            width: 30,
                            margin: const EdgeInsets.only(
                              right: 7,
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColor.appcolor),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                showPopupMenu(context);
                              },
                              child: const Icon(Icons.filter_alt_rounded,
                                  color: AppColor.appcolor),
                            ),
                          ),
                        ),
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              color: AppColor.appcolor,
                              borderRadius: BorderRadius.circular(15)),
                          child: const Icon(
                            Icons.notifications,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Obx(() => controller.menu.value
                  ? Container()
                  : Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.verificationScreen);
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                                top: 10, left: 20, bottom: 10),
                            margin: const EdgeInsets.symmetric(horizontal: 30),
                            decoration: BoxDecoration(
                                color: AppColor.TextColor,
                                borderRadius: BorderRadius.circular(50)),
                            child: const Row(
                              children: [
                                Icon(Icons.search),
                                SizedBox(
                                  width: 10,
                                ),
                                AppText(
                                    text: "Search",
                                    textSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0x80000000))
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Image.asset(
                          Assets.assetsSale,
                          fit: BoxFit.fill,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                            top: 20,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const AppText(
                                text: "Shop by category",
                                fontWeight: FontWeight.w600,
                                textSize: 16,
                                color: Colors.black,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(
                                    Routes.categoryScreen,
                                  );
                                },
                                child: const AppText(
                                    text: "See all",
                                    fontWeight: FontWeight.w400,
                                    textSize: 12,
                                    color: Color(0x80000000)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              controller.menu.value
                  ? Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Image.asset(
                            Assets.assetsTouch,
                            height: 30,
                            width: 30,
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Container(
                            height: 30,
                            width: 30,
                            margin: const EdgeInsets.only(
                              right: 7,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColor.appcolor),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                //  showPopupMenu(context);
                              },
                              child: const Icon(Icons.sort,
                                  color: AppColor.appcolor),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(),
              controller.menu.value
                  ? const SizedBox(
                      height: 20,
                    )
                  : const SizedBox(),
              Obx(
                () => controller.menu.value
                    ? Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Stack(children: [
                            GestureDetector(
                              onTap: () {
                                timerDialog();
                              },
                              child: SwipableStack(
                                builder: (context, properties) {
                                  return Stack(
                                    clipBehavior: Clip.none,
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      Image.asset(Assets.assetsHomeBid),
                                      Positioned(
                                        bottom: -17,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 40,
                                              width: 40,
                                              decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.black),
                                              child: const Icon(
                                                Icons.favorite,
                                                size: 20,
                                                color: Colors.red,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 70,
                                            ),
                                            Container(
                                              height: 40,
                                              width: 40,
                                              decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.black),
                                              child: const Icon(
                                                Icons.favorite,
                                                size: 20,
                                                color: Colors.red,
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  );
                                },
                              ),
                            ),
                            Positioned(
                              bottom: 40,
                              left: 20,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const AppText(
                                    text: "Men Black Tshirt",
                                    textSize: 18,
                                    fontFamily: "Poppins",
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const AppText(
                                    text: "\$4000.00",
                                    textSize: 18,
                                    color: Colors.white,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w400,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  CommonButton(
                                    height: 40,
                                    radius: 15,
                                    color: AppColor.appcolor,
                                    text: "Bid \$2500",
                                    textStyle: const TextStyle(
                                      fontSize: 15,
                                      fontFamily: "Poppins",
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const AppText(
                                    text: "min \$4000.00",
                                    textSize: 10,
                                    color: Colors.white,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w400,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  RichText(
                                      text: const TextSpan(
                                          text: "20 Bid",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontFamily: "Poppins",
                                            fontWeight: FontWeight.w400,
                                          ),
                                          children: [
                                        TextSpan(
                                          text: "Show bid history",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w400,
                                              decoration:
                                                  TextDecoration.underline),
                                        )
                                      ]))
                                ],
                              ),
                            )
                          ]),
                        ),
                      )
                    : Expanded(
                        child: GridView.builder(
                            physics: const ClampingScrollPhysics(),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3, childAspectRatio: 0.75),
                            itemCount: 6,
                            itemBuilder: (context, index) {
                              var data = controller.Categorydata[index];
                              return GestureDetector(
                                child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(top: 20),
                                      padding: const EdgeInsets.only(
                                          top: 15,
                                          bottom: 15,
                                          left: 20,
                                          right: 20),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: Colors.grey, width: 1)),
                                      child: Image.asset(
                                        data.image,
                                        fit: BoxFit.contain,
                                        height: 70,
                                        width: 50,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    AppText(
                                      text: controller.Categorydata[index].Name,
                                      color: Colors.black,
                                      textSize: 14,
                                    )
                                  ],
                                ),
                              );
                            }),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 80, right: 20),
                child: Align(
                  alignment: Alignment.topRight,
                  child: FloatingActionButton(
                    onPressed: () {
                      Get.toNamed(Routes.sellItemScreen);
                    },
                    backgroundColor: AppColor.appcolor,
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  showPopupMenu(BuildContext context) {
    showMenu<String>(
      context: context,
      position: const RelativeRect.fromLTRB(25.0, 25.0, 0.0,
          0.0), //position where you want to show the menu on screen
      items: [
        PopupMenuItem<String>(
            value: '1',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.filterScreen);
                  },
                  child: const AppText(
                    text: 'Sort by',
                    textAlign: TextAlign.center,
                    textSize: 12,
                    color: Colors.black,
                  ),
                ),
                const Divider(
                  color: Colors.black,
                ),
              ],
            )),
        const PopupMenuItem<String>(
            value: '2',
            child: AppText(
              text: 'Lowest Lot #',
              textAlign: TextAlign.center,
              textSize: 12,
              color: Colors.black,
            )),
        const PopupMenuItem<String>(
            value: '3',
            child: AppText(
              text: 'Highest Price',
              textAlign: TextAlign.center,
              textSize: 12,
              color: Colors.black,
            )),
        const PopupMenuItem<String>(
            value: '4',
            child: AppText(
              text: 'Ending Soonest',
              textAlign: TextAlign.center,
              textSize: 12,
              color: Colors.black,
            )),
        const PopupMenuItem<String>(
            value: '5',
            child: AppText(
              text: 'Lowest Price',
              textAlign: TextAlign.center,
              textSize: 12,
              color: Colors.black,
            )),
        const PopupMenuItem<String>(
            value: '6',
            child: AppText(
              text: 'Most Bid',
              textAlign: TextAlign.center,
              textSize: 12,
              color: Colors.black,
            )),
      ],
      elevation: 8.0,
    );
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
                        Image.asset(
                          Assets.assetsClock,
                          height: 100,
                          width: 100,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const AppText(
                          text: "00:00:10",
                          color: Color(0xffFF0505),
                          fontWeight: FontWeight.w400,
                          fontFamily: "Poppins",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.menshirtScreen);
                          },
                          child: CommonButton(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            color: AppColor.appcolor,
                            text: "Bid Now",
                            radius: 15,
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontFamily: "Poppins",
                                fontSize: 15,
                                color: Colors.white),
                          ),
                        )
                      ],
                    )),
              ],
            ),
          );
        });
  }
}
