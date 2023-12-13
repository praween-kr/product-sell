import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oninto_flutter/common_controller/favourites_controller.dart';
import 'package:oninto_flutter/common_controller/home/home_controller.dart';
import 'package:oninto_flutter/common_widget/appbar.dart';
import 'package:oninto_flutter/common_widget/common_button.dart';
import 'package:oninto_flutter/common_widget/details_images_view.dart';
import 'package:oninto_flutter/generated/assets.dart';
import 'package:oninto_flutter/routes/routes.dart';
import 'package:oninto_flutter/utils/common_appbar.dart';
import 'package:oninto_flutter/utils/date_time_formates.dart';
import 'package:oninto_flutter/utils/favourite_button.dart';
import 'package:oninto_flutter/utils/shimmer_widget.dart';
import 'package:oninto_flutter/utils/widgets/dialogs.dart';

import '../../../common_widget/color_constant.dart';
import '../../../utils/colors_file.dart';

class BidingProductDetailsScreen extends StatelessWidget {
  BidingProductDetailsScreen({super.key}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.menu.value) {
        AppDialogs.bidHistoryDialog(
          confirm: () => Get.toNamed(Routes.bidingProductDetatils),
          seeAll: () => Get.toNamed(Routes.biddingScreen),
        );
      } else {
        return;
      }
    });
  }
  final HomeCatProductcontroller controller = Get.find();
  final FavouritesController _favouritesController = Get.find();

  @override
  Widget build(BuildContext context) {
    print("dddd: ${_favouritesController.productDetailsData}");
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CommonAppbarWidget(
          leading: GestureDetector(
            onTap: () {
              controller.menu.value = true;
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
          headingChild: Obx(
            () => _favouritesController.loadingData.value
                ? ShimmerWidgets.text(w: Get.width * 0.4)
                : Text(
                    _favouritesController
                            .productDetailsData.value?.details?.name ??
                        '',
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 15),
                  ),
          ),
          textStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontSize: 18,
              fontFamily: "Poppins"),
          action: Obx(() => _favouritesController.loadingData.value
              ? ShimmerWidgets.favourite(s: 30)
              : FavouriteButton(
                  onClick: () {
                    _favouritesController.addProductAsFavourite(
                        (_favouritesController
                                    .productDetailsData.value?.details?.id ??
                                '')
                            .toString(),
                        -1,
                        typeRemove: false);
                  },
                  isFavourite: _favouritesController.localFavourites.value != ''
                      ? _favouritesController.localFavourites.value ==
                          (_favouritesController
                                      .productDetailsData.value?.details?.id ??
                                  '')
                              .toString()
                      : _favouritesController
                              .productDetailsData.value?.details?.isFavourite ==
                          1)),
        ),
        body: Obx(
          () => RefreshIndicator(
            onRefresh: () async {
              await _favouritesController.getProductDetails(
                  (_favouritesController
                              .productDetailsData.value?.details?.id ??
                          '')
                      .toString());
            },
            child: _favouritesController.loadingData.value
                ? ShimmerWidgets.product()
                : SingleChildScrollView(
                    physics: const ClampingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DetailsImagesView(
                              images: (_favouritesController.productDetailsData
                                          .value?.details?.productImages ??
                                      [])
                                  .map((e) => e.image ?? '')
                                  .toList()),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: AppText(
                                        text: _favouritesController
                                                .productDetailsData
                                                .value
                                                ?.details
                                                ?.name ??
                                            '',
                                        textSize: 15,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w500,
                                      ),
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
                                              borderRadius:
                                                  BorderRadius.circular(20)),
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
                                    SizedBox(width: 5),
                                    AppText(
                                      text: "/4.5",
                                      textSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0x4d000000),
                                      fontFamily: "Poppins",
                                    )
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 5),
                                        child: AppText(
                                          text: "Current Bid :",
                                          textSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff9F9F9F),
                                          fontFamily: "Poppins",
                                        ),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        AppText(
                                          text:
                                              "\$${_favouritesController.productDetailsData.value?.details?.price ?? '0.0'}",
                                          textSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                          fontFamily: "Poppins",
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        AppText(
                                          text:
                                              "Min \$${_favouritesController.productDetailsData.value?.details?.minimumSellingPrice ?? "0.0"}",
                                          textSize: 10,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xff000000),
                                          fontFamily: "Poppins",
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Get.toNamed(Routes.biddingScreen);
                                          },
                                          child: RichText(
                                              text: const TextSpan(
                                                  text: "20 Bid ",
                                                  style: TextStyle(
                                                      fontSize: 8,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontFamily: "Poppins"),
                                                  children: [
                                                TextSpan(
                                                    text: "Show bid history",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontFamily: "Poppins",
                                                        fontSize: 8,
                                                        color: Colors.black,
                                                        decoration:
                                                            TextDecoration
                                                                .underline))
                                              ])),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(top: 5),
                                      child: AppText(
                                        text: "End  Bid :",
                                        textSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff9F9F9F),
                                        fontFamily: "Poppins",
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
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
                                        const SizedBox(height: 5),
                                        RichText(
                                            text: const TextSpan(
                                                text:
                                                    "Extended Bidding Interval ",
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
                          Divider(
                              color: const Color(0x66000000).withOpacity(0.1)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const AppText(
                                      text: "Category : ",
                                      textSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff9F9F9F),
                                      fontFamily: "Poppins",
                                    ),
                                    AppText(
                                        text: _favouritesController
                                                .productDetailsData
                                                .value
                                                ?.details
                                                ?.category
                                                ?.name ??
                                            '',
                                        textSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: blackColor),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    const AppText(
                                        text: "Sub Category : ",
                                        textSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff9F9F9F),
                                        fontFamily: "Poppins"),
                                    AppText(
                                        text: _favouritesController
                                                .productDetailsData
                                                .value
                                                ?.details
                                                ?.category
                                                ?.subCategory
                                                ?.name ??
                                            '',
                                        textSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: blackColor),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    const AppText(
                                      text: "Color :  ",
                                      textSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff9F9F9F),
                                      fontFamily: "Poppins",
                                    ),
                                    AppText(
                                      text: _favouritesController
                                              .productDetailsData
                                              .value
                                              ?.details
                                              ?.color ??
                                          '',
                                      textSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: blackColor,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    const AppText(
                                      text: "Brand : ",
                                      textSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff9F9F9F),
                                      fontFamily: "Poppins",
                                    ),
                                    AppText(
                                        text: _favouritesController
                                                .productDetailsData
                                                .value
                                                ?.details
                                                ?.brand ??
                                            '',
                                        textSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: blackColor),
                                  ],
                                ),
                                const SizedBox(height: 5),
                              ],
                            ),
                          ),
                          Divider(
                              color: const Color(0x66000000).withOpacity(0.1),
                              thickness: 1),
                          const Padding(
                            padding: EdgeInsets.only(top: 15, left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                    text: "Condition",
                                    textSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.appcolor),
                                SizedBox(height: 5),
                                AppText(
                                  text: "New with tags",
                                  textSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: blackColor,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                AppText(
                                  text:
                                      "A brand-new, unused item with tags attached\nor "
                                      "in the original packing.",
                                  textSize: 12,
                                  fontWeight: FontWeight.w500,
                                  lineHeight: 1.3,
                                  color: Color(0x4d000000),
                                  fontFamily: "Poppins",
                                ),
                              ],
                            ),
                          ),
                          const Divider(color: Color(0x66000000), thickness: 1),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 15,
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                  ),
                                  child: Column(
                                    children: [
                                      const Row(
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
                                      const SizedBox(height: 10),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const AppText(
                                              text: "Location  :",
                                              textSize: 12,
                                              color: Color(0x4d000000),
                                              fontWeight: FontWeight.w400),
                                          Expanded(
                                            child: AppText(
                                                text: _favouritesController
                                                        .productDetailsData
                                                        .value
                                                        ?.details
                                                        ?.location ??
                                                    '',
                                                textSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: blackColor,
                                                fontFamily: "Poppins"),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          const AppText(
                                              text: "Posted Date :",
                                              textSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0x4d000000)),
                                          AppText(
                                            text: AppDateTime.getDateTime(
                                                _favouritesController
                                                        .productDetailsData
                                                        .value
                                                        ?.details
                                                        ?.createdAt ??
                                                    '',
                                                format:
                                                    DateFormat("dd MMM yyyy")),
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
                                const SizedBox(height: 15),
                                Image.asset(Assets.assetsSale),
                                const SizedBox(height: 5),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20, left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const AppText(
                                  text: "Item Description",
                                  textSize: 13,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Poppins",
                                ),
                                const SizedBox(height: 5),
                                AppText(
                                    text: _favouritesController
                                            .productDetailsData
                                            .value
                                            ?.details
                                            ?.description ??
                                        '',
                                    textSize: 12,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Poppins",
                                    color:
                                        AppColor.blackColor.withOpacity(0.3)),
                                const SizedBox(height: 10),
                                // AppText(
                                //   text: "Quick Bid :",
                                //   textSize: 12,
                                //   fontWeight: FontWeight.w500,
                                //   color: Color(0xff9F9F9F),
                                // )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              AppDialogs.bidHistoryDialog(
                                confirm: () =>
                                    Get.toNamed(Routes.bidingProductDetatils),
                                seeAll: () => Get.toNamed(Routes.biddingScreen),
                              );
                            },
                            child: Obx(
                              () => controller.sub.value
                                  ? CommonButton(
                                      height: 57,
                                      radius: 20,
                                      margin: const EdgeInsets.only(
                                          left: 30, right: 30, top: 20),
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
                                          horizontal: 35, vertical: 15),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                          ),
                          const SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
