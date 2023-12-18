import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/Socket/model/add_bids_histories.dart';
import 'package:oninto_flutter/common_controller/home/categories_controller.dart';
import 'package:oninto_flutter/common_controller/home/home_controller.dart';
import 'package:oninto_flutter/generated/assets.dart';
import 'package:oninto_flutter/model/home/home_model.dart';
import 'package:oninto_flutter/routes/routes.dart';
import 'package:oninto_flutter/service/apis.dart';
import 'package:oninto_flutter/service/local/user_info_global.dart';
import 'package:oninto_flutter/utils/app_text.dart';
import 'package:oninto_flutter/utils/color_constant.dart';
import 'package:oninto_flutter/utils/common_button.dart';
import 'package:oninto_flutter/utils/common_widgets.dart';
import 'package:oninto_flutter/utils/helper/stripe_services.dart';
import 'package:oninto_flutter/utils/image_view.dart';
import 'package:oninto_flutter/utils/shimmer_widget.dart';
import 'package:oninto_flutter/utils/widgets/dialogs.dart';

import '../../utils/app_text_field.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final HomeCatProductController controller = Get.find();

  @override
  Widget build(BuildContext context) {
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
              /// Appbar ///
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Obx(
                              () => AppText(
                                text:
                                    "  Hello, ${Get.find<GlobalController>().userInfo.value?.firstName ?? ''} ${Get.find<GlobalController>().userInfo.value?.lastName ?? ''}",
                                textSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: Colors.amberAccent,
                                size: 16,
                              ),
                              Expanded(
                                child: Obx(
                                  () => AppText(
                                    text: Get.find<GlobalController>()
                                            .userInfo
                                            .value
                                            ?.location ??
                                        '',
                                    textSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0x80000000),
                                    maxlines: 1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
                              border: Border.all(color: AppColor.appColor),
                            ),
                            child: const Icon(Icons.filter_alt_rounded,
                                color: AppColor.appColor),
                          ),
                          onSelected: (value) => value(),
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
                                  Divider(thickness: 1),
                                ],
                              ),
                              value: () {},
                            ),
                            // popupMenuItem(
                            //     title: "Lowest Lot #", onClick: () {
                            //       controller.filterProducts(l)
                            //     }),
                            popupMenuItem(
                                title: "Highest Price",
                                onClick: () => _navigateToFilter(2)),
                            popupMenuItem(
                                title: "Ending Soonest",
                                onClick: () => _navigateToFilter(1)),
                            popupMenuItem(
                                title: "Lowest Price",
                                onClick: () => _navigateToFilter(4)),
                            popupMenuItem(
                                title: "Most Bid",
                                onClick: () => _navigateToFilter(5)),
                            popupMenuItem(
                                title: "Resent Bid",
                                onClick: () => _navigateToFilter(6)),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.notificationScreen);
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                color: AppColor.appColor,
                                borderRadius: BorderRadius.circular(15)),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                const Icon(Icons.notifications,
                                    color: Colors.white, size: 25),
                                Obx(
                                  () => (controller.homeData.value
                                                  ?.notificationCount ??
                                              0) ==
                                          0
                                      ? const SizedBox.shrink()
                                      : const Positioned(
                                          top: 5,
                                          right: 7,
                                          child: CircleAvatar(
                                              backgroundColor: Colors.red,
                                              radius: 3)),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              /// Body ///
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    if (controller.searchAndFilterApplied.value) {
                      controller.localFavourites.clear();
                      await controller.searchProducts();
                    } else {
                      await controller.getHomeData();
                    }
                  },
                  child: Obx(
                    () => controller.loadingData.value
                        ? ShimmerWidgets.home()
                        : SingleChildScrollView(
                            physics: const ClampingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            child: Column(
                              children: [
                                const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(45)),
                                    child: AppTextField(
                                      keyBoardType: TextInputAction.search,
                                      onFieldSubmitted: (value) async {
                                        await controller.searchProducts();
                                      },
                                      height: 45,
                                      controller: controller.searchInput,
                                      title: "Search",
                                      hintStyle: const TextStyle(
                                          color: AppColor.blackColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                      prefix: const Icon(Icons.search,
                                          color: Colors.black),
                                      containerColor: AppColor.textColor,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 4),
                                    ),
                                  ),
                                ),
                                controller.searchAndFilterApplied.value
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 18),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                                child: AppText(
                                              text: "Search & filter applied",
                                              textSize: 12,
                                              color: Colors.grey.shade700,
                                            )),
                                            IconButton(
                                              splashRadius: 22,
                                              iconSize: 14,
                                              icon: Icon(Icons.clear,
                                                  size: 20,
                                                  color: Colors.grey.shade700),
                                              onPressed: () {
                                                controller.searchInput.clear();
                                                controller
                                                    .searchAndFilterApplied
                                                    .value = false;
                                              },
                                            ),
                                          ],
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                                const SizedBox(height: 15),

                                /// --------Category Body-----------
                                controller.searchAndFilterApplied.value
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 12.0),
                                        child: GridView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            padding: const EdgeInsets.only(
                                                top: 20, left: 20, right: 20),
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2,
                                                    childAspectRatio: 0.65,
                                                    mainAxisSpacing: 30,
                                                    crossAxisSpacing: 30),
                                            itemCount:
                                                controller.products.length,
                                            itemBuilder: (context, index) {
                                              //  var data = controller.Categorydata[index];
                                              var product =
                                                  controller.products[index];
                                              return Obx(
                                                () => CommonWidgets
                                                    .productGridCard2(
                                                  isFavourite: controller
                                                                  .localFavourites[
                                                              (product.id ?? '')
                                                                  .toString()] !=
                                                          null
                                                      ? controller.localFavourites[
                                                              (product.id ?? '')
                                                                  .toString()] ??
                                                          false
                                                      : product.isFavourite ==
                                                          1,
                                                  favouriteClick: () {
                                                    controller
                                                        .addProductAsFavourite(
                                                            (product.id ?? '')
                                                                .toString());
                                                  },
                                                  productImage:
                                                      (product.productImages ??
                                                                  [])
                                                              .isNotEmpty
                                                          ? product
                                                                  .productImages!
                                                                  .first
                                                                  .image ??
                                                              ''
                                                          : '',
                                                  lastUpdate:
                                                      product.updatedAt ?? '',
                                                  price: double.parse(
                                                      product.price ?? '0.0'),
                                                  title: product.name ?? '',
                                                  onClick: () {
                                                    controller
                                                        .getProductDetails(
                                                            (product.id ?? '')
                                                                .toString());
                                                    Get.toNamed(Routes
                                                        .productDetailsScreen);
                                                  },
                                                ),
                                              );
                                            }),
                                      )
                                    : Column(
                                        children: [
                                          AppImage.view(
                                              "${ImageBaseUrls.category}${(controller.homeData.value?.image ?? [
                                                    ImageModel()
                                                  ]).first.image ?? ''}",
                                              height: Get.height * 0.22,
                                              width: double.infinity,
                                              fit: BoxFit.cover),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20, right: 20, top: 20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const AppText(
                                                  text: "Shop by category",
                                                  fontWeight: FontWeight.w600,
                                                  textSize: 16,
                                                  color: Colors.black,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    if (CategoriesController()
                                                        .initialized) {
                                                      Get.find<
                                                              CategoriesController>()
                                                          .getCategories();
                                                    } else {
                                                      Get.put(CategoriesController())
                                                          .getCategories();
                                                    }
                                                    Get.toNamed(
                                                        Routes.categoryScreen);
                                                  },
                                                  child: const AppText(
                                                      text: "See all",
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      textSize: 12,
                                                      color: Color(0x80000000)),
                                                ),
                                              ],
                                            ),
                                          ),

                                          /// ----Categories data----
                                          const SizedBox(height: 14),
                                          Obx(
                                            () => GridView.builder(
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5,
                                                        vertical: 5),
                                                gridDelegate:
                                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 3,
                                                        childAspectRatio: 0.9),
                                                itemCount: (controller.homeData
                                                            .value?.category ??
                                                        [])
                                                    .length,
                                                itemBuilder: (context, index) {
                                                  var data = controller.homeData
                                                      .value?.category?[index];
                                                  return GestureDetector(
                                                    onTap: () {
                                                      CategoriesController cc;
                                                      if (CategoriesController()
                                                          .initialized) {
                                                        cc = Get.find<
                                                            CategoriesController>();
                                                      } else {
                                                        cc = Get.put(
                                                            CategoriesController());
                                                      }
                                                      cc.getSubCategories(
                                                          (data?.id ?? '')
                                                              .toString());
                                                      cc.selectedCategory
                                                          .value = data;
                                                      Get.toNamed(
                                                          Routes.subCategories);
                                                    },
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        10),
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .grey,
                                                                    width: 1)),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              child: AppImage.view(
                                                                  "${ImageBaseUrls.category}${data?.image ?? ''}",
                                                                  height: 70,
                                                                  width: 70,
                                                                  fit: BoxFit
                                                                      .cover),
                                                            )),
                                                        const SizedBox(
                                                            height: 10),
                                                        AppText(
                                                          text:
                                                              data?.name ?? '',
                                                          color: const Color
                                                              .fromARGB(
                                                              255, 6, 4, 4),
                                                          textSize: 12,
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                }),
                                          ),
                                        ],
                                      ),
                              ],
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              onPressed: () {
                if (CategoriesController().initialized) {
                  Get.find<CategoriesController>().getCategories();
                } else {
                  Get.put(CategoriesController()).getCategories();
                }
                Get.toNamed(Routes.sellItemScreen);
              },
              backgroundColor: AppColor.appColor,
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

  PopupMenuItem<Function> popupMenuItem(
      {required String title, required Function onClick}) {
    return PopupMenuItem(
      padding: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: AppText(
          text: title,
          textAlign: TextAlign.center,
          textSize: 12,
          color: Colors.black,
        ),
      ),
      value: () => onClick(),
    );
  }

  _navigateToFilter(int filterKey) async {
    controller.selectedFilterKey.value = filterKey;
    controller.filterProducts();
    Get.toNamed(Routes.filterScreen, arguments: {'from': 'home'});
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
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                            AppDialogs.bidHistoryDialog(
                              bidingData: AddBidsHistory(),
                              confirm: () =>
                                  Get.toNamed(Routes.bidingProductDetails),
                              seeAll: () =>
                                  Get.toNamed(Routes.biddingHistoryScreen),
                            );
                          },
                          child: const CommonButton(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            color: AppColor.appColor,
                            text: "Bid Now",
                            radius: 15,
                            textStyle: TextStyle(
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


// Expanded(
                              //         child: Padding(
                              //             padding: const EdgeInsets.symmetric(
                              //                 horizontal: 20),
                              //             child: controller.filter.value
                              //                 ? Column(
                              //                     crossAxisAlignment:
                              //                         CrossAxisAlignment.start,
                              //                     children: [
                              //                       const Padding(
                              //                         padding:
                              //                             EdgeInsets.only(left: 20),
                              //                         child: AppText(
                              //                           text: "Near by",
                              //                           textSize: 17,
                              //                           color: blackColor,
                              //                           fontWeight: FontWeight.w600,
                              //                           fontFamily: "Poppins",
                              //                         ),
                              //                       ),
                              //                       const SizedBox(
                              //                         height: 10,
                              //                       ),
                              //                       Expanded(
                              //                         child: ListView.builder(
                              //                           itemCount: 5,
                              //                           shrinkWrap: true,
                              //                           padding: EdgeInsets.zero,
                              //                           itemBuilder:
                              //                               (BuildContext context,
                              //                                   int index) {
                              //                             return GestureDetector(
                              //                               onTap: () {
                              //                                 Map<String, dynamic>
                              //                                     data = {
                              //                                   "from": 0,
                              //                                 };
                              //                                 Get.toNamed(
                              //                                     Routes
                              //                                         .denimScreen,
                              //                                     arguments: data);
                              //                               },
                              //                               child: Column(
                              //                                 children: [
                              //                                   Container(
                              //                                       margin:
                              //                                           const EdgeInsets
                              //                                               .only(
                              //                                               left:
                              //                                                   10),
                              //                                       padding:
                              //                                           const EdgeInsets
                              //                                               .only(
                              //                                               bottom:
                              //                                                   10,
                              //                                               top: 10,
                              //                                               left:
                              //                                                   20,
                              //                                               right:
                              //                                                   20),
                              //                                       child: Column(
                              //                                         crossAxisAlignment:
                              //                                             CrossAxisAlignment
                              //                                                 .start,
                              //                                         children: [
                              //                                           ClipRRect(
                              //                                             borderRadius:
                              //                                                 BorderRadius.circular(
                              //                                                     20),
                              //                                             child:
                              //                                                 Center(
                              //                                               child: Image.asset(
                              //                                                   Assets
                              //                                                       .assetsGirlJean,
                              //                                                   height:
                              //                                                       170,
                              //                                                   width:
                              //                                                       300,
                              //                                                   fit:
                              //                                                       BoxFit.fill),
                              //                                             ),
                              //                                           ),
                              //                                           const SizedBox(
                              //                                             height:
                              //                                                 10,
                              //                                           ),
                              //                                           Row(
                              //                                             mainAxisAlignment:
                              //                                                 MainAxisAlignment
                              //                                                     .spaceBetween,
                              //                                             children: [
                              //                                               const AppText(
                              //                                                 text:
                              //                                                     "\$200.00",
                              //                                                 textSize:
                              //                                                     15,
                              //                                                 color:
                              //                                                     blackColor,
                              //                                                 fontWeight:
                              //                                                     FontWeight.w600,
                              //                                               ),
                              //                                               Icon(
                              //                                                 Icons
                              //                                                     .favorite,
                              //                                                 color: AppColor
                              //                                                     .blackColor
                              //                                                     .withOpacity(0.2),
                              //                                               )
                              //                                             ],
                              //                                           ),
                              //                                           const AppText(
                              //                                             text:
                              //                                                 "Dolce & Gabbana",
                              //                                             textSize:
                              //                                                 10,
                              //                                             color:
                              //                                                 blackColor,
                              //                                             fontWeight:
                              //                                                 FontWeight
                              //                                                     .w400,
                              //                                           ),
                              //                                           const SizedBox(
                              //                                             height: 8,
                              //                                           ),
                              //                                           const AppText(
                              //                                             text:
                              //                                                 "XL/42",
                              //                                             textSize:
                              //                                                 10,
                              //                                             color:
                              //                                                 blackColor,
                              //                                             fontWeight:
                              //                                                 FontWeight
                              //                                                     .w600,
                              //                                           ),
                              //                                         ],
                              //                                       )),
                              //                                   const Divider(
                              //                                     thickness: 1,
                              //                                   )
                              //                                 ],
                              //                               ),
                              //                             );
                              //                           },
                              //                         ),
                              //                       ),
                              //                     ],
                              //                   )
                              //                 : controller.touchTap.value == true
                              //                     ?
                              //                     // Stack(children: [
                              //                     //   GestureDetector(
                              //                     //     onTap: () {},
                              //                     //     child: SwipableStack(
                              //                     //       builder: (context, properties) {
                              //                     //         return Stack(
                              //                     //           clipBehavior: Clip.none,
                              //                     //           alignment: Alignment.bottomCenter,
                              //                     //           children: [
                              //                     //             Image.asset(Assets.assetsHomeBid),
                              //                     //             Positioned(
                              //                     //               bottom: -17,
                              //                     //               child: Row(
                              //                     //                 crossAxisAlignment:
                              //                     //                 CrossAxisAlignment.center,
                              //                     //                 mainAxisAlignment:
                              //                     //                 MainAxisAlignment.center,
                              //                     //                 children: [
                              //                     //                   Image.asset(
                              //                     //                     Assets.assetsDislike,
                              //                     //                     height: 50,
                              //                     //                     width: 50,
                              //                     //                   ),
                              //                     //                   const SizedBox(
                              //                     //                     width: 70,
                              //                     //                   ),
                              //                     //                   Obx(
                              //                     //                      ()=> GestureDetector(
                              //                     //                       onTap: (){
                              //                     //                         controller.heartColor.value = true;
                              //                     //                       },
                              //                     //                       child: Container(
                              //                     //                         padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                              //                     //                         decoration:  BoxDecoration(
                              //                     //                           color: controller.heartColor.value == true?
                              //                     //                           AppColor.prdtextColor:
                              //                     //                             AppColor.blackColor,
                              //                     //                           shape: BoxShape.circle
                              //                     //                         ),
                              //                     //                         child: const Center(
                              //                     //                           child: Icon(Icons.favorite,color: AppColor.white,size: 30,
                              //                     //                           )
                              //                     //                         ),
                              //                     //                       ),
                              //                     //                     ),
                              //                     //                   )
                              //                     //                 ],
                              //                     //               ),
                              //                     //             )
                              //                     //           ],
                              //                     //         );
                              //                     //       },
                              //                     //     ),
                              //                     //   ),
                              //                     //   Positioned(
                              //                     //     bottom: Get.height *.18,
                              //                     //     left: 20,
                              //                     //     child:
                              //                     //           Column(
                              //                     //         crossAxisAlignment:
                              //                     //         CrossAxisAlignment.start,
                              //                     //         children: [
                              //                     //           GestureDetector(
                              //                     //             onTap: (){
                              //                     //              // controller.sub.value = true;
                              //                     //              controller.menu.value = false;
                              //                     //              //  controller.touchTap.value = true;
                              //                     //              Get.toNamed(Routes.menshirtScreen);
                              //                     //              print("menShirt ${controller.menu.value}");
                              //                     //       },
                              //                     //             child:  const AppText(
                              //                     //               text: "Men Black Tshirt",
                              //                     //               textSize: 18,
                              //                     //               fontFamily: "Poppins",
                              //                     //               color: Colors.white,
                              //                     //               fontWeight: FontWeight.w400,
                              //                     //             ),
                              //                     //           ),
                              //                     //           const SizedBox(
                              //                     //             height: 10,
                              //                     //           ),
                              //                     //           const AppText(
                              //                     //             text: "\$4000.00",
                              //                     //             textSize: 18,
                              //                     //             color: Colors.white,
                              //                     //             fontFamily: "Poppins",
                              //                     //             fontWeight: FontWeight.w400,
                              //                     //           ),
                              //                     //           const SizedBox(
                              //                     //             height: 10,
                              //                     //           ),
                              //                     //           GestureDetector(
                              //                     //             onTap: () {
                              //                     //               timerDialog();
                              //                     //
                              //                     //                 },
                              //                     //             child: CommonButton(
                              //                     //               height: 40,
                              //                     //               radius: 15,
                              //                     //               color: AppColor.appcolor,
                              //                     //               text:
                              //                     //               "Bid \$2500",
                              //                     //               textStyle: const TextStyle(
                              //                     //                 fontSize: 15,
                              //                     //                 fontFamily: "Poppins",
                              //                     //                 color: Colors.white,
                              //                     //                 fontWeight: FontWeight.w400,
                              //                     //               ),
                              //                     //             ),
                              //                     //           ),
                              //                     //           const SizedBox(
                              //                     //             height: 10,
                              //                     //           ),
                              //                     //            const AppText(
                              //                     //             text: "min \$4000.00",
                              //                     //             textSize: 10,
                              //                     //             color: Colors.white,
                              //                     //             fontFamily: "Poppins",
                              //                     //             fontWeight: FontWeight.w400,
                              //                     //           ),
                              //                     //          const SizedBox(
                              //                     //             height: 10,
                              //                     //           ),
                              //                     //           GestureDetector(
                              //                     //             onTap: (){
                              //                     //               Get.toNamed(Routes.biddingScreen);
                              //                     //             },
                              //                     //             child: RichText(
                              //                     //                 text: const TextSpan(
                              //                     //                     text: "20 Bid",
                              //                     //                     style: TextStyle(
                              //                     //                       color: Colors.white,
                              //                     //                       fontSize: 10,
                              //                     //                       fontFamily: "Poppins",
                              //                     //                       fontWeight: FontWeight.w400,
                              //                     //                     ),
                              //                     //                     children: [
                              //                     //                       TextSpan(
                              //                     //                         text: "Show bid history",
                              //                     //                         style: TextStyle(
                              //                     //                             color: Colors.white,
                              //                     //                             fontSize: 10,
                              //                     //                             fontFamily: "Poppins",
                              //                     //                             fontWeight:
                              //                     //                             FontWeight.w400,
                              //                     //                             decoration: TextDecoration
                              //                     //                                 .underline),
                              //                     //                       )
                              //                     //                     ])),
                              //                     //           )
                              //                     //         ],
                              //                     //       ),
                              //                     //
                              //                     //   )
                              //                     // ])
                              //                     Container()
                              //                     : Container()),
                              //       )