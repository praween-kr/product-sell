import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/Socket/app_socket.dart';
import 'package:oninto_flutter/Socket/controller/chat_msg_controller.dart';
import 'package:oninto_flutter/Socket/model/one-to-one/chat_product_user_model.dart';
import 'package:oninto_flutter/generated/assets.dart';
import 'package:oninto_flutter/service/apis.dart';
import 'package:oninto_flutter/service/local/user_info_global.dart';
import 'package:oninto_flutter/utils/empty_widget.dart';
import 'package:oninto_flutter/utils/image_view.dart';

import '../../Socket/model/group/groups_list_model.dart';
import '../../utils/app_text.dart';
import '../../utils/appbar.dart';
import '../../utils/color_constant.dart';

class NavBarMsgScreen extends StatelessWidget {
  NavBarMsgScreen({super.key});
  final ChatMsgController _chatMsgController = Get.find();

  @override
  Widget build(BuildContext context) {
    _chatMsgController.messageController.value = 0;
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: const CommonAppbarWidget(
        leading: Text(""),
        heading: "Message",
        textStyle: TextStyle(
            fontSize: 20,
            color: AppColor.blackColor,
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
                                    ? AppColor.themeColor
                                    : Colors.white,
                            border: Border.all(
                              color:
                                  _chatMsgController.messageController.value ==
                                          0
                                      ? AppColor.themeColor
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
                                    ? AppColor.themeColor
                                    : Colors.white,
                            border: Border.all(
                              color:
                                  _chatMsgController.messageController.value ==
                                          1
                                      ? AppColor.themeColor
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
                    Obx(() => communities(_chatMsgController.groupsList)),
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
      },
      child: productUsers.isEmpty
          ? EmptyWidgets.simple(refresh: () async {
              await _chatMsgController.getUsers();
            })
          : ListView.builder(
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

                Receiver? user =
                    data.receiver?.id == UserStoredInfo().userInfo?.id
                        ? data.sender
                        : data.receiver;
                return InkWell(
                  onTap: () {
                    _chatMsgController.activeProduct.value = data.product;
                    _chatMsgController.activeUser.value = user;
                    _chatMsgController.goToChatRoom(user);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 35.0, vertical: 15.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: Container(
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 2.5, right: 2.5),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: AppImage.view(productImg,
                                              height: 57.0,
                                              width: 57.0,
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      (data.onlineStatus ?? false)
                                          ? const Positioned(
                                              bottom: 0,
                                              right: 0,
                                              child: CircleAvatar(
                                                  radius: 5,
                                                  backgroundColor:
                                                      AppColor.themeColor),
                                            )
                                          : const SizedBox.shrink(),
                                    ],
                                  ),
                                  const SizedBox(width: 12.0),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AppText(
                                          text:
                                              "${user?.firstName ?? ''} ${user?.lastName ?? ''}",
                                          textSize: 15.0,
                                          color: AppColor.blackColor,
                                          style: AppTextStyle.title,
                                          maxlines: 1,
                                        ),
                                        const SizedBox(height: 7.0),
                                        AppText(
                                          text: data.lastMessageIds?.message ??
                                              '',
                                          textSize: 12.0,
                                          color: AppColor.blackColor
                                              .withOpacity(0.3),
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
                                          color: AppColor.themeColor,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: AppText(
                                            text: (data.unreadCount ?? 0)
                                                .toString(),
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
              },
            ),
    );
  }

  Widget communities(List<GroupConstant> groups) {
    return RefreshIndicator(
      onRefresh: () async {
        await _chatMsgController.getGroupsList();
        await Future.delayed(const Duration(seconds: 1));
      },
      child: groups.isEmpty
          ? EmptyWidgets.simple(refresh: () async {
              await _chatMsgController.getGroupsList();
            })
          : ListView.separated(
              itemCount: groups.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                GroupConstant data = groups[index];
                return InkWell(
                  onTap: () {
                    _chatMsgController.activeGroup.value = data.group;
                    _chatMsgController.goToGroupChatRoom(data.group);
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 35.0, vertical: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              data.group?.productBaseInfo?.productImage != null
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 2.5, right: 2.5),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: AppImage.view(
                                            "${ImageBaseUrls.product}${data.group?.productBaseInfo?.productImage ?? ''}",
                                            height: 57.0,
                                            width: 57.0,
                                            fit: BoxFit.cover),
                                      ),
                                    )
                                  : Image.asset(
                                      Assets.assetsCrowd,
                                      height: 57.0,
                                      width: 57.0,
                                    ),
                              const SizedBox(width: 12.0),
                              AppText(
                                text: data.group?.productBaseInfo?.name ?? '',
                                textSize: 15.0,
                                color: AppColor.blackColor,
                                style: AppTextStyle.medium,
                              ),
                            ],
                          ),
                          (data.unreadCount ?? 0) == 0
                              ? const SizedBox.shrink()
                              : Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 10.0),
                                  decoration: const BoxDecoration(
                                    color: AppColor.themeColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: AppText(
                                      text: (data.unreadCount ?? 0).toString(),
                                      color: AppColor.white,
                                      textSize: 10.0,
                                      style: AppTextStyle.regular,
                                    ),
                                  ),
                                )
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (_, __) => Divider(
                  color: AppColor.blackColor.withOpacity(0.1),
                  height: 1.0,
                  thickness: 1.0),
            ),
    );
  }
}
