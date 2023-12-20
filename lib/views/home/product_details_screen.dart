import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:intl/intl.dart';
import 'package:oninto_flutter/Socket/controller/chat_msg_controller.dart';
import 'package:oninto_flutter/Socket/model/chat_product_user_model.dart';
import 'package:oninto_flutter/common_controller/home/home_controller.dart';
import 'package:oninto_flutter/common_controller/product/biding_.dart';
import 'package:oninto_flutter/generated/assets.dart';
import 'package:oninto_flutter/model/product/product_details_model.dart';
import 'package:oninto_flutter/routes/routes.dart';
import 'package:oninto_flutter/utils/app_text.dart';
import 'package:oninto_flutter/utils/app_timer.dart';
import 'package:oninto_flutter/utils/app_toast_loader.dart';
import 'package:oninto_flutter/utils/appbar.dart';
import 'package:oninto_flutter/utils/common_button.dart';
import 'package:oninto_flutter/utils/date_time_formates.dart';
import 'package:oninto_flutter/utils/details_images_view.dart';
import 'package:oninto_flutter/utils/shimmer_widget.dart';
import 'package:oninto_flutter/utils/widgets/dialogs.dart';

import '../../utils/color_constant.dart';

class ProductDetailsScreen extends StatelessWidget {
  ProductDetailsScreen({super.key});
  final HomeCatProductController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    // DateTime targetDT = DateTime.parse("2023-12-20 18:37:00"
    //     //"${controller.productDetailsData.value?.details?.startDate ?? "0000-00-00"} ${controller.productDetailsData.value?.details?.bidTime ?? "00:00:00"}",
    //     );
    // DateTime today = DateTime.now();
    // Duration s = targetDT.difference(today);
    // DateTime dt = DateTime.parse(today.toString().split(" ").first);
    // Duration liveTime = targetDT.difference(dt);
    // print("Timer Start to --> $dt *${liveTime.inDays}");
    // print("product data: ${controller.productDetailsData.value}");
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Expanded(
                    child: AppText(
                        text: "Bid Ending Soon:",
                        textSize: 13,
                        fontFamily: "Poppins"),
                  ),
                  Obx(
                    () => AppTimer(
                      textType: true,
                      bidNow: () {},
                      endTime: controller
                          .bidingEndAfter.value, //"2023-12-20 18:37:00"
                      textSize: 14,
                      onChanged: (TimerType data) {
                        controller.bidingTimerStatus.value = data.status;
                        // print("Timer Start to --> - ${data.value}");
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                                    BorderRadius.circular(20)),
                                            child: const Icon(
                                              Icons.message,
                                              color: Colors.white,
                                            )),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      const AppText(
                                        text: "Girl Denim",
                                        textSize: 17,
                                        fontWeight: FontWeight.w400,
                                        color: AppColor.blackColor,
                                      ),
                                      const Icon(Icons.star,
                                          color: AppColor.appColor),
                                      GestureDetector(
                                        onTap: () {
                                          Get.arguments?["from"] == 1
                                              ? Container()
                                              : reviewDialog();
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
                                    () => controller.track.value ||
                                            controller.trackupload.value
                                        ? const AppText(
                                            text: "Tracking ID : XX123XX343XX",
                                            textSize: 15,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                          )
                                        : Container(),
                                  ),
                                  const SizedBox(height: 30),
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
                                                .productDetailsData
                                                .value
                                                ?.details
                                                ?.category
                                                ?.name ??
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
                                        text: controller
                                                .productDetailsData
                                                .value
                                                ?.details
                                                ?.category
                                                ?.subCategory
                                                ?.name ??
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
                                        text: controller.productDetailsData
                                                .value?.details?.color ??
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
                                        text: "Brand : ",
                                        textSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff9F9F9F),
                                        fontFamily: "Poppins",
                                      ),
                                      AppText(
                                        text: controller.productDetailsData
                                                .value?.details?.brand ??
                                            '',
                                        textSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: AppColor.blackColor,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Divider(color: Color(0x66000000)),
                            const Padding(
                              padding: EdgeInsets.only(top: 20, left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                    padding: const EdgeInsets.only(left: 20),
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
                                                fontWeight: FontWeight.w400),
                                            Expanded(
                                              child: AppText(
                                                  text: controller
                                                          .productDetailsData
                                                          .value
                                                          ?.details
                                                          ?.location ??
                                                      '',
                                                  textSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColor.blackColor,
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
                              padding: const EdgeInsets.only(top: 20, left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const AppText(
                                      text: "Item Description",
                                      textSize: 13,
                                      fontFamily: "Poppins"),
                                  const SizedBox(height: 5),
                                  AppText(
                                      text: controller.productDetailsData.value
                                              ?.details?.description ??
                                          '',
                                      textSize: 13,
                                      fontFamily: "Poppins",
                                      color: const Color(0x4d000000)),
                                ],
                              ),
                            ),
                            const SizedBox(height: 30),
                            GestureDetector(
                              onTap: () {
                                if (controller.bidingActionActive() == 0) {
                                  AppToast.show("Biding will be start soon");
                                } else if (controller.bidingActionActive() ==
                                    1) {
                                  // Can bid on continue
                                  if (controller.productType.value ==
                                      ProductType.BID) {
                                    _onBid(controller
                                        .productDetailsData.value?.details);
                                  }
                                } else if (controller.myBidProduct() == 0) {
                                  // Fixed Price - Buy
                                } else if (controller.myBidProduct() == 1) {
                                  // Biding Product - my last bid on product - Buy
                                  Get.toNamed(Routes.paymentScreen);
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
                                        ? "Bid \$2500"
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
                                    color: controller.myBidProduct() != 1
                                        ? Colors.grey.shade500
                                        : AppColor.appColor,
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

  _onBid(ProductDetails? product) async {
    await controller.getBidHistories(productId: (product?.id ?? '').toString());
    timerDialog(
        endTime: controller
            .bidingEndAfter.value, // DateTime.parse("2023-12-20 18:37:00"),
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
