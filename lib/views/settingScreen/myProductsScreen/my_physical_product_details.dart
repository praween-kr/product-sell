import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:oninto_flutter/common_controller/home/categories_controller.dart';
import 'package:oninto_flutter/common_controller/product/my_product_controller.dart';
import 'package:oninto_flutter/common_controller/product/sell_item_controller.dart';
import 'package:oninto_flutter/generated/assets.dart';
import 'package:oninto_flutter/model/settings/address_model.dart';
import 'package:oninto_flutter/service/local/user_info_global.dart';
import 'package:oninto_flutter/utils/app_print.dart';
import 'package:oninto_flutter/utils/app_text.dart';
import 'package:oninto_flutter/utils/app_type_status.dart';
import 'package:oninto_flutter/utils/date_time_formates.dart';
import 'package:oninto_flutter/utils/details_images_view.dart';
import 'package:oninto_flutter/utils/shimmer_widget.dart';

import '../../../model/auth/user_info_model.dart';
import '../../../model/product/product_details_model.dart';
import '../../../routes/routes.dart';
import '../../../utils/appbar.dart';
import '../../../utils/color_constant.dart';
import '../../../utils/common_button.dart';
import '../../../utils/google/pick_location_map.dart';

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
                                              const SizedBox(height: 10),
                                              _myProductController
                                                              .productDetailsData
                                                              .value
                                                              ?.details
                                                              ?.sellOption ==
                                                          ProductType
                                                              .fixedPrice ||
                                                      (_myProductController
                                                                  .productDetailsData
                                                                  .value
                                                                  ?.details
                                                                  ?.startDate ==
                                                              null ||
                                                          _myProductController
                                                                  .productDetailsData
                                                                  .value
                                                                  ?.details
                                                                  ?.bidTime ==
                                                              null)
                                                  ? const SizedBox.shrink()
                                                  : commonText(
                                                      "Bid Start Time",
                                                      AppDateTime.getDateTime(
                                                          "${_myProductController.productDetailsData.value?.details?.startDate ?? ''}T${_myProductController.productDetailsData.value?.details?.bidTime ?? ''}",
                                                          format: DateFormat(
                                                              "hh:mm a, dd MMM yyyy"))),
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
                              _myProductController.productDetailsData.value
                                              ?.details?.userTransactionInfo !=
                                          null &&
                                      _myProductController
                                              .productDetailsData
                                              .value
                                              ?.details
                                              ?.userTransactionInfo
                                              ?.userId ==
                                          UserStoredInfo().userInfo?.id
                                  ? buyProductPaymentStatus(
                                      _myProductController
                                          .productDetailsData.value,
                                      _myProductController
                                          .currentShippedProductStatus.value,
                                      updateShippingStatus:
                                          (int newSatatus) async {
                                      await _myProductController
                                          .shippingProductStatusUpdate(
                                        productId: (_myProductController
                                                    .productDetailsData
                                                    .value
                                                    ?.details
                                                    ?.id ??
                                                '')
                                            .toString(),
                                        transactionId: (_myProductController
                                                    .productDetailsData
                                                    .value
                                                    ?.details
                                                    ?.userTransactionInfo
                                                    ?.id ??
                                                '')
                                            .toString(),
                                        shippedStatus: newSatatus,
                                      );
                                    })
                                  : const SizedBox.shrink(),
                              const SizedBox(height: 8),
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
                                                onTap: updateProduct,
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
                                  : myProduct(_myProductController
                                              .productDetailsData.value) ==
                                          MyProduct.SELL
                                      ? soldProductPaymentStatus(
                                          _myProductController
                                              .productDetailsData.value,
                                          _myProductController
                                              .currentShippedProductStatus
                                              .value,
                                          updateShippingStatus:
                                              (int newSatatus) async {
                                          await _myProductController
                                              .shippingProductStatusUpdate(
                                            productId: (_myProductController
                                                        .productDetailsData
                                                        .value
                                                        ?.details
                                                        ?.id ??
                                                    '')
                                                .toString(),
                                            transactionId: (_myProductController
                                                        .productDetailsData
                                                        .value
                                                        ?.details
                                                        ?.userTransactionInfo
                                                        ?.id ??
                                                    '')
                                                .toString(),
                                            shippedStatus: newSatatus,
                                          );
                                        })
                                      : const SizedBox.shrink(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
          )),
    );
  }

  void updateProduct() {
    //Get.toNamed(Routes.editItemScreen);
    if (CategoriesController().initialized) {
      Get.find<CategoriesController>().getCategories();
    } else {
      Get.put(CategoriesController()).getCategories();
    }
    //
    SellItemController sc;
    if (SellItemController().initialized) {
      sc = Get.find<SellItemController>();
    } else {
      sc = Get.put(SellItemController());
    }
    sc.tabController.value = 1;
    sc.initialData(_myProductController.productDetailsData.value?.details);
    Get.toNamed(Routes.sellItemScreen, arguments: 'edit')!.then((value) async {
      await _myProductController.getProductDetails(
          (_myProductController.productDetailsData.value?.details?.id ?? '')
              .toString());
    });
  }

  Widget buyProductPaymentStatus(ProductDetailsData? data, int? shippingStatus,
      {required Function(int) updateShippingStatus}) {
    AppPrint.all("shippingStatus---> $shippingStatus");
    double hzpadding = 20;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(color: AppColor.blackColor.withOpacity(0.1), thickness: 2),
        const SizedBox(height: 8),
        Padding(
          padding: EdgeInsets.only(left: hzpadding, right: hzpadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppText(
                    text: "Shipping Status",
                    color: AppColor.orange,
                    textSize: 15,
                    style: AppTextStyle.title,
                  ),
                  const SizedBox(height: 12),
                  AppText(
                    text: shippingStatus == ProductShippingStatus.receiveByBuyer
                        ? "Product has successfully delivered"
                        : "Product will be delivered",
                    textSize: 12,
                    color: AppColor.grey,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColor.appColor, width: 0.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              shippingStatus ==
                                      ProductShippingStatus.receiveByBuyer
                                  ? const SizedBox.shrink()
                                  : AppText(
                                      text: shippingStatus ==
                                              ProductShippingStatus
                                                  .shippedFromSeller
                                          ? "Product shipped-\nAfter receiving your product please update"
                                          : "Not shipped yet- ",
                                      textSize: 12,
                                      color: AppColor.grey,
                                    ),
                              const SizedBox(height: 5),
                              Wrap(
                                children: [
                                  const AppText(
                                    text: "Status- ",
                                    textSize: 12,
                                    color: AppColor.grey,
                                  ),
                                  AppText(
                                    text: shippingStatus ==
                                            ProductShippingStatus
                                                .shippedFromSeller
                                        ? "Pending"
                                        : shippingStatus ==
                                                ProductShippingStatus
                                                    .receiveByBuyer
                                            ? "Received"
                                            : "Not shipped yet",
                                    textSize: 12,
                                    color: shippingStatus ==
                                            ProductShippingStatus
                                                .shippedFromSeller
                                        ? AppColor.blue
                                        : shippingStatus ==
                                                ProductShippingStatus
                                                    .receiveByBuyer
                                            ? AppColor.green
                                            : AppColor.red,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        shippingStatus == ProductShippingStatus.pending ||
                                shippingStatus ==
                                    ProductShippingStatus.receiveByBuyer
                            ? const SizedBox.shrink()
                            : TextButton(
                                onPressed: () => updateShippingStatus(
                                    shippingStatus ==
                                            ProductShippingStatus
                                                .shippedFromSeller
                                        ? ProductShippingStatus.receiveByBuyer
                                        : ProductShippingStatus
                                            .shippedFromSeller),
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 0),
                                  backgroundColor:
                                      AppColor.orange.withOpacity(0.1),
                                ),
                                child: Text(
                                  "Received",
                                  style: TextStyle(
                                    color: shippingStatus ==
                                            ProductShippingStatus.receiveByBuyer
                                        ? AppColor.grey
                                        : AppColor.orange,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                  shippingAddress(
                      data?.details?.userTransactionInfo?.shippingAddress),
                  // User Info
                  myProduct(data) == MyProduct.SELL
                      ? buyerInfo(data?.details?.userTransactionInfo?.userInfo)
                      : const SizedBox.shrink()
                ],
              ),
              //
              // shippingStatus == ProductShippingStatus.shippedFromSeller
              //     ? const Text("Shipped from me")
              //     : const SizedBox.shrink(),
              const Divider(),
              const SizedBox(height: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppText(
                    text: "Paied Successfullly",
                    color: AppColor.green,
                    textSize: 15,
                    style: AppTextStyle.title,
                  ),
                  const SizedBox(height: 12),
                  commonText(
                    "Transaction ID: ",
                    data?.details?.userTransactionInfo?.transactionId ?? '',
                  ),
                  const SizedBox(height: 8),
                  commonText(
                    "Time: ",
                    AppDateTime.getDateTime(
                        data?.details?.userTransactionInfo?.createdAt,
                        format: DateFormat("HH:mm a, dd MMM yyyy")),
                  ),
                  const SizedBox(height: 8),
                  commonText(
                    "Price ",
                    '\$${(data?.details?.userTransactionInfo?.amount ?? 0).toStringAsFixed(1)}',
                    spaceBetween: true,
                  ),
                  const SizedBox(height: 8),
                  commonText(
                    "Charge ",
                    '\$${(data?.details?.userTransactionInfo?.chargedAmount ?? 0).toStringAsFixed(1)}',
                    spaceBetween: true,
                  ),
                  const SizedBox(height: 8),
                  commonText("Total Payment ",
                      '\$${((data?.details?.userTransactionInfo?.chargedAmount ?? 0) + (data?.details?.userTransactionInfo?.amount ?? 0)).toStringAsFixed(1)}',
                      spaceBetween: true, bold: true, highlight: true),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget soldProductPaymentStatus(ProductDetailsData? data, int? shippingStatus,
      {required Function(int) updateShippingStatus}) {
    AppPrint.all("shippingStatus---> $shippingStatus");
    double hzpadding = 20;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(color: AppColor.blackColor.withOpacity(0.1), thickness: 2),
        const SizedBox(height: 8),
        Padding(
          padding: EdgeInsets.only(left: hzpadding, right: hzpadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppText(
                    text: "Shipping Status",
                    color: AppColor.orange,
                    textSize: 15,
                    style: AppTextStyle.title,
                  ),
                  const SizedBox(height: 12),
                  const AppText(
                    text:
                        "Your product have sold, you will be receive payment after shipped to buyer",
                    textSize: 12,
                    color: AppColor.grey,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColor.appColor, width: 0.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                text: shippingStatus ==
                                        ProductShippingStatus.receiveByBuyer
                                    ? "Your product has delivered on location"
                                    : shippingStatus ==
                                            ProductShippingStatus
                                                .shippedFromSeller
                                        ? "Product shipped-\nReceiver will be update soon"
                                        : "Update status- Shipped",
                                textSize: 12,
                                color: AppColor.grey,
                              ),
                              const SizedBox(height: 5),
                              Wrap(
                                children: [
                                  const AppText(
                                    text: "Status- ",
                                    textSize: 12,
                                    color: AppColor.grey,
                                  ),
                                  AppText(
                                    text: shippingStatus ==
                                            ProductShippingStatus
                                                .shippedFromSeller
                                        ? "Pending"
                                        : shippingStatus ==
                                                ProductShippingStatus
                                                    .receiveByBuyer
                                            ? "Delivered"
                                            : "Not shipped yet",
                                    textSize: 13,
                                    color: shippingStatus ==
                                            ProductShippingStatus
                                                .shippedFromSeller
                                        ? AppColor.blue
                                        : shippingStatus ==
                                                ProductShippingStatus
                                                    .receiveByBuyer
                                            ? AppColor.green
                                            : AppColor.red,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        shippingStatus == ProductShippingStatus.receiveByBuyer
                            ? const SizedBox(height: 45)
                            : TextButton(
                                onPressed: () => updateShippingStatus(
                                    shippingStatus ==
                                            ProductShippingStatus
                                                .shippedFromSeller
                                        ? ProductShippingStatus.pending
                                        : ProductShippingStatus
                                            .shippedFromSeller),
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 0),
                                  backgroundColor:
                                      AppColor.orange.withOpacity(0.1),
                                ),
                                child: Text(
                                  shippingStatus ==
                                          ProductShippingStatus
                                              .shippedFromSeller
                                      ? "Cancel"
                                      : "Shipped",
                                  style: TextStyle(
                                    color: shippingStatus ==
                                            ProductShippingStatus
                                                .shippedFromSeller
                                        ? AppColor.red
                                        : AppColor.orange,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                  shippingAddress(
                      data?.details?.userTransactionInfo?.shippingAddress),
                  // User Info
                  myProduct(data) == MyProduct.SELL
                      ? buyerInfo(data?.details?.userTransactionInfo?.userInfo)
                      : const SizedBox.shrink()
                ],
              ),
              shippingStatus == ProductShippingStatus.receiveByBuyer
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 14),
                        const AppText(
                          text: "Payment Completed",
                          color: AppColor.green,
                          textSize: 15,
                          style: AppTextStyle.title,
                        ),
                        const SizedBox(height: 12),
                        commonText(
                          "Transaction ID: ",
                          data?.details?.userTransactionInfo?.transactionId ??
                              '',
                        ),
                        const SizedBox(height: 8),
                        commonText(
                          "Time: ",
                          AppDateTime.getDateTime(
                              data?.details?.userTransactionInfo?.createdAt,
                              format: DateFormat("HH:mm a, dd MMM yyyy")),
                        ),
                        const SizedBox(height: 8),
                        commonText(
                          "Price ",
                          '\$${(data?.details?.userTransactionInfo?.amount ?? 0).toStringAsFixed(1)}',
                          spaceBetween: true,
                        ),
                        const SizedBox(height: 8),
                        commonText(
                          "Charge ",
                          '\$${(data?.details?.userTransactionInfo?.chargedAmount ?? 0).toStringAsFixed(1)}',
                          spaceBetween: true,
                        ),
                        const SizedBox(height: 8),
                        commonText("Total Payment ",
                            '\$${((data?.details?.userTransactionInfo?.chargedAmount ?? 0) + (data?.details?.userTransactionInfo?.amount ?? 0)).toStringAsFixed(1)}',
                            spaceBetween: true, bold: true, highlight: true),
                      ],
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ],
    );
  }

  Widget buyerInfo(UserBasicInfo? userInfo) {
    return userInfo == null
        ? const SizedBox.shrink()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 14),
              const AppText(
                text: "User Info",
                color: AppColor.themeColor,
                textSize: 12,
                style: AppTextStyle.title,
              ),
              const SizedBox(height: 8),
              commonText(
                "Name: ",
                "${userInfo.firstName ?? ''} ${userInfo.lastName ?? ''}",
              ),
              const SizedBox(height: 8),
              commonText(
                "Phone: ",
                "+${userInfo.countryCode ?? ''} ${userInfo.phone ?? ''}",
              ),
              const SizedBox(height: 8),
              commonText(
                "Email: ",
                userInfo.email ?? '',
              ),
            ],
          );
  }

  Widget shippingAddress(AddressModel? address) {
    return address == null
        ? const SizedBox.shrink()
        : Column(
            children: [
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AppText(
                          text: "Shipping Address",
                          style: AppTextStyle.title,
                          textSize: 13.0,
                          color: AppColor.blackColor,
                        ),
                        const SizedBox(height: 5.0),
                        AppText(
                          text: address.location ?? '',
                          style: AppTextStyle.medium,
                          textSize: 13.0,
                          color: AppColor.blackColor.withOpacity(0.3),
                        ),
                        const SizedBox(height: 5.0),
                        AppText(
                          text: address.street ?? '',
                          style: AppTextStyle.medium,
                          textSize: 11.0,
                          color: AppColor.blackColor.withOpacity(0.3),
                        ),
                        const SizedBox(height: 5.0),
                        AppText(
                          text: address.landMark ?? '',
                          style: AppTextStyle.medium,
                          textSize: 11.0,
                          color: AppColor.blackColor.withOpacity(0.3),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(
                        () => PickLocationMap(
                          viewOnly: true,
                          cordinates: LatLng(
                              double.parse(address.latitude ?? "0.0"),
                              double.parse(address.longitude ?? "0.0")),
                          onChanged: (location) {},
                        ),
                      );
                    },
                    child: Image.asset(Assets.assetsLocationImage,
                        height: 61.0, width: 61.0),
                  ),
                ],
              ),
            ],
          );
  }

  /// Product Category
  MyProduct myProduct(ProductDetailsData? product) {
    UserTransactionInfo? userTransactionInfo = _myProductController
        .productDetailsData.value?.details?.userTransactionInfo;
    if (userTransactionInfo == null) {
      AppPrint.info("Product Type: ${MyProduct.NEW}");
      return MyProduct.NEW;
    }
    if (userTransactionInfo.userId == UserStoredInfo().userInfo?.id) {
      AppPrint.info("Product Type: ${MyProduct.BUY}");
      return MyProduct.BUY;
    }
    AppPrint.info("Product Type: ${MyProduct.SELL}");
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
