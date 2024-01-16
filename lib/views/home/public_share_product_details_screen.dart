import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/Socket/controller/chat_msg_controller.dart';
import 'package:oninto_flutter/service/local/user_info_global.dart';
import 'package:oninto_flutter/utils/app_text.dart';
import 'package:oninto_flutter/utils/app_text_field.dart';
import 'package:oninto_flutter/utils/appbar.dart';
import 'package:oninto_flutter/utils/color_constant.dart';
import 'package:oninto_flutter/utils/common_button.dart';
import 'package:oninto_flutter/utils/details_images_view.dart';
import 'package:oninto_flutter/utils/shimmer_widget.dart';

import '../../Socket/model/group/group_message_model.dart';
import '../../common_controller/home/home_controller.dart';

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
                          AppText(
                              text: _controller.productDetailsData.value
                                      ?.details?.name ??
                                  '',
                              textSize: 14,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppText(
                                  text:
                                      "Last Trade Price: \$${(_controller.productDetailsData.value?.lastTradBuyPrice ?? 0).toStringAsFixed(1)}",
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Poppins",
                                  textSize: 14),
                              AppText(
                                  text:
                                      "Available Shares: ${_controller.productDetailsData.value?.availableShare ?? 0}/${_controller.productDetailsData.value?.details?.totalShare ?? 0}",
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Poppins",
                                  textSize: 14),
                            ],
                          ),
                          const SizedBox(height: 40),
                          _controller.productDetailsData.value?.details
                                      ?.vendorId ==
                                  UserStoredInfo().userInfo?.id
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
                          const SizedBox(height: 20),
                          (_controller.productDetailsData.value?.myTrads ?? [])
                                  .isEmpty
                              ? const SizedBox.shrink()
                              : GestureDetector(
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
                                ),
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
