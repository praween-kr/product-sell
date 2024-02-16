import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oninto_flutter/Socket/controller/chat_msg_controller.dart';
import 'package:oninto_flutter/model/product/product_details_model.dart';
import 'package:oninto_flutter/service/local/user_info_global.dart';
import 'package:oninto_flutter/utils/app_text.dart';
import 'package:oninto_flutter/utils/app_text_field.dart';
import 'package:oninto_flutter/utils/appbar.dart';
import 'package:oninto_flutter/utils/color_constant.dart';
import 'package:oninto_flutter/utils/common_button.dart';
import 'package:oninto_flutter/utils/date_time_formates.dart';
import 'package:oninto_flutter/utils/details_images_view.dart';
import 'package:oninto_flutter/utils/shimmer_widget.dart';

import '../../../Socket/model/group/group_message_model.dart';
import '../../../common_controller/home/home_controller.dart';
import '../../../utils/core/core_method.dart';

class PublicShareProductDetails extends StatelessWidget {
  PublicShareProductDetails({super.key});
  final HomeCatProductController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppbarWidget(
        headingChild: Obx(
          () => _controller.loadingData.value
              ? ShimmerWidgets.text(w: Get.width * 0.4)
              : Text(
                  _controller.productDetailsData.value?.details?.name ?? '',
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
      ),
      body: Obx(
        () => _controller.loadingData.value
            ? ShimmerWidgets.product()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    DetailsImagesView(
                        images: (_controller.productDetailsData.value?.details
                                    ?.productImages ??
                                [])
                            .map((e) => e.image ?? '')
                            .toList()),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: AppText(
                                    text: _controller.productDetailsData.value
                                            ?.details?.name ??
                                        '',
                                    textSize: 14,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500),
                              ),
                              _controller.productDetailsData.value?.lastTrad
                                              ?.adminSold ==
                                          1 &&
                                      UserStoredInfo().userInfo?.id !=
                                          (_controller.productDetailsData.value
                                                  ?.details)
                                              ?.vendorId
                                  ? AppCore.soldTag()
                                  : const SizedBox.shrink()
                            ],
                          ),
                          const SizedBox(height: 5),
                          AppText(
                            text: _controller.productDetailsData.value?.details
                                    ?.description ??
                                '',
                            textSize: 11,
                            fontFamily: "Poppins",
                            lineHeight: 1.5,
                            fontWeight: FontWeight.w400,
                          ),
                          const Divider(thickness: 1, height: 20),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 1,
                                child: AppText(
                                    text:
                                        "Volume: ${_controller.productDetailsData.value?.details?.share ?? 0}",
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Poppins",
                                    textSize: 14),
                              ),
                              const Flexible(
                                flex: 1,
                                child: AppText(
                                    text:
                                        "High: 1.00", // Static Hight Share Price
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Poppins",
                                    textSize: 14),
                              ),
                              const Flexible(
                                flex: 1,
                                child: AppText(
                                    text: "Low: 1.00", // Static Low Share Price
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Poppins",
                                    textSize: 14),
                              )
                            ],
                          ),
                          const Divider(thickness: 1, height: 20),
                          const SizedBox(height: 5),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: AppText(
                                  text:
                                      "Last Trade Price: \$${_controller.productDetailsData.value?.lastTradBuyPrice == null ? (double.parse((_controller.productDetailsData.value?.details?.price ?? "0"))).toStringAsFixed(1) : (_controller.productDetailsData.value?.lastTradBuyPrice ?? 0).toStringAsFixed(1)}",
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Poppins",
                                  textSize: 14,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: AppText(
                                      text:
                                          "Available Shares: ${_controller.productDetailsData.value?.availableShare ?? 0}/${_controller.productDetailsData.value?.details?.totalShare ?? 0}",
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "Poppins",
                                      textAlign: TextAlign.right,
                                      lineHeight: 1.2,
                                      textSize: 14),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 40),
                          _controller.productDetailsData.value?.details
                                          ?.vendorId ==
                                      UserStoredInfo().userInfo?.id ||
                                  _controller.productDetailsData.value?.lastTrad
                                          ?.adminSold ==
                                      1
                              ? const SizedBox.shrink()
                              : GestureDetector(
                                  onTap: () {
                                    buyShareDialog(
                                      input: _controller.sharesInput,
                                      buynow: () {
                                        Get.back();
                                        _controller.emitPurchageProductShare();
                                      },
                                    );
                                  },
                                  child: const CommonButton(
                                    height: 50,
                                    radius: 20,
                                    color: AppColor.appColor,
                                    text: "Buy Now",
                                    textStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Poppins",
                                        color: Colors.white),
                                  ),
                                ),
                          // const SizedBox(height: 20),

                          /// ==========================Seller Side Data=========================== ///
                          /// ---------------------- ADMIN SOLD INFO ------------------------------///

                          // Divider(
                          //     color: AppColor.grey.withOpacity(0.4),
                          //     thickness: 0.8,
                          //     height: 30),
                          // Column(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     const AppText(
                          //       text: "Sold By Admin",
                          //       textSize: 14,
                          //       fontWeight: FontWeight.w600,
                          //       underline: true,
                          //     ),
                          //     const SizedBox(height: 14),
                          //     Column(
                          //       crossAxisAlignment: CrossAxisAlignment.start,
                          //       children: [
                          //         tile("Total Shares",
                          //             "${_controller.productDetailsData.value?.lastTrad?.totalSharePurchase ?? 0} shares"),
                          //         tile("Sold Price",
                          //             "\$${_controller.productDetailsData.value?.lastTrad?.adminSoldSharePrice ?? 0}/share"),
                          //         tile("Total Profites",
                          //             "\$${_controller.productDetailsData.value?.lastTrad?.totalProfit ?? 0}"),
                          //         tile("Calculation",
                          //             "${_controller.productDetailsData.value?.lastTrad?.calculation ?? 0}"),
                          //         const SizedBox(height: 5),
                          //         const AppText(
                          //           text: "\$${'sdfs'}",
                          //           textSize: 14,
                          //           color: AppColor.green,
                          //         ),
                          //       ],
                          //     )
                          //   ],
                          // ),
                          UserStoredInfo().userInfo?.id !=
                                  (_controller
                                          .productDetailsData.value?.details)
                                      ?.vendorId
                              ? const SizedBox.shrink()
                              : Divider(
                                  color: AppColor.grey.withOpacity(0.4),
                                  thickness: 0.8,
                                  height: 30),

                          /// ---------------------- SOLD BY USER HISTORIES -----------------------///
                          UserStoredInfo().userInfo?.id !=
                                  (_controller
                                          .productDetailsData.value?.details)
                                      ?.vendorId
                              ? const SizedBox.shrink()
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const AppText(
                                      text: "Sold history",
                                      textSize: 14,
                                      fontWeight: FontWeight.w600,
                                      underline: true,
                                    ),

                                    const SizedBox(height: 8),
                                    // if (UserStoredInfo().userInfo?.id ==
                                    //     _controller.productDetailsData.value?.details?.id)
                                    ListView.separated(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        ShareTradModel data = (_controller
                                                .productDetailsData
                                                .value
                                                ?.details
                                                ?.sharePurchases ??
                                            [])[index];
                                        return userBuyShareTile(data);
                                      },
                                      separatorBuilder: (_, __) =>
                                          const SizedBox(height: 14),
                                      itemCount:
                                          _controller.seeAllUserBuyShares.value
                                              ? (_controller
                                                          .productDetailsData
                                                          .value
                                                          ?.details
                                                          ?.sharePurchases ??
                                                      [])
                                                  .length
                                              : 3,
                                    ),
                                    const SizedBox(height: 8),
                                    (_controller
                                                        .productDetailsData
                                                        .value
                                                        ?.details
                                                        ?.sharePurchases ??
                                                    [])
                                                .length <
                                            3
                                        ? const SizedBox.shrink()
                                        : GestureDetector(
                                            onTap: () {
                                              _controller.seeAllUserBuyShares
                                                      .value =
                                                  !_controller
                                                      .seeAllUserBuyShares
                                                      .value;
                                            },
                                            child: Align(
                                              alignment: Alignment.topRight,
                                              child: Obx(
                                                () => AppText(
                                                  text: _controller
                                                          .seeAllUserBuyShares
                                                          .value
                                                      ? "See Less"
                                                      : "See All",
                                                  color: AppColor.themeColor,
                                                  fontWeight: FontWeight.w400,
                                                  textSize: 12,
                                                  underline: true,
                                                  underlineColor:
                                                      AppColor.themeColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                  ],
                                ),

                          ///---------COMMUNITY GROUP BUTTON-------------///
                          const SizedBox(height: 20),
                          (_controller.productDetailsData.value?.myTrads ?? [])
                                      .isNotEmpty ||
                                  _controller.productDetailsData.value?.details
                                          ?.vendorId ==
                                      UserStoredInfo().userInfo?.id
                              ? GestureDetector(
                                  onTap: () {
                                    // Get.toNamed(Routes.navbarScreen);
                                    _sendMessage();
                                  },
                                  child: const CommonButton(
                                    height: 50,
                                    radius: 20,
                                    color: AppColor.appColor,
                                    text: "Community",
                                    textStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Poppins",
                                        color: Colors.white),
                                  ),
                                )
                              : const SizedBox.shrink(),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget tile(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.topLeft,
              child: AppText(
                text: title,
                textSize: 14,
                color: AppColor.grey,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          AppText(
            text: value,
            textSize: 14,
            color: AppColor.blackColor,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget userBuyShareTile(ShareTradModel data) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: "${data.user?.firstName} ${data.user?.lastName}",
                textSize: 14,
              ),
              const SizedBox(height: 8),
              AppText(
                text: AppDateTime.getDateTime(
                  data.createdAt,
                  format: DateFormat("hh:mm a | dd MMM yyyy"),
                ),
                color: AppColor.grey,
                textSize: 12,
              ),
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            AppText(
              text: "${data.totalSharePurchase ?? 0} shares",
              textSize: 14,
              color: AppColor.red,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),
            AppText(
              text:
                  "\$${(data.totalSharePurchase ?? 0) * (data.perSharePrice ?? 0)}",
              textSize: 14,
              color: AppColor.green,
            ),
          ],
        ),
      ],
    );
  }

  _sendMessage() {
    ChatMsgController cmc;
    if (ChatMsgController().initialized) {
      cmc = Get.find<ChatMsgController>();
    } else {
      cmc = Get.put(ChatMsgController());
    }
    ChatGroup chatGroup = ChatGroup(
      id: _controller.productDetailsData.value?.groupDetail?.id,
      shareId: _controller.productDetailsData.value?.details?.id,
      productBaseInfo: ProductBaseInfo(
        category: _controller.productDetailsData.value?.details?.category,
        id: _controller.productDetailsData.value?.details?.id,
        image: _controller.productDetailsData.value?.details?.image,
        name: _controller.productDetailsData.value?.details?.name,
      ),
      user: _controller.productDetailsData.value?.groupDetail?.user,
    );
    cmc.activeGroup.value = chatGroup;
    cmc.goToGroupChatRoom(chatGroup);
    // socketPrint(
    //     "Send First Message: ${(controller.productDetailsData.value?.details?.vendorId ?? '').toString()}!");
    cmc.newMessageInput.text = "Hello";

    // cmc.sendNewMessage(
    //     (controller.productDetailsData.value?.details?.vendorId ?? '')
    //         .toString(),
    //     '1');
    // Get.toNamed(Routes.messageScreen);
  }

  Future buyShareDialog(
      {required TextEditingController input, required Function buynow}) async {
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
                            text: "Buy",
                            textSize: 18,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400,
                            color: AppColor.blackColor,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 16, right: 16, top: 20, bottom: 14),
                          decoration: BoxDecoration(
                              border: Border.all(color: AppColor.grey),
                              borderRadius: BorderRadius.circular(12)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: AppTextField(
                              height: 50,
                              title: "Shares",
                              controller: input,
                              textInputType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              hintStyle: const TextStyle(
                                  color: AppColor.grey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                              onChanged: (v) {},
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => buynow(),
                          child: const CommonButton(
                            height: 50,
                            radius: 15,
                            margin:
                                EdgeInsets.only(left: 20, top: 20, right: 20),
                            text: "Buy Now",
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w400),
                            color: AppColor.appColor,
                          ),
                        ),
                        const SizedBox(height: 20)
                      ],
                    )),
              ],
            ),
          );
        });
  }
}
