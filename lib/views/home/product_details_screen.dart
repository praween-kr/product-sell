import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:intl/intl.dart';
import 'package:oninto_flutter/Socket/controller/chat_msg_controller.dart';
import 'package:oninto_flutter/Socket/model/chat_product_user_model.dart';
import 'package:oninto_flutter/common_controller/home/home_controller.dart';
import 'package:oninto_flutter/common_controller/product/biding_.dart';
import 'package:oninto_flutter/common_controller/settings/address_controller.dart';
import 'package:oninto_flutter/generated/assets.dart';
import 'package:oninto_flutter/model/product/product_details_model.dart';
import 'package:oninto_flutter/routes/routes.dart';
import 'package:oninto_flutter/service/local/user_info_global.dart';
import 'package:oninto_flutter/utils/app_print.dart';
import 'package:oninto_flutter/utils/app_text.dart';
import 'package:oninto_flutter/utils/app_timer.dart';
import 'package:oninto_flutter/utils/app_toast_loader.dart';
import 'package:oninto_flutter/utils/app_type_status.dart';
import 'package:oninto_flutter/utils/appbar.dart';
import 'package:oninto_flutter/utils/common_button.dart';
import 'package:oninto_flutter/utils/date_time_formates.dart';
import 'package:oninto_flutter/utils/details_images_view.dart';
import 'package:oninto_flutter/utils/empty_widget.dart';
import 'package:oninto_flutter/utils/helper/stripe_services.dart';
import 'package:oninto_flutter/utils/shimmer_widget.dart';
import 'package:oninto_flutter/utils/widgets/dialogs.dart';
import 'package:oninto_flutter/views/settingScreen/addressScreen/address_screen.dart';

import '../../utils/color_constant.dart';

/// Fixed price product
/// Biding product
///  - start date and end date
///  - first bid and last bid
///  - bid over ->
///  - bid over but no bid -> d
///  - last bid user- win -> d
///  - bided user- fail -> d
class ProductDetailsScreen extends StatelessWidget {
  ProductDetailsScreen({super.key});
  final HomeCatProductController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppbarWidget(
        onBackPress: () {
          Get.back();
        },
        headingChild: Obx(
          () => controller.loadingData.value
              ? ShimmerWidgets.text(w: Get.width * 0.4)
              : Text(
                  controller.productDetailsData.value?.details?.name ?? '',
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 15),
                ),
        ),
      ),
      body: Obx(
        () => Column(
          children: [
            // controller.productDetailsData.value?.details?.a
            controller.productType.value == ProductType.fixedPrice ||
                    controller.bidingData.value?.save?.bidOver == 1 ||
                    controller.productDetailsData.value == null
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: AppText(
                              text: controller.bidingTimerStatus.value ==
                                      TimerTypeStatus.GOINGON_NO_BID_YET
                                  ? "Biding started"
                                  : "Bid ${controller.bidingTimerStatus.value == TimerTypeStatus.UPCOMING ? 'Start' : 'Ending'} Soon:",
                              textSize: 13,
                              fontFamily: "Poppins"),
                        ),
                        Obx(
                          () => AppTimer(
                            productId: (controller.productDetailsData.value
                                        ?.details?.id ??
                                    '')
                                .toString(),
                            textType: true,
                            bidNow: () {},
                            endTime: controller
                                .bidingEndAfter.value, //"2023-12-20 18:37:00"
                            textSize: 14,
                            firstBid: (controller.bidingData.value?.history ??
                                        [])
                                    .isEmpty
                                ? null
                                : DateTime.parse(
                                        (controller.bidingData.value?.history ??
                                                [])
                                            .first
                                            .createdAt!)
                                    .toLocal(),
                            onChanged: (TimerType data) {
                              controller.bidingTimerStatus.value = data.status;
                              print("Timer Start to --> - ${data.value}");
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
            const SizedBox(height: 10),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  controller.getBidHistories(
                      productId:
                          (controller.productDetailsData.value?.details?.id ??
                                  '')
                              .toString());
                  await controller.getProductDetails(
                      (controller.productDetailsData.value?.details?.id ?? '')
                          .toString());
                },
                child: controller.loadingData.value
                    ? ShimmerWidgets.product()
                    : controller.productDetailsData.value == null
                        ? EmptyWidgets.simple()
                        : SingleChildScrollView(
                            physics: const ClampingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DetailsImagesView(
                                    images: (controller.productDetailsData.value
                                                ?.details?.productImages ??
                                            [])
                                        .map((e) => e.image ?? '')
                                        .toList()),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, left: 20, right: 20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          AppText(
                                            text: controller.productDetailsData
                                                    .value?.details?.name ??
                                                '',
                                            textSize: 17,
                                            fontWeight: FontWeight.w400,
                                            color: AppColor.blackColor,
                                          ),
                                          // AppText(
                                          //   text: controller.productDetailsData.value
                                          //           ?.details?.name ??
                                          //       '',
                                          //   textSize: 17,
                                          //   fontWeight: FontWeight.w400,
                                          //   color: AppColor.appcolor,
                                          // ),
                                          GestureDetector(
                                            onTap: _sendMessage,
                                            child: Container(
                                                height: 40,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                    color: AppColor.appColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: const Icon(
                                                  Icons.message,
                                                  color: Colors.white,
                                                )),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      controller.productType.value ==
                                              ProductType.fixedPrice
                                          ? _fixedInfo()
                                          : _bidInfo()
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 5),
                                const Divider(color: Color(0x66000000)),
                                const Padding(
                                  padding: EdgeInsets.only(top: 20, left: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppText(
                                        text: "Condition",
                                        textSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: AppColor.appColor,
                                      ),
                                      SizedBox(height: 5),
                                      AppText(
                                        text: "New with tags",
                                        textSize: 13,
                                        fontWeight: FontWeight.w400,
                                        color: AppColor.blackColor,
                                      ),
                                      SizedBox(height: 5),
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
                                const Divider(color: Color(0x66000000)),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
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
                                                  color: AppColor.blackColor,
                                                  fontFamily: "Poppins",
                                                )
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const AppText(
                                                    text: "Location  :",
                                                    textSize: 12,
                                                    color: Color(0x4d000000),
                                                    fontWeight:
                                                        FontWeight.w400),
                                                Expanded(
                                                  child: AppText(
                                                      text: controller
                                                              .productDetailsData
                                                              .value
                                                              ?.details
                                                              ?.location ??
                                                          '',
                                                      textSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color:
                                                          AppColor.blackColor,
                                                      fontFamily: "Poppins"),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                const AppText(
                                                  text: "Posted Date :",
                                                  textSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0x4d000000),
                                                ),
                                                AppText(
                                                  text: AppDateTime.getDateTime(
                                                      controller
                                                              .productDetailsData
                                                              .value
                                                              ?.details
                                                              ?.createdAt ??
                                                          '',
                                                      format: DateFormat(
                                                          "dd MMM yyyy")),
                                                  textSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: "Poppins",
                                                  color: AppColor.blackColor,
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Image.asset(Assets.assetsSale),
                                      const SizedBox(height: 5),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 20, left: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const AppText(
                                          text: "Item Description",
                                          textSize: 13,
                                          fontFamily: "Poppins"),
                                      const SizedBox(height: 5),
                                      AppText(
                                          text: controller
                                                  .productDetailsData
                                                  .value
                                                  ?.details
                                                  ?.description ??
                                              '',
                                          textSize: 13,
                                          fontFamily: "Poppins",
                                          color: const Color(0x4d000000)),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 30),
                                GestureDetector(
                                  onTap: () async {
                                    if (controller.bidingActionActive() == 0) {
                                      AppToast.show(
                                          "Biding will be start soon");
                                    } else if (controller
                                            .bidingActionActive() ==
                                        1) {
                                      // Can bid on continue
                                      if (controller.productType.value ==
                                          ProductType.biding) {
                                        _onBid(controller
                                            .productDetailsData.value?.details);
                                      }
                                    } else if (controller.myBidProduct() == 0) {
                                      // Fixed Price - Buy
                                      double totalPrice = double.parse(
                                          (controller.productDetailsData.value
                                                      ?.details?.price ??
                                                  0.0)
                                              .toString());
                                      String productId = (controller
                                                  .productDetailsData
                                                  .value
                                                  ?.details
                                                  ?.id ??
                                              '')
                                          .toString();
                                      await _buyFixedPriceProduct(
                                        productId: productId,
                                        amount: totalPrice,
                                      );
                                    } else if (controller.myBidProduct() == 1) {
                                      // Biding Product - my last bid on product - Buy
                                      double totalPrice = double.parse(
                                          (controller.productDetailsData.value
                                                      ?.details?.price ??
                                                  0.0)
                                              .toString());
                                      String productId = (controller
                                                  .productDetailsData
                                                  .value
                                                  ?.details
                                                  ?.id ??
                                              '')
                                          .toString();

                                      await _buyBidProduct(
                                          productId: productId,
                                          amount: totalPrice);
                                    }

                                    // Map<String, dynamic> data = {
                                    //   "data": "from",
                                    // };
                                    // controller.trackupload.value
                                    //     ? uploadDialog()
                                    //     : controller.upload.value
                                    //         ? givereviewDialog()
                                    //         : Get.arguments?["from"] == 1 &&
                                    //                 !controller.upload.value
                                    //             ? trackingDialog()
                                    //             : Get.arguments?["from"] == 1
                                    //                 ? givereviewDialog()
                                    //                 : Get.toNamed(
                                    //                     Routes.addressScreen,
                                    //                   );
                                  },
                                  child: Obx(() => CommonButton(
                                        height: 50,
                                        radius: 15,
                                        margin: const EdgeInsets.only(
                                            left: 20, right: 20),
                                        text: controller.bidingActionActive() !=
                                                null
                                            ? "Bid \$${controller.bidingData.value?.save?.bidPrice ?? controller.productDetailsData.value?.details?.price}"
                                            : controller.myBidProduct() != null
                                                ? "Buy Now"
                                                : controller.myBidProduct() != 1
                                                    ? "Biding End" // If biding is end and not win on biding
                                                    : "Buy Now*",
                                        // controller.upload.value
                                        //     ? "Give Reviews"
                                        //     : controller.track.value
                                        //         ? "Edit Tracking"
                                        //         : controller.trackupload.value
                                        //             ? "Upload"
                                        //             : Get.arguments?["from"] == 1
                                        //                 ? "Add Tracking ID"
                                        //                 : "Buy Now",
                                        textStyle: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontFamily: "Poppins",
                                            fontWeight: FontWeight.w400),
                                        color: controller.myBidProduct() !=
                                                    null ||
                                                controller
                                                        .bidingActionActive() ==
                                                    1
                                            ? AppColor.appColor
                                            : AppColor
                                                .grey, // 2023-12-21 15:20:00.000}
                                      )),
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buyFixedPriceProduct(
      {required String productId, required double amount}) async {
    // await _stripePay(
    //   () {
    //     // Success
    //   },
    //   productId: productId,
    //   amount: amount,
    // );
    AppDialogs.simple(
        body: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          Assets.successIcon,
          height: 50,
          width: 50,
        ),
        const SizedBox(height: 14),
        const AppText(
          text: "Payment successfully done",
          color: Colors.green,
          textSize: 18,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 14),
        GestureDetector(
          onTap: () => Get.back(),
          child: const CommonButton(
            color: AppColor.appColor,
            radius: 25,
            height: 40,
            text: " Ok ",
            textStyle: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ],
    ));
  }

  _buyBidProduct({required String productId, required double amount}) async {
    // API Request: product_id,
    await _stripePay(
      () {
        // Success
      },
      productId: productId,
      amount: amount,
    );
  }

  /// Pick shiping address and stripe payment
  _stripePay(Function() success,
      {required String productId, required double amount}) {
    //
    if (AddressController().initialized) {
      Get.find<AddressController>().getAddresses();
    } else {
      Get.put(AddressController()).getAddresses();
    }
    //
    Get.to(
      () => AddressScreen(
        paynow: (String addressId) async {
          await StripePaymentService.stripeMakePayment(
            amount: amount.toString(),
            // currency: "USD",
            name:
                "${UserStoredInfo().userInfo?.firstName ?? ''} ${UserStoredInfo().userInfo?.firstName ?? ''}",
            email: UserStoredInfo().userInfo?.email,
            phone: UserStoredInfo().userInfo?.phone == null
                ? null
                : "+${UserStoredInfo().userInfo?.countryCode} ${UserStoredInfo().userInfo?.phone}",
            success: (paymentIntent) async {
              // Success
              AppPrint.all("Payment Info: $paymentIntent");
              if (paymentIntent != null) {
                var resp = await controller.buyProduct(
                    transactionId: paymentIntent['id'],
                    paymentData: paymentIntent,
                    productId: productId,
                    amount: (paymentIntent['amount'] ?? 0.0) / 100,
                    shpingAddressId: addressId,
                    chargeAccount: 5.0);
                if (resp) {
                  success();
                }
              }
            },
          );
        },
      ),
      arguments: {'type': 'select_address'},
    );
    //---------
  }

  Widget _fixedInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const AppText(
              text: "Girl Denim",
              textSize: 17,
              fontWeight: FontWeight.w400,
              color: AppColor.blackColor,
            ),
            const Icon(Icons.star, color: AppColor.appColor),
            GestureDetector(
              onTap: () {
                Get.arguments?["from"] == 1 ? Container() : reviewDialog();
              },
              child: const AppText(
                text: "/4.5",
                textSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0x4d000000),
                fontFamily: "Poppins",
              ),
            )
          ],
        ),
        const SizedBox(height: 5),
        AppText(
          text:
              "\$${controller.productDetailsData.value?.details?.price ?? '0.0'}",
          textSize: 22,
          fontWeight: FontWeight.w400,
          color: AppColor.appColor,
        ),
        const SizedBox(height: 5),
        const AppText(
          text: "Inclusive of all taxes",
          textSize: 12,
          color: Color(0x32000000),
          fontWeight: FontWeight.w500,
        ),
        const SizedBox(height: 10),
        Obx(
          () => controller.track.value || controller.trackupload.value
              ? const AppText(
                  text: "Tracking ID : XX123XX343XX",
                  textSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                )
              : Container(),
        ),
        const SizedBox(height: 14),
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
              text: controller
                      .productDetailsData.value?.details?.category?.name ??
                  '',
              textSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColor.blackColor,
            ),
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
              fontFamily: "Poppins",
            ),
            AppText(
              text: controller.productDetailsData.value?.details?.category
                      ?.subCategory?.name ??
                  '',
              textSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColor.blackColor,
            ),
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
              text: controller.productDetailsData.value?.details?.color ?? '',
              textSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColor.blackColor,
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
              text: controller.productDetailsData.value?.details?.brand ?? '',
              textSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColor.blackColor,
            ),
          ],
        )
      ],
    );
  }

  Widget _bidInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.star, color: AppColor.appColor),
            GestureDetector(
              onTap: () {
                Get.arguments?["from"] == 1 ? Container() : reviewDialog();
              },
              child: const AppText(
                text: "/4.5",
                textSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0x4d000000),
                fontFamily: "Poppins",
              ),
            )
          ],
        ),
        const SizedBox(height: 14),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppText(text: "Current Bid: ", color: AppColor.grey),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                AppText(
                  text:
                      "\$${controller.bidingData.value?.save?.bidPrice ?? controller.productDetailsData.value?.details?.price}",
                  textSize: 24,
                  fontWeight: FontWeight.w700,
                ),
                const SizedBox(height: 8),
                AppText(
                  text:
                      "Min \$${controller.bidingData.value?.save?.bidPrice ?? controller.productDetailsData.value?.details?.price}",
                  textSize: 14,
                  color: AppColor.grey,
                ),
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    text: '${controller.bidingData.value?.count ?? 0} Bid ',
                    style: TextStyle(
                        fontSize: 12,
                        color: AppColor.blackColor.withOpacity(0.8),
                        fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Show bid history',
                          style: const TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 12),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.toNamed(Routes.biddingHistoryScreen);
                            }),
                    ],
                  ),
                )
              ],
            ))
          ],
        ),
        const SizedBox(height: 14),
        controller.bidingData.value?.save?.bidOver == 1
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppText(text: "Ends: ", color: AppColor.grey),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "",
                          style: const TextStyle(color: AppColor.blackColor),
                          children: <TextSpan>[
                            TextSpan(
                                text:
                                    "${controller.bidingData.value?.save?.createdAt == null ? '' : AppDateTime.getDateTime(controller.bidingData.value?.save?.createdAt, format: DateFormat("EEE, dd/MM/yy, hh:mm a"))}",
                                style: const TextStyle(color: AppColor.grey),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.toNamed(Routes.biddingHistoryScreen);
                                  }),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      RichText(
                        text: TextSpan(
                          text: "Extended Biding Interval ",
                          style: const TextStyle(color: AppColor.blackColor),
                          children: <TextSpan>[
                            TextSpan(
                                text: "30 Minutes",
                                style: const TextStyle(color: AppColor.grey),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.toNamed(Routes.biddingHistoryScreen);
                                  }),
                          ],
                        ),
                      )
                    ],
                  ))
                ],
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  _onBid(ProductDetails? product) async {
    await controller.getBidHistories(productId: (product?.id ?? '').toString());
    timerDialog(
        productId: (product?.id ?? '').toString(),
        endTime: controller
            .bidingEndAfter.value, // DateTime.parse("2023-12-20 18:37:00"),
        firstBid: (controller.bidingData.value?.history ?? []).isEmpty
            ? null
            : DateTime.parse((controller.bidingData.value?.history ?? [])
                    .first
                    .createdAt!)
                .toLocal(),
        bidNow: () {
          Get.back();
          AppDialogs.bidHistoryDialog(
            controller: controller.bidAmountInput,
            bidingData: controller.bidingData.value,
            isAddingBid: controller.addBbidingLoading.value,
            confirm: () {
              controller.addBid(
                  lastBidPrice: double.parse(
                      controller.bidingData.value?.save?.bidPrice ?? "0.0"),
                  productId: (product?.id ?? '').toString(),
                  bidPrice: double.parse(controller.bidAmountInput.text == ""
                      ? "0.0"
                      : controller.bidAmountInput.text));
            },
            seeAll: () {
              Get.toNamed(Routes.biddingHistoryScreen);
            },
          );
        });
  }

  _sendMessage() {
    ChatMsgController cmc;
    if (ChatMsgController().initialized) {
      cmc = Get.find<ChatMsgController>();
    } else {
      cmc = Get.put(ChatMsgController());
    }
    cmc.activeUser.value = Receiver(
        id: controller.productDetailsData.value?.details?.vendorId,
        firstName: "Vendor");
    cmc.goToChatRoom(
        Receiver(id: controller.productDetailsData.value?.details?.vendorId));
    // socketPrint(
    //     "Send First Message: ${(controller.productDetailsData.value?.details?.vendorId ?? '').toString()}!");
    // cmc.newMessageInput.text = "Hello";

    // cmc.sendNewMessage(
    //     (controller.productDetailsData.value?.details?.vendorId ?? '')
    //         .toString(),
    //     '1');
    // Get.toNamed(Routes.messageScreen);
  }

  Future reviewDialog() async {
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
                    margin: const EdgeInsets.only(left: 20, right: 20),
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
                        const Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: AppText(
                            text: "Reviews",
                            textSize: 18,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400,
                            color: AppColor.blackColor,
                          ),
                        ),
                        ListView.builder(
                          itemCount: 5,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppText(
                                      text: "Albert Smith",
                                      textSize: 11,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w400,
                                    ),
                                    AppText(
                                      text: "Feb 20, 2023",
                                      textSize: 10,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w400,
                                      color: Color(0x4d000000),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                RatingBar.builder(
                                    initialRating: 5,
                                    updateOnDrag: false,
                                    glow: false,
                                    minRating: 1,
                                    itemSize: 20,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    //  itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                                    itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: AppColor.appColor,
                                        ),
                                    ignoreGestures: true,
                                    onRatingUpdate: (rating) {}),
                                const SizedBox(
                                  height: 5,
                                ),
                                const AppText(
                                  text: "Best Product",
                                  textSize: 11,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w400,
                                ),
                                const Divider(
                                  thickness: 1,
                                  color: Color(0x33000000),
                                )
                              ],
                            );
                          },
                        ),
                      ],
                    )),
              ],
            ),
          );
        });
  }

  Future uploadDialog() async {
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
                    margin: const EdgeInsets.only(left: 20, right: 20),
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
                        const Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: AppText(
                            text: "Upload",
                            textSize: 18,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400,
                            color: AppColor.blackColor,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.cameraHelper.cropAspectRatioPreset =
                                CropAspectRatioPreset.square;
                            controller.cameraHelper.openImagePickerNew();
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                                top: 20, bottom: 20, left: 50),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            decoration: BoxDecoration(
                                color: const Color(0xffF6F6F6),
                                borderRadius: BorderRadius.circular(17),
                                border:
                                    Border.all(color: const Color(0xffF6F6F6))),
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.camera_alt,
                                  color: Color(0x1e000000),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                AppText(
                                  text: "Upload Picture",
                                  textSize: 15,
                                  color: Color(0x1e000000),
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w400,
                                )
                              ],
                            ),
                          ),
                        ),
                        const AppText(
                          text: "Add Signature",
                          textSize: 15,
                          color: Color(0x1e000000),
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w400,
                          underline: true,
                          underlineColor: Colors.black,
                        ),
                        DottedBorder(
                          borderPadding: const EdgeInsets.only(
                              top: 20, left: 20, right: 20),
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(12),
                          padding: const EdgeInsets.all(5),
                          child: const TextField(
                            maxLines: 5,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    top: 30, left: 20, right: 20),
                                border: InputBorder.none),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.upload.value = true;
                            controller.trackupload.value = false;
                            Get.back();
                            /* Map<String, dynamic> data = {
                              "data": 2,
                            };
                            Get.toNamed(Routes.denimScreen, arguments: data);*/
                          },
                          child: const CommonButton(
                            height: 50,
                            radius: 15,
                            margin:
                                EdgeInsets.only(left: 20, top: 20, right: 20),
                            text: "Upload",
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w400),
                            color: AppColor.appColor,
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          );
        });
  }

  Future trackingDialog() async {
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
                    margin: const EdgeInsets.only(left: 20, right: 20),
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
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: AppText(
                            text: controller.track.value
                                ? "Edit Tracking ID"
                                : "Add Tracking ID",
                            textSize: 18,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400,
                            color: AppColor.blackColor,
                          ),
                        ),
                        DottedBorder(
                          borderPadding: const EdgeInsets.only(
                              top: 20, left: 20, right: 20),
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(12),
                          padding: const EdgeInsets.only(
                            top: 20,
                          ),
                          child: const ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: 20, bottom: 20),
                                child: AppText(
                                  text: 'XX123XX343XX',
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Poppins",
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.cameraHelper.cropAspectRatioPreset =
                                CropAspectRatioPreset.square;
                            controller.cameraHelper.openImagePickerNew();
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                                top: 20, bottom: 20, left: 50),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            decoration: BoxDecoration(
                                color: const Color(0xffF6F6F6),
                                borderRadius: BorderRadius.circular(17),
                                border:
                                    Border.all(color: const Color(0xffF6F6F6))),
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.camera_alt,
                                  color: Color(0x1e000000),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                AppText(
                                  text: "Upload Picture",
                                  textSize: 15,
                                  color: Color(0x1e000000),
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w400,
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (controller.track.value) {
                              controller.trackupload.value = true;
                              controller.track.value = false;
                              Get.back();
                            } else {
                              controller.track.value = true;
                              Get.back();
                            }
                          },
                          child: CommonButton(
                            height: 50,
                            radius: 15,
                            margin: const EdgeInsets.only(
                                left: 20, top: 20, right: 20),
                            text: controller.track.value
                                ? "Update"
                                : "Add Tracking ID",
                            textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w400),
                            color: AppColor.appColor,
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          );
        });
  }

  Future givereviewDialog() async {
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
                    margin: const EdgeInsets.only(left: 20, right: 20),
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
                        const Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: AppText(
                            text: "Upload",
                            textSize: 18,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400,
                            color: AppColor.blackColor,
                          ),
                        ),
                        RatingBar.builder(
                            initialRating: 5,
                            updateOnDrag: false,
                            glow: false,
                            minRating: 1,
                            itemSize: 25,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            //  itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                            itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: AppColor.appColor,
                                ),
                            ignoreGestures: true,
                            onRatingUpdate: (rating) {}),
                        DottedBorder(
                          borderPadding: const EdgeInsets.only(
                              top: 20, left: 20, right: 20),
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(12),
                          padding: const EdgeInsets.all(5),
                          child: const TextField(
                            maxLines: 5,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    top: 30, left: 20, right: 20),
                                border: InputBorder.none),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.back();

                            Get.toNamed(Routes.productScreen);
                          },
                          child: const CommonButton(
                            height: 50,
                            radius: 15,
                            margin:
                                EdgeInsets.only(left: 20, top: 20, right: 20),
                            text: "Done",
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w400),
                            color: AppColor.appColor,
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          );
        });
  }
}
