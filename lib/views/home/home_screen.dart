import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_controller/home_controller.dart';
import 'package:oninto_flutter/common_widget/app_text.dart';
import 'package:oninto_flutter/common_widget/color_constant.dart';
import 'package:oninto_flutter/common_widget/common_button.dart';
import 'package:oninto_flutter/generated/assets.dart';
import 'package:oninto_flutter/routes/routes.dart';
import 'package:oninto_flutter/utills/commontextfield.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:swipable_stack/swipable_stack.dart';

import '../../common_widget/app_textfield.dart';
import '../../utills/colors_file.dart';

class HomeScreen extends StatelessWidget {
  Map<String, dynamic>? data;
  HomeScreen({Key? key, required this.data}) : super(key: key);
  final controller = Get.put(Homecontroller());
  static String _pincode(String option) => (option).toString();
  List<String> searchHints = [
    "Search test",
    "Search test 1",
    "Search test 2",
    "Search test 3"
  ];

  @override
  Widget build(BuildContext context) {
    print("data ${controller.touchTap.value}");
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: AppText(
                            text: "  Hello, jenny",
                            textSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
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
                        PopupMenuButton(
                          tooltip: "",
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          offset: const Offset(0, 20),
                          icon: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColor.appcolor),
                            ),
                            child: const Icon(Icons.filter_alt_rounded,
                                color: AppColor.appcolor),
                          ),
                          onSelected: (value) {
                            value();
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              padding: EdgeInsets.zero,
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
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
                              padding: EdgeInsets.zero,
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: AppText(
                                  text: "Lowest Lot #",
                                  textAlign: TextAlign.center,
                                  textSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                              value: () {},
                            ),
                            PopupMenuItem(
                              padding: EdgeInsets.zero,
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: AppText(
                                  text: "Highest Price",
                                  textAlign: TextAlign.center,
                                  textSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                              value: () {},
                            ),
                            PopupMenuItem(
                              padding: EdgeInsets.zero,
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: AppText(
                                  text: "Ending Soonest",
                                  textAlign: TextAlign.center,
                                  textSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                              value: () {},
                            ),
                            PopupMenuItem(
                              padding: EdgeInsets.zero,
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: AppText(
                                  text: "Lowest Price",
                                  textAlign: TextAlign.center,
                                  textSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                              value: () {},
                            ),
                            PopupMenuItem(
                              padding: EdgeInsets.zero,
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: AppText(
                                  text: "Most Bid",
                                  textAlign: TextAlign.center,
                                  textSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                              value: () {},
                            ),
                          ],
                        ),
                        /* GestureDetector(
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
                        ),*/
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.notificationScreen);
                          },
                          child: Container(
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
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Obx(
                () => controller.menu.value
                    ? Container()
                    :

                    /// SearchFiled and Category Grid View
                    Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          // GestureDetector(
                          //   onTap: () {},
                          //   child: Container(
                          //     padding: const EdgeInsets.only(
                          //         top: 10, left: 20, bottom: 10),
                          //     margin:
                          //         const EdgeInsets.symmetric(horizontal: 30),
                          //     decoration: BoxDecoration(
                          //         color: AppColor.TextColor,
                          //         borderRadius: BorderRadius.circular(50)),
                          //     child: Row(
                          //       children: [
                          //         Icon(Icons.search),
                          //         SizedBox(
                          //           width: 10,
                          //         ),
                          //         Expanded(
                          //           child: Obx(
                          //             () => Autocomplete<String>(
                          //               displayStringForOption: _pincode,
                          //               optionsBuilder: (TextEditingValue
                          //                   textEditingValue) {
                          //                 controller.searchInput.value.text =
                          //                     textEditingValue.text;
                          //                 if (controller
                          //                         .searchInput.value.text ==
                          //                     '') {
                          //                   return const Iterable<
                          //                       String>.empty();
                          //                 }
                          //                 return (searchHints)
                          //                     .where((String option) {
                          //                   return 'tets'.toString().contains(
                          //                       "to match".toLowerCase());
                          //                 });
                          //               },
                          //               onSelected: (String selection) {
                          //                 debugPrint(
                          //                     'You just selected ${selection}');
                          //               },
                          //               initialValue: TextEditingValue(
                          //                   text: controller
                          //                       .searchInput.value.text),
                          //               fieldViewBuilder: (BuildContext context,
                          //                   TextEditingController
                          //                       textEditingController,
                          //                   FocusNode focusNode,
                          //                   VoidCallback onFieldSubmitted) {
                          //                 return AppTextField(
                          //                   controller: textEditingController,
                          //                   // borderColor: Colors.transparent,
                          //                   // fillColor:
                          //                   //     Colors.grey.withOpacity(0.4),
                          //                   height: 50,
                          //                   title: "Enter Pin Code",
                          //                   onChanged: (v) {
                          //                     controller
                          //                         .searchInput.value.text = v;
                          //                     print(
                          //                         "controller.searchInput.value.text::: ${controller.searchInput.value.text}");
                          //                   },
                          //                   focusNode: focusNode,
                          //                 );
                          //               },
                          //               optionsViewBuilder: (BuildContext
                          //                       context,
                          //                   void Function(String) onSelected,
                          //                   Iterable<String> options) {
                          //                 return Material(
                          //                   color: Colors.transparent,
                          //                   child: SizedBox(
                          //                     child: SingleChildScrollView(
                          //                       child: Container(
                          //                         decoration:
                          //                             const BoxDecoration(
                          //                           color: Colors.transparent,
                          //                           borderRadius:
                          //                               BorderRadius.all(
                          //                             Radius.circular(8),
                          //                           ),
                          //                         ),
                          //                         child: Column(
                          //                           crossAxisAlignment:
                          //                               CrossAxisAlignment
                          //                                   .start,
                          //                           children:
                          //                               options.map((opt) {
                          //                             return Container(
                          //                               width: Get.width - 85,
                          //                               color: Colors
                          //                                   .grey.shade400,
                          //                               child: InkWell(
                          //                                 onTap: () {
                          //                                   onSelected(opt);
                          //                                 },
                          //                                 child: const Padding(
                          //                                   padding: EdgeInsets
                          //                                       .symmetric(
                          //                                           horizontal:
                          //                                               14,
                          //                                           vertical:
                          //                                               10),
                          //                                   child:
                          //                                       Text('list 1'),
                          //                                 ),
                          //                               ),
                          //                             );
                          //                           }).toList(),
                          //                         ),
                          //                       ),
                          //                     ),
                          //                   ),
                          //                 );
                          //               },
                          //             ),
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          //
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 14),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(45)),
                              child: AppTextField(
                                height: 45,
                                controller: controller.searchInput.value,
                                title: "Search",
                                hintStyle: const TextStyle(
                                    color: AppColor.blackColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),
                                prefix: const Icon(
                                  Icons.search,
                                  color: Colors.black,
                                ),
                                containerColor: AppColor.TextColor,
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 4),
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
                      ),
              ),
              // /// Touch Button
              // Obx(
              // ()=> controller.menu.value
              //     ? Padding(
              //     padding: const EdgeInsets.only(right: 15),
              //     child: Row(
              //         mainAxisAlignment: MainAxisAlignment.end,
              //         crossAxisAlignment: CrossAxisAlignment.end,
              //         children: [
              //           GestureDetector(
              //             onTap: () {
              //               controller.menu.value = true;
              //               controller.touchTap.value = true;
              //               controller.filter.value = false;
              //               controller.selectValue.value = 0;
              //               print("menu value${controller.menu.value}");
              //
              //             },
              //             child: controller.selectValue.value == 0
              //                 ?Image.asset(
              //               Assets.assetsTouch,
              //               height: 30,
              //               width: 30,
              //             ) :Image.asset(
              //                  Assets.assetsTouchIcon,
              //                  height: 30,
              //                  width: 30,
              //                  ),
              //           ),
              //           const SizedBox(
              //             width: 6,
              //           ),
              //           /// Filter Button
              //           Padding(
              //             padding: const EdgeInsets.only(right: 7.0),
              //             child: GestureDetector(
              //                 onTap: () {
              //                   controller.filter.value = true;
              //                   controller.touchTap.value = false;
              //                   controller.selectValue.value=1;
              //                   print("menu value${controller.menu.value}");
              //                 },
              //                 child:  controller.selectValue.value == 1
              //                ? Image.asset(
              //                   Assets.assetsSortIcon,
              //                   height: 30,
              //                   width: 30,
              //                 ) :Image.asset(
              //                   Assets.assetsSort,
              //                   height: 30,
              //                   width: 30,
              //                 ),
              //               ),
              //           ),
              //         ],
              //     ),
              //   )
              //       : Container(),
              // ),
              Obx(
                () => controller.menu.value
                    ? const SizedBox(
                        height: 20,
                      )
                    : const SizedBox(),
              ),

              /// when menu == true (Category Screen), when filter == true(Filter Screen),
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
                                                Get.toNamed(Routes.denimScreen,
                                                    arguments: data);
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
                                                                    .blackColor
                                                                    .withOpacity(
                                                                        0.2),
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
                                : controller.touchTap.value == true
                                    ?
                                    // Stack(children: [
                                    //   GestureDetector(
                                    //     onTap: () {},
                                    //     child: SwipableStack(
                                    //       builder: (context, properties) {
                                    //         return Stack(
                                    //           clipBehavior: Clip.none,
                                    //           alignment: Alignment.bottomCenter,
                                    //           children: [
                                    //             Image.asset(Assets.assetsHomeBid),
                                    //             Positioned(
                                    //               bottom: -17,
                                    //               child: Row(
                                    //                 crossAxisAlignment:
                                    //                 CrossAxisAlignment.center,
                                    //                 mainAxisAlignment:
                                    //                 MainAxisAlignment.center,
                                    //                 children: [
                                    //                   Image.asset(
                                    //                     Assets.assetsDislike,
                                    //                     height: 50,
                                    //                     width: 50,
                                    //                   ),
                                    //                   const SizedBox(
                                    //                     width: 70,
                                    //                   ),
                                    //                   Obx(
                                    //                      ()=> GestureDetector(
                                    //                       onTap: (){
                                    //                         controller.heartColor.value = true;
                                    //                       },
                                    //                       child: Container(
                                    //                         padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                                    //                         decoration:  BoxDecoration(
                                    //                           color: controller.heartColor.value == true?
                                    //                           AppColor.prdtextColor:
                                    //                             AppColor.blackColor,
                                    //                           shape: BoxShape.circle
                                    //                         ),
                                    //                         child: const Center(
                                    //                           child: Icon(Icons.favorite,color: AppColor.white,size: 30,
                                    //                           )
                                    //                         ),
                                    //                       ),
                                    //                     ),
                                    //                   )
                                    //                 ],
                                    //               ),
                                    //             )
                                    //           ],
                                    //         );
                                    //       },
                                    //     ),
                                    //   ),
                                    //   Positioned(
                                    //     bottom: Get.height *.18,
                                    //     left: 20,
                                    //     child:
                                    //           Column(
                                    //         crossAxisAlignment:
                                    //         CrossAxisAlignment.start,
                                    //         children: [
                                    //           GestureDetector(
                                    //             onTap: (){
                                    //              // controller.sub.value = true;
                                    //              controller.menu.value = false;
                                    //              //  controller.touchTap.value = true;
                                    //              Get.toNamed(Routes.menshirtScreen);
                                    //              print("menShirt ${controller.menu.value}");
                                    //       },
                                    //             child:  const AppText(
                                    //               text: "Men Black Tshirt",
                                    //               textSize: 18,
                                    //               fontFamily: "Poppins",
                                    //               color: Colors.white,
                                    //               fontWeight: FontWeight.w400,
                                    //             ),
                                    //           ),
                                    //           const SizedBox(
                                    //             height: 10,
                                    //           ),
                                    //           const AppText(
                                    //             text: "\$4000.00",
                                    //             textSize: 18,
                                    //             color: Colors.white,
                                    //             fontFamily: "Poppins",
                                    //             fontWeight: FontWeight.w400,
                                    //           ),
                                    //           const SizedBox(
                                    //             height: 10,
                                    //           ),
                                    //           GestureDetector(
                                    //             onTap: () {
                                    //               timerDialog();
                                    //
                                    //                 },
                                    //             child: CommonButton(
                                    //               height: 40,
                                    //               radius: 15,
                                    //               color: AppColor.appcolor,
                                    //               text:
                                    //               "Bid \$2500",
                                    //               textStyle: const TextStyle(
                                    //                 fontSize: 15,
                                    //                 fontFamily: "Poppins",
                                    //                 color: Colors.white,
                                    //                 fontWeight: FontWeight.w400,
                                    //               ),
                                    //             ),
                                    //           ),
                                    //           const SizedBox(
                                    //             height: 10,
                                    //           ),
                                    //            const AppText(
                                    //             text: "min \$4000.00",
                                    //             textSize: 10,
                                    //             color: Colors.white,
                                    //             fontFamily: "Poppins",
                                    //             fontWeight: FontWeight.w400,
                                    //           ),
                                    //          const SizedBox(
                                    //             height: 10,
                                    //           ),
                                    //           GestureDetector(
                                    //             onTap: (){
                                    //               Get.toNamed(Routes.biddingScreen);
                                    //             },
                                    //             child: RichText(
                                    //                 text: const TextSpan(
                                    //                     text: "20 Bid",
                                    //                     style: TextStyle(
                                    //                       color: Colors.white,
                                    //                       fontSize: 10,
                                    //                       fontFamily: "Poppins",
                                    //                       fontWeight: FontWeight.w400,
                                    //                     ),
                                    //                     children: [
                                    //                       TextSpan(
                                    //                         text: "Show bid history",
                                    //                         style: TextStyle(
                                    //                             color: Colors.white,
                                    //                             fontSize: 10,
                                    //                             fontFamily: "Poppins",
                                    //                             fontWeight:
                                    //                             FontWeight.w400,
                                    //                             decoration: TextDecoration
                                    //                                 .underline),
                                    //                       )
                                    //                     ])),
                                    //           )
                                    //         ],
                                    //       ),
                                    //
                                    //   )
                                    // ])
                                    Container()
                                    : Container()),
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
                                onTap: () {
                                  Get.toNamed(Routes.menScreen);
                                  print("menu value ${controller.menu.value}");
                                },
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
            ],
          ),
          floatingActionButton: Align(
            alignment: Alignment.bottomRight,
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
