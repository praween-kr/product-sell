import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swipable_stack/swipable_stack.dart';
import '../../common_controller/home_controller.dart';
import '../../common_widget/app_text.dart';
import '../../common_widget/appbar.dart';
import '../../common_widget/color_constant.dart';
import '../../common_widget/common_button.dart';
import '../../generated/assets.dart';
import '../../routes/routes.dart';
import '../../utills/colors_file.dart';

class SubCategoryScreen extends StatelessWidget {
   SubCategoryScreen({super.key});
  final controller = Get.put(Homecontroller());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.white,
        appBar: CommonAppbarWidget(
        leading: GestureDetector(
         onTap:
          () {
          Get.back();
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
        ),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 25.0),
          child: Column(
            children: [
              /// Touch Button
              Obx(
                    ()=> controller.menu.value
                    ? Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.menu.value = true;
                          controller.touchTap.value = true;
                          controller.filter.value = false;
                          controller.selectValue.value = 0;
                          print("menu value${controller.menu.value}");

                        },
                        child: controller.selectValue.value == 0
                            ?Image.asset(
                          Assets.assetsTouch,
                          height: 30,
                          width: 30,
                        ) :Image.asset(
                          Assets.assetsTouchIcon,
                          height: 30,
                          width: 30,
                        ),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      /// Filter Button
                      Padding(
                        padding: const EdgeInsets.only(right: 7.0),
                        child: GestureDetector(
                          onTap: () {
                            controller.filter.value = true;
                            controller.touchTap.value = false;
                            controller.selectValue.value=1;
                            print("menu value${controller.menu.value}");
                          },
                          child:  controller.selectValue.value == 1
                              ? Image.asset(
                            Assets.assetsSortIcon,
                            height: 30,
                            width: 30,
                          ) :Image.asset(
                            Assets.assetsSort,
                            height: 30,
                            width: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                    : Container(),
              ),
              Obx(
                    ()=> controller.menu.value
                    ? const SizedBox(
                  height: 20,
                )
                    : const SizedBox(),
              ),
              /// when menu == true (Category Screen),
              /// +when filter == true(Filter Screen),
              /// When touchTap== ture(Home Screen)
              Obx(
                    () => controller.menu.value == true
                    ? Expanded(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: controller.filter.value
                          ? Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: AppText(
                              text: "Near by",
                              textSize: 17,
                              color: blackColor,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Poppins",
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          /// Filter Click List View
                          Expanded(
                            child: ListView.builder(
                              itemCount: 5,
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemBuilder: (BuildContext context,
                                  int index) {
                                return GestureDetector(
                                  onTap: () {
                                    Map<String, dynamic> data = {
                                      "from": 0,
                                    };
                                    Get.toNamed(Routes.denimScreen, arguments: data);
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                          margin:
                                          const EdgeInsets.only(
                                              left: 10),
                                          padding:
                                          const EdgeInsets.only(
                                              bottom: 10,
                                              top: 10,
                                              left: 20,
                                              right: 20),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment
                                                .start,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                BorderRadius
                                                    .circular(
                                                    20),
                                                child: Center(
                                                  child: Image.asset(
                                                      Assets
                                                          .assetsGirlJean,
                                                      height: 170,
                                                      width: 300,
                                                      fit: BoxFit
                                                          .fill),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  const AppText(
                                                    text:
                                                    "\$200.00",
                                                    textSize: 15,
                                                    color:
                                                    blackColor,
                                                    fontWeight:
                                                    FontWeight
                                                        .w600,
                                                  ),
                                                  Icon(
                                                    Icons.favorite,
                                                    color: AppColor
                                                        .blackColor.withOpacity(0.2),
                                                  )
                                                ],
                                              ),
                                              const AppText(
                                                text:
                                                "Dolce & Gabbana",
                                                textSize: 10,
                                                color: blackColor,
                                                fontWeight:
                                                FontWeight.w400,
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              const AppText(
                                                text: "XL/42",
                                                textSize: 10,
                                                color: blackColor,
                                                fontWeight:
                                                FontWeight.w600,
                                              ),
                                            ],
                                          )),
                                      const Divider(
                                        thickness: 1,
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      )
                          : controller.touchTap.value == true  ?
                      Stack(children: [
                        GestureDetector(
                          onTap: () {},
                          child: SwipableStack(
                            builder: (context, properties) {
                              return Stack(
                                clipBehavior: Clip.none,
                                alignment: Alignment.bottomCenter,
                                children: [
                                  Image.asset(Assets.assetsHomeBid,
                                    fit: BoxFit.fill,
                                    height: Get.height,
                                  ),
                                  /// like and Dislike Heart View
                                  Positioned(
                                    bottom: -17,
                                    child: Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          Assets.assetsDislike,
                                          height: 50,
                                          width: 50,
                                        ),
                                        const SizedBox(
                                          width: 70,
                                        ),
                                        Obx(
                                              ()=> GestureDetector(
                                            onTap: (){
                                              controller.heartColor.value = true;
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                                              decoration:  BoxDecoration(
                                                  color: controller.heartColor.value == true?
                                                  AppColor.prdtextColor:
                                                  AppColor.blackColor,
                                                  shape: BoxShape.circle
                                              ),
                                              child: const Center(
                                                  child: Icon(Icons.favorite,color: AppColor.white,size: 30,
                                                  )
                                              ),
                                            ),
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
                          bottom: Get.height *.1,
                          left: 20,
                          child:
                          Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  // controller.sub.value = true;
                                  controller.menu.value = false;
                                  //  controller.touchTap.value = true;
                                  Get.toNamed(Routes.menshirtScreen);
                                },
                                child:  const AppText(
                                  text: "Men Black Tshirt",
                                  textSize: 18,
                                  fontFamily: "Poppins",
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
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
                              GestureDetector(
                                onTap: () {
                                  timerDialog();
                                  },
                                child: CommonButton(
                                  height: 40,
                                  radius: 15,
                                  color: AppColor.appcolor,
                                  text:
                                  "Bid \$2500",
                                  textStyle: const TextStyle(
                                    fontSize: 15,
                                    fontFamily: "Poppins",
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
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
                              GestureDetector(
                                onTap: (){
                                  Get.toNamed(Routes.biddingScreen);
                                },
                                child: RichText(
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
                                                fontWeight:
                                                FontWeight.w400,
                                                decoration: TextDecoration
                                                    .underline),
                                          )
                                        ])),
                              )
                            ],
                          ),

                        )
                      ])
                          :Container()
                  ),
                )
                /// SubCategory View
                //     : Expanded(
                //   child: GridView.builder(
                //       physics: const ClampingScrollPhysics(),
                //       padding: const EdgeInsets.symmetric(
                //           horizontal: 5, vertical: 5),
                //       gridDelegate:
                //       const SliverGridDelegateWithFixedCrossAxisCount(
                //           crossAxisCount: 3, childAspectRatio: 0.75),
                //       itemCount: 6,
                //       itemBuilder: (context, index) {
                //         var data = controller.Categorydata[index];
                //         return GestureDetector(
                //           onTap: () {
                //             Get.toNamed(Routes.menScreen);
                //             print("menu value ${controller.menu.value}");
                //           },
                //           child: Column(
                //             children: [
                //               Container(
                //                 margin: const EdgeInsets.only(top: 20),
                //                 padding: const EdgeInsets.only(
                //                     top: 15,
                //                     bottom: 15,
                //                     left: 20,
                //                     right: 20),
                //                 decoration: BoxDecoration(
                //                     borderRadius:
                //                     BorderRadius.circular(10),
                //                     border: Border.all(
                //                         color: Colors.grey, width: 1)),
                //                 child: Image.asset(
                //                   data.image,
                //                   fit: BoxFit.contain,
                //                   height: 70,
                //                   width: 50,
                //                 ),
                //               ),
                //               const SizedBox(
                //                 height: 10,
                //               ),
                //               AppText(
                //                 text: controller.Categorydata[index].Name,
                //                 color: Colors.black,
                //                 textSize: 14,
                //               )
                //             ],
                //           ),
                //         );
                //       }),
                // ),
                :Container()
              ),
            ],
          ),
        ),
      ),
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
                             Get.back();
                             controller.bidHistoryDialog();
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
