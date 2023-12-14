import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/Socket/app_socket.dart';
import 'package:oninto_flutter/Socket/controller/chat_msg_controller.dart';
import 'package:oninto_flutter/Socket/model/chat_product_user_model.dart';
import 'package:oninto_flutter/utils/appbar.dart';
import 'package:oninto_flutter/utils/color_constant.dart';
import 'package:oninto_flutter/generated/assets.dart';
import 'package:oninto_flutter/routes/routes.dart';
import 'package:oninto_flutter/service/apis.dart';
import 'package:oninto_flutter/utils/colors_file.dart';
import 'package:oninto_flutter/utils/app_text.dart';
import 'package:oninto_flutter/utils/image_view.dart';

class NavBarMsgScreen extends StatelessWidget {
  NavBarMsgScreen({super.key});
  // final HomeCatProductcontroller controller = Get.find();
  final ChatMsgController _chatMsgController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: CommonAppbarWidget(
        leading: const Text(""),
        heading: "Message",
        textStyle: const TextStyle(
            fontSize: 20,
            color: blackColor,
            fontWeight: FontWeight.w500,
            fontFamily: "Poppins"),
      ),
      body: DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Column(
          children: [
            Obx(() => TabBar(
                    splashFactory: NoSplash.splashFactory,
                    overlayColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                      // Use the default focused overlay color
                      return states.contains(MaterialState.focused)
                          ? null
                          : Colors.transparent;
                    }),
                    onTap: (index) {
                      _chatMsgController.messageController.value = index;
                    },
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    indicator:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    // indicatorColor: Colors.grey,
                    // labelColor: Colors.black,
                    // unselectedLabelColor: Colors.grey,
                    indicatorWeight: 1,
                    tabs: [
                      Container(
                        height: 42,
                        width: 148,
                        margin: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            color:
                                _chatMsgController.messageController.value == 0
                                    ? AppColor.appColor
                                    : Colors.white,
                            border: Border.all(
                              color:
                                  _chatMsgController.messageController.value ==
                                          0
                                      ? AppColor.appColor
                                      : Colors.grey.shade300,
                            ),
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: AppText(
                            text: "Community",
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400,
                            color:
                                _chatMsgController.messageController.value == 0
                                    ? Colors.white
                                    : Colors.grey.shade500,
                          ),
                        ),
                      ),
                      Container(
                        height: 42,
                        width: 148,
                        margin: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            color:
                                _chatMsgController.messageController.value == 1
                                    ? AppColor.appColor
                                    : Colors.white,
                            border: Border.all(
                              color:
                                  _chatMsgController.messageController.value ==
                                          1
                                      ? AppColor.appColor
                                      : Colors.grey.shade300,
                            ),
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: AppText(
                            text: "Messages",
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400,
                            color:
                                _chatMsgController.messageController.value == 1
                                    ? Colors.white
                                    : Colors.grey.shade500,
                          ),
                        ),
                      ),
                    ])),
            Expanded(
              child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    communities(),
                    Obx(() => products(_chatMsgController.users))
                  ]),
            )
          ],
        ),
      ),
    );
  }

  Widget products(List<ChatProductUser> productUsers) {
    socketPrint("Users: ${productUsers.length}");
    return RefreshIndicator(
      onRefresh: () async {
        await _chatMsgController.getUsers();
        await Future.delayed(const Duration(seconds: 1));
      },
      child: ListView.builder(
          itemCount: productUsers.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            ChatProductUser data = productUsers[index];
            String productImg = ImageBaseUrls.product;
            if ((data.product?.image ?? '') == '') {
              if ((data.product?.productImages ?? []).isNotEmpty) {
                productImg +=
                    (data.product?.productImages ?? []).first.image ?? '';
              }
            } else {
              productImg += data.product?.image ?? '';
            }
            socketPrint("Product Image: $productImg");

            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 35.0, vertical: 15.0),
              child: SizedBox(
                width: double.infinity,
                child: GestureDetector(
                  onTap: () {
                    _chatMsgController.goToChatRoom(data);
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: AppImage.view(productImg,
                                    height: 57.0,
                                    width: 57.0,
                                    fit: BoxFit.cover),
                              ),
                              const SizedBox(width: 12.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText(
                                      text:
                                          "${data.receiver?.firstName ?? ''} ${data.receiver?.lastName ?? ''}",
                                      textSize: 15.0,
                                      color: AppColor.blackColor,
                                      style: AppTextStyle.title,
                                      maxlines: 1,
                                    ),
                                    const SizedBox(height: 7.0),
                                    AppText(
                                      text: data.lastMessageIds?.message ?? '',
                                      textSize: 12.0,
                                      color:
                                          AppColor.blackColor.withOpacity(0.3),
                                      style: AppTextStyle.medium,
                                      maxlines: 1,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        (data.unreadCount ?? 0) == 0
                            ? const SizedBox.shrink()
                            : Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 10.0),
                                    decoration: const BoxDecoration(
                                      color: AppColor.appColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: AppText(
                                        text:
                                            (data.unreadCount ?? 0).toString(),
                                        color: AppColor.white,
                                        textSize: 10.0,
                                        style: AppTextStyle.regular,
                                      ),
                                    ),
                                  )
                                ],
                              )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  ListView communities() {
    return ListView.builder(
        itemCount: 2,
        shrinkWrap: true,
        itemBuilder: (context, position) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 35.0, vertical: 15.0),
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.gyaradoMsgScreen);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            Assets.assetsCrowd,
                            height: 57.0,
                            width: 57.0,
                          ),
                          const SizedBox(
                            width: 12.0,
                          ),
                          const AppText(
                            text: "Gyarado EX",
                            textSize: 15.0,
                            color: AppColor.blackColor,
                            style: AppTextStyle.medium,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            decoration: const BoxDecoration(
                              color: AppColor.appColor,
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: AppText(
                                text: "2",
                                color: AppColor.white,
                                textSize: 10.0,
                                style: AppTextStyle.regular,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                color: AppColor.blackColor.withOpacity(0.1),
                height: 1.0,
                thickness: 1.0,
              )
            ],
          );
        });
  }
}
