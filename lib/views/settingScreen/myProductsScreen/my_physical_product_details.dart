import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oninto_flutter/common_controller/home/categories_controller.dart';
import 'package:oninto_flutter/common_controller/product/my_product_controller.dart';
import 'package:oninto_flutter/common_controller/product/sell_item_controller.dart';
import 'package:oninto_flutter/generated/assets.dart';
import 'package:oninto_flutter/service/local/user_info_global.dart';
import 'package:oninto_flutter/utils/app_text.dart';
import 'package:oninto_flutter/utils/app_type_status.dart';
import 'package:oninto_flutter/utils/date_time_formates.dart';
import 'package:oninto_flutter/utils/details_images_view.dart';
import 'package:oninto_flutter/utils/shimmer_widget.dart';

import '../../../model/product/product_details_model.dart';
import '../../../routes/routes.dart';
import '../../../utils/appbar.dart';
import '../../../utils/color_constant.dart';
import '../../../utils/common_button.dart';

class MyPysicalProductDetailScreen extends StatelessWidget {
  MyPysicalProductDetailScreen({super.key});
  final MyProductController _myProductController = Get.find();

  @override
  Widget build(BuildContext context) {
    double hzpadding = 20;
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: CommonAppbarWidget(
        headingChild: Obx(
          () => _myProductController.loadingData.value
              ? ShimmerWidgets.text(w: Get.width * 0.4)
              : Text(
                  _myProductController
                          .productDetailsData.value?.details?.name ??
                      '',
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 15),
                ),
        ),
        textStyle: const TextStyle(
            fontSize: 20,
            color: AppColor.blackColor,
            fontWeight: FontWeight.w500,
            fontFamily: "Poppins"),
      ),
      body: Obx(() => RefreshIndicator(
            onRefresh: () async {
              await _myProductController.getProductDetails(
                  (_myProductController.productDetailsData.value?.details?.id ??
                          '')
                      .toString());
            },
            child: _myProductController.loadingData.value
                ? ShimmerWidgets.product()
                : SingleChildScrollView(
                    physics: const ClampingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15.0, bottom: 30.0),
                      child: Column(
                        children: [
                          DetailsImagesView(
                              items: (_myProductController.productDetailsData
                                          .value?.details?.productImages ??
                                      [])
                                  .map((e) => ImgVideoData(
                                      type: e.video != null
                                          ? IVType.video
                                          : IVType.image,
                                      image: e.image,
                                      video: e.video,
                                      thumb: e.thumbnail))
                                  .toList()),
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: hzpadding,
                                    right: hzpadding,
                                    top: 15.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                AppText(
                                                  text: _myProductController
                                                          .productDetailsData
                                                          .value
                                                          ?.details
                                                          ?.name ??
                                                      '',
                                                  textSize: 15.0,
                                                  color: AppColor.blackColor,
                                                  style: AppTextStyle.medium,
                                                ),
                                                const SizedBox(height: 10),
                                                AppText(
                                                  text:
                                                      "\$${_myProductController.productDetailsData.value?.details?.price ?? '0.0'}",
                                                  textSize: 23.0,
                                                  color: AppColor.appColor,
                                                  style: AppTextStyle.title,
                                                ),
                                                const SizedBox(height: 8),
                                                AppText(
                                                  text:
                                                      "Inclusive of all taxes",
                                                  textSize: 10.0,
                                                  color: AppColor.blackColor
                                                      .withOpacity(0.3),
                                                  style: AppTextStyle.regular,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            _myProductController
                                                .getPrductReactions(
                                                    (_myProductController
                                                            .productDetailsData
                                                            .value
                                                            ?.details
                                                            ?.id)
                                                        .toString(),
                                                    productName:
                                                        _myProductController
                                                                .productDetailsData
                                                                .value
                                                                ?.details
                                                                ?.name ??
                                                            '');
                                            Get.toNamed(Routes
                                                .likeAndViewsOfProductScreen);
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Column(
                                                children: [
                                                  const Icon(
                                                    Icons.favorite,
                                                    color: AppColor.appColor,
                                                  ),
                                                  const SizedBox(height: 8),
                                                  AppText(
                                                    text:
                                                        "${_myProductController.productDetailsData.value?.favoriteCount ?? '0'}",
                                                    textSize: 15.0,
                                                    color: AppColor.blackColor
                                                        .withOpacity(0.3),
                                                    style: AppTextStyle.regular,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(width: 20),
                                              Column(
                                                children: [
                                                  const Icon(
                                                    Icons.visibility,
                                                    color: AppColor.appColor,
                                                  ),
                                                  const SizedBox(height: 8),
                                                  AppText(
                                                    text: (_myProductController
                                                                .productDetailsData
                                                                .value
                                                                ?.viewCount ??
                                                            0)
                                                        .toString(), // Product View Count
                                                    textSize: 15.0,
                                                    color: AppColor.blackColor
                                                        .withOpacity(0.3),
                                                    style: AppTextStyle.regular,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),

                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              myProduct(_myProductController
                                                          .productDetailsData
                                                          .value) ==
                                                      MyProduct.BUY
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 20),
                                                      child: commonText(
                                                          "Tracking ID: ",
                                                          "X_SJDFF0USF76887"),
                                                    )
                                                  : const SizedBox.shrink(),
                                              const SizedBox(height: 20),
                                              commonText(
                                                "Category",
                                                _myProductController
                                                        .productDetailsData
                                                        .value
                                                        ?.details
                                                        ?.category
                                                        ?.name ??
                                                    '',
                                              ),
                                              const SizedBox(height: 10),
                                              commonText(
                                                "Sub Category",
                                                _myProductController
                                                        .productDetailsData
                                                        .value
                                                        ?.details
                                                        ?.category
                                                        ?.subCategory
                                                        ?.name ??
                                                    '',
                                              ),
                                              const SizedBox(height: 10),
                                              commonText(
                                                  "Color",
                                                  _myProductController
                                                          .productDetailsData
                                                          .value
                                                          ?.details
                                                          ?.color ??
                                                      ''),
                                              const SizedBox(height: 10),
                                              commonText(
                                                  "Brand",
                                                  _myProductController
                                                          .productDetailsData
                                                          .value
                                                          ?.details
                                                          ?.brand ??
                                                      ''),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              AppText(
                                                text: _myProductController
                                                            .productDetailsData
                                                            .value
                                                            ?.details
                                                            ?.sellOption ==
                                                        ProductType.biding
                                                    ? "Auction"
                                                    : "Fix Price",
                                                underline: true,
                                                underlineColor:
                                                    AppColor.appColor,
                                                textSize: 14.0,
                                                color: AppColor.appColor,
                                                style: AppTextStyle.regular,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    //const SizedBox(height: 20,),
                                  ],
                                ),
                              ),
                              Divider(
                                color: AppColor.blackColor.withOpacity(0.1),
                                thickness: 2,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: hzpadding,
                                  right: hzpadding,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const AppText(
                                      text: "Condition",
                                      color: AppColor.appColor,
                                      textSize: 15,
                                      style: AppTextStyle.title,
                                    ),
                                    const SizedBox(height: 8),
                                    const AppText(
                                      text: "New with tags",
                                      color: AppColor.blackColor,
                                      textSize: 14,
                                      style: AppTextStyle.title,
                                    ),
                                    const SizedBox(height: 8),
                                    AppText(
                                      text:
                                          "A brand-new, unused item with tags attached or "
                                          "in the original packing.",
                                      color:
                                          AppColor.blackColor.withOpacity(0.3),
                                      textSize: 14,
                                      style: AppTextStyle.medium,
                                    )
                                  ],
                                ),
                              ),
                              Divider(
                                color: AppColor.blackColor.withOpacity(0.1),
                                thickness: 2,
                              ),
                              const SizedBox(height: 20),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: hzpadding, right: hzpadding),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    commonText(
                                      "Location :",
                                      _myProductController.productDetailsData
                                              .value?.details?.location ??
                                          '',
                                    ),
                                    const SizedBox(height: 10),
                                    commonText(
                                      "Posted Date",
                                      AppDateTime.getDateTime(
                                        _myProductController.productDetailsData
                                                .value?.details?.createdAt ??
                                            '',
                                        format: DateFormat("dd MMM yyyy"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(Assets.assetsSale),
                                  const SizedBox(height: 15),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: hzpadding, right: hzpadding),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const AppText(
                                          text: "Item Description",
                                          textSize: 14,
                                          fontFamily: "Poppins",
                                          color: AppColor.blackColor,
                                        ),
                                        const SizedBox(height: 8),
                                        AppText(
                                            text: _myProductController
                                                    .productDetailsData
                                                    .value
                                                    ?.details
                                                    ?.description ??
                                                '',
                                            textSize: 14,
                                            fontFamily: "Poppins",
                                            color: AppColor.blackColor
                                                .withOpacity(0.3)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              myProduct(_myProductController
                                          .productDetailsData.value) ==
                                      MyProduct.NEW
                                  ? Column(
                                      children: [
                                        const SizedBox(height: 31.0),
                                        GestureDetector(
                                          onTap: () {
                                            Get.toNamed(
                                              Routes.subscriptionScreen,
                                              // arguments: "plan"
                                            );
                                          },
                                          child: CommonButton(
                                            color: AppColor.textColor,
                                            height: 57,
                                            radius: 23,
                                            text: "Boost your post",
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 35),
                                            textStyle: TextStyle(
                                                color: AppColor.blackColor
                                                    .withOpacity(0.3),
                                                fontSize: 16),
                                          ),
                                        ),
                                        const SizedBox(height: 31.0),
                                        _myProductController.productDetailsData
                                                    .value?.details?.bidPrice !=
                                                null
                                            ? const SizedBox.shrink()
                                            : GestureDetector(
                                                onTap: () {
                                                  //Get.toNamed(Routes.editItemScreen);
                                                  if (CategoriesController()
                                                      .initialized) {
                                                    Get.find<
                                                            CategoriesController>()
                                                        .getCategories();
                                                  } else {
                                                    Get.put(CategoriesController())
                                                        .getCategories();
                                                  }
                                                  //
                                                  SellItemController sc;
                                                  if (SellItemController()
                                                      .initialized) {
                                                    sc = Get.find<
                                                        SellItemController>();
                                                  } else {
                                                    sc = Get.put(
                                                        SellItemController());
                                                  }
                                                  sc.tabController.value = 1;
                                                  sc.initialData(
                                                      _myProductController
                                                          .productDetailsData
                                                          .value
                                                          ?.details);

                                                  Get.toNamed(
                                                          Routes.sellItemScreen,
                                                          arguments: 'edit')!
                                                      .then((value) async {
                                                    await _myProductController
                                                        .getProductDetails(
                                                            (_myProductController
                                                                        .productDetailsData
                                                                        .value
                                                                        ?.details
                                                                        ?.id ??
                                                                    '')
                                                                .toString());
                                                  });
                                                },
                                                child: const CommonButton(
                                                  color: AppColor.appColor,
                                                  height: 57,
                                                  text: "Edit",
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 35),
                                                  textStyle: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16),
                                                ),
                                              ),
                                      ],
                                    )
                                  : _myProductController
                                              .productDetailsData
                                              .value
                                              ?.details
                                              ?.userTransactionInfo
                                              ?.paymentStatus ==
                                          "succeeded"
                                      ? Column(
                                          children: [
                                            Divider(
                                                color: AppColor.blackColor
                                                    .withOpacity(0.1),
                                                thickness: 2),
                                            const SizedBox(height: 8),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: hzpadding,
                                                  right: hzpadding),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const AppText(
                                                    text: "Payment Completed",
                                                    color: AppColor.green,
                                                    textSize: 15,
                                                    style: AppTextStyle.title,
                                                  ),
                                                  const SizedBox(height: 12),
                                                  commonText(
                                                    "Transaction ID: ",
                                                    _myProductController
                                                            .productDetailsData
                                                            .value
                                                            ?.details
                                                            ?.userTransactionInfo
                                                            ?.transactionId ??
                                                        '',
                                                  ),
                                                  const SizedBox(height: 8),
                                                  commonText(
                                                    "Time: ",
                                                    AppDateTime.getDateTime(
                                                        _myProductController
                                                            .productDetailsData
                                                            .value
                                                            ?.details
                                                            ?.userTransactionInfo
                                                            ?.createdAt,
                                                        format: DateFormat(
                                                            "HH:mm a, dd MMM yyyy")),
                                                  ),
                                                  const SizedBox(height: 18),
                                                  commonText(
                                                    "Price ",
                                                    '\$${(_myProductController.productDetailsData.value?.details?.userTransactionInfo?.amount ?? 0).toStringAsFixed(1)}',
                                                    spaceBetween: true,
                                                  ),
                                                  const SizedBox(height: 8),
                                                  commonText(
                                                    "Charge ",
                                                    '\$${(_myProductController.productDetailsData.value?.details?.userTransactionInfo?.chargedAmount ?? 0).toStringAsFixed(1)}',
                                                    spaceBetween: true,
                                                  ),
                                                  const SizedBox(height: 8),
                                                  commonText("Total Payment ",
                                                      '\$${((_myProductController.productDetailsData.value?.details?.userTransactionInfo?.chargedAmount ?? 0) + (_myProductController.productDetailsData.value?.details?.userTransactionInfo?.amount ?? 0)).toStringAsFixed(1)}',
                                                      spaceBetween: true,
                                                      bold: true,
                                                      highlight: true),
                                                  // User Info
                                                  myProduct(_myProductController
                                                              .productDetailsData
                                                              .value) ==
                                                          MyProduct.SELL
                                                      ? Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const SizedBox(
                                                                height: 14),
                                                            const AppText(
                                                              text: "User Info",
                                                              color: AppColor
                                                                  .themeColor,
                                                              textSize: 15,
                                                              style:
                                                                  AppTextStyle
                                                                      .title,
                                                            ),
                                                            const SizedBox(
                                                                height: 8),
                                                            commonText(
                                                              "Name: ",
                                                              "${_myProductController.productDetailsData.value?.details?.userTransactionInfo?.userInfo?.firstName ?? ''} ${_myProductController.productDetailsData.value?.details?.userTransactionInfo?.userInfo?.lastName ?? ''}",
                                                            ),
                                                            const SizedBox(
                                                                height: 8),
                                                            commonText(
                                                              "Phone: ",
                                                              "+${_myProductController.productDetailsData.value?.details?.userTransactionInfo?.userInfo?.countryCode ?? ''} ${_myProductController.productDetailsData.value?.details?.userTransactionInfo?.userInfo?.phone ?? ''}",
                                                            ),
                                                            const SizedBox(
                                                                height: 8),
                                                            commonText(
                                                              "Email: ",
                                                              _myProductController
                                                                      .productDetailsData
                                                                      .value
                                                                      ?.details
                                                                      ?.userTransactionInfo
                                                                      ?.userInfo
                                                                      ?.email ??
                                                                  '',
                                                            ),
                                                          ],
                                                        )
                                                      : const SizedBox.shrink()
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      : const SizedBox.shrink(),
                              //
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
          )),
    );
  }

  /// Product Category
  MyProduct myProduct(ProductDetailsData? product) {
    UserTransactionInfo? userTransactionInfo = _myProductController
        .productDetailsData.value?.details?.userTransactionInfo;
    if (userTransactionInfo == null) {
      return MyProduct.NEW;
    }
    if (userTransactionInfo.userId == UserStoredInfo().userInfo?.id) {
      return MyProduct.BUY;
    }
    return MyProduct.SELL;
  }

  /// Common Text View
  Widget commonText(String title, String value,
      {bool spaceBetween = false, bool bold = false, bool highlight = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: title,
          color: highlight ? AppColor.blackColor : AppColor.itemBorderColor,
          textSize: 14,
          style: AppTextStyle.medium,
          fontWeight: bold ? FontWeight.w600 : null,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Align(
            alignment:
                spaceBetween ? Alignment.centerRight : Alignment.centerLeft,
            child: AppText(
              text: value,
              color: AppColor.blackColor,
              textSize: highlight ? 16 : 12,
              style: AppTextStyle.medium,
              fontWeight: bold ? FontWeight.w600 : null,
            ),
          ),
        ),
      ],
    );
  }
}

enum MyProduct { BUY, SELL, NEW }
