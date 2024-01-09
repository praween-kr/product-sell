import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oninto_flutter/Socket/app_socket.dart';
import 'package:oninto_flutter/Socket/controller/chat_msg_controller.dart';
import 'package:oninto_flutter/Socket/model/group/group_message_model.dart';
import 'package:oninto_flutter/Socket/socket_keys.dart';
import 'package:oninto_flutter/generated/assets.dart';
import 'package:oninto_flutter/service/apis.dart';
import 'package:oninto_flutter/service/local/user_info_global.dart';
import 'package:oninto_flutter/utils/app_text_field.dart';
import 'package:oninto_flutter/utils/appbar.dart';
import 'package:oninto_flutter/utils/common_button.dart';
import 'package:oninto_flutter/utils/date_time_formates.dart';
import 'package:oninto_flutter/utils/empty_widget.dart';
import 'package:oninto_flutter/utils/helper/file_picker.dart';
import 'package:oninto_flutter/utils/image_view.dart';
import 'package:oninto_flutter/utils/shimmer_widget.dart';
import 'package:oninto_flutter/utils/video/app_video_play.dart';
import 'package:oninto_flutter/utils/widgets/dialogs.dart';

import '../../utils/app_text.dart';
import '../../utils/color_constant.dart';

class GroupMessageScreen extends StatelessWidget {
  GroupMessageScreen({super.key});

  final ChatMsgController _chatMsgController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppbarWidget(
        headingChild: Obx(
          () => Text(
            _chatMsgController.activeGroup.value?.productBaseInfo?.name ?? '',
            style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                overflow: TextOverflow.ellipsis),
          ),
        ),
        textStyle: const TextStyle(
            fontWeight: FontWeight.w500, fontSize: 18, color: Colors.black),
        action: GestureDetector(
          onTap: () {
            customDialog(context);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
                color: AppColor.white,
                boxShadow: [
                  BoxShadow(
                      color: AppColor.borderColor.withOpacity(0.3),
                      blurRadius: 6)
                ],
                borderRadius: BorderRadius.circular(20.0)),
            child: const Center(
              child: Icon(
                Icons.bar_chart_rounded,
                color: AppColor.appColor,
                size: 40.0,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: Obx(
              () => _chatMsgController.loadingChatHistories.value
                  ? ShimmerWidgets.chatListView()
                  : _chatMsgController.groupMessages.isEmpty
                      ? EmptyWidgets.simple()
                      : SingleChildScrollView(
                          reverse: true,
                          physics: const ClampingScrollPhysics(),
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _chatMsgController.groupMessages.length,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            itemBuilder: (context, index) {
                              GroupMessage message =
                                  _chatMsgController.groupMessages[index];

                              return messageCard(
                                index,
                                message,
                                onLongClick: () => _deleteMsg(context,
                                    msgId: message.id.toString()),
                              );
                            },
                          ),
                        ),
            ),
          ),
          Obx(
            () => localAttachmentView(
                type: _chatMsgController.newMessageType.value,
                attachment: _chatMsgController.newMessageAttachment.value,
                thubnail:
                    _chatMsgController.newMessageType.value == MessageType.video
                        ? _chatMsgController.newMessageAttachmentThumbnail.value
                        : null,
                onClose: () {
                  _chatMsgController.clearMsgInput();
                }),
          ),
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            decoration: const BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  color: Color(0xff1c000000),
                  offset: Offset(0, -10),
                  blurRadius: 30)
            ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  child: AppTextField(
                    controller: _chatMsgController.newMessageInput,
                    title: "Type here ……..",
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Poppins",
                    ),
                  ),
                ),
                InkWell(
                    onTap: () => _addAttachments(),
                    child: Image.asset(Assets.assetsAttachment,
                        height: 20, width: 20)),
                const SizedBox(width: 5),
                InkWell(
                    onTap: () {
                      _chatMsgController.sendGroupMessage(
                        groupId:
                            _chatMsgController.activeGroup.value?.id.toString(),
                        productId: (_chatMsgController
                                    .activeGroup.value?.productBaseInfo?.id ??
                                '')
                            .toString(),
                      );
                    },
                    child: const Icon(Icons.send, color: AppColor.blackColor))
              ],
            ),
          )
        ],
      ),
    );
  }

  _deleteMsg(BuildContext context, {required String msgId}) {
    AppDialogs.confirm(
      context,
      msg: "Are you sure\nwant to delete message?",
      clickOnYes: () {
        // _chatMsgController.deleteMsg(msgId);
        Get.back();
      },
    );
  }

  _addAttachments() {
    AppPicker().image((path, type, thumb) {
      socketPrint("Attachment path: $path");
      if (path != null) {
        if (type == AttachmentPicker.IMG) {
          _chatMsgController.newMessageType.value = MessageType.image;
          _chatMsgController.newMessageAttachment.value = path;
        } else if (type == AttachmentPicker.VIDEO) {
          _chatMsgController.newMessageType.value = MessageType.video;
          _chatMsgController.newMessageAttachment.value = path;
          _chatMsgController.newMessageAttachmentThumbnail.value = thumb ?? '';
        }
      }
    }, hideFile: true);
  }

  PopupMenuButton<Function> popupWidget(
      {required String title, required Function onClick}) {
    return PopupMenuButton(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      offset: const Offset(-16, 40),
      icon: const Icon(Icons.more_vert, color: Colors.black, size: 25),
      onSelected: (value) {
        value();
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: onClick,
          child: Text(
            title,
            style: const TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }

  Widget dividerByDate(String dt) {
    return Column(
      children: [
        const SizedBox(height: 6),
        Row(
          children: [
            SizedBox(width: Get.width * 0.2),
            const Expanded(child: Divider()),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 3),
              decoration: BoxDecoration(
                  color: AppColor.themeColor.withOpacity(0.2),
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              child: Text(
                dt,
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ),
            const Expanded(child: Divider()),
            SizedBox(width: Get.width * 0.2),
          ],
        ),
        const SizedBox(height: 6),
      ],
    );
  }

  Widget messageCard(int index, GroupMessage message,
      {Function()? onLongClick, Function()? onClick}) {
    bool me = UserStoredInfo().userInfo?.id == message.senderId;
    bool isRead = message.readStatus == 1;
    //
    String? userImg =
        (message.sender?.image ?? '') == '' ? null : message.sender?.image;
    String userNameChar = '';
    String userName = '';
    if ((message.sender?.firstName ?? '') != '') {
      userNameChar += (message.sender?.firstName ?? '')[0];
      userName += message.sender?.firstName ?? '';
    }
    if ((message.sender?.lastName ?? '') != '') {
      userNameChar += (message.sender?.lastName ?? '')[0];
      userName += " ${message.sender?.lastName ?? ''}";
    }

    ///----- Divider -----
    String today = DateFormat("dd-MMM-yyyy").format(DateTime.now());
    String yesterday = DateFormat("dd-MMM-yyyy")
        .format(DateTime.now().subtract(const Duration(days: 1)));
    String lastMessageDate = DateFormat("dd-MMM-yyyy")
        .format(DateTime.parse(message.createdAt ?? ''));
    String? secLastMessageDate = index == 0
        ? null
        : DateFormat("dd-MMM-yyyy").format(DateTime.parse(
            _chatMsgController.groupMessages[index - 1].createdAt ?? ''));
    //
    String dt = '';
    if (index == 0) {
      dt = lastMessageDate == yesterday
          ? "Yesterday"
          : lastMessageDate == today
              ? "Today"
              : lastMessageDate;
    } else {
      if (secLastMessageDate != lastMessageDate) {
        dt = lastMessageDate == yesterday
            ? "Yesterday"
            : lastMessageDate == today
                ? "Today"
                : lastMessageDate;
      }
    }

    ///----
    socketPrint("message.thumbnail ?? '': ${message.thumbnail ?? ''}");
    return Column(
      children: [
        dt == '' ? const SizedBox.shrink() : dividerByDate(dt),
        SizedBox(
          width: double.infinity,
          child: Align(
            alignment: me ? Alignment.centerRight : Alignment.centerLeft,
            child: GestureDetector(
              onLongPress: onLongClick,
              onTap: onClick,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: Get.width * 0.7),
                child: Column(
                  crossAxisAlignment:
                      me ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        me
                            ? const SizedBox.shrink()
                            : ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                                child: Container(
                                  height: Get.context!.width * 0.12,
                                  width: Get.context!.width * 0.12,
                                  color: Colors.grey.shade300,
                                  child: userImg == null
                                      ? Center(
                                          child: Text(
                                            userNameChar,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700,
                                                color: AppColor.themeColor),
                                          ),
                                        )
                                      : AppImage.view(userImg,
                                          fit: BoxFit.cover),
                                ),
                              ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: me
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              me
                                  ? const SizedBox.shrink()
                                  : Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 14),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 3),
                                      decoration: BoxDecoration(
                                          color: AppColor.grey.withOpacity(0.2),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(2))),
                                      child: Text(
                                        userName,
                                        style: const TextStyle(fontSize: 10),
                                      )),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 14),
                                decoration: BoxDecoration(
                                    color: me
                                        ? Colors.grey.shade700
                                        : AppColor.themeColor.withOpacity(0.0),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(12))),
                                child: message.messageType.toString() ==
                                        MessageType.text
                                    ? AppText(
                                        text: message.message ?? '',
                                        lineHeight: 1.5,
                                        letterSpacing: 0.6,
                                        color: me ? Colors.white : Colors.black,
                                        fontFamily: "Oswald",
                                        fontWeight: FontWeight.w500,
                                        textSize: 14)
                                    : _attachmentView(
                                        message.messageType.toString() ==
                                                MessageType.video
                                            ? message.thumbnail ?? ''
                                            : message.message ?? '',
                                        video: message.messageType.toString() ==
                                                MessageType.video
                                            ? message.message
                                            : null),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    //
                    Wrap(
                      children: [
                        Text(
                            DateFormat("hh:mm a").format(
                                AppDateTime.getDateTime(
                                    message.createdAt ?? '')!),
                            style: const TextStyle(fontSize: 10)),
                        const SizedBox(width: 5),
                        me
                            ? Icon(
                                isRead ? Icons.done_all : Icons.check,
                                size: 16,
                                color:
                                    isRead ? Colors.blue : Colors.grey.shade400,
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _attachmentView(String url, {String? video}) {
    String ext = url.split('.').last;
    print("Msg Attachment: $url");
    return ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 60,
          minHeight: 60,
          maxWidth: fileTypes.contains(ext) ? double.infinity : 150,
          maxHeight: fileTypes.contains(ext) ? 60 : 150,
        ),
        child: fileTypes.contains(ext)
            ? GestureDetector(
                onTap: () async {
                  // await AppImage.viewUrl("${AppApis.imageBaseUrl}$url");
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      color: Colors.grey.shade300,
                      height: 45,
                      width: 45,
                    ),
                    // Image.asset(
                    //   ext == 'pdf'
                    //       ? Assets.filePdf
                    //       : ['docx', 'doc'].contains(ext)
                    //           ? Assets.fileDoc
                    //           : ['pptx', 'ppt'].contains(ext)
                    //               ? Assets.filePpt
                    //               : ['xlsx', 'xls'].contains(ext)
                    //                   ? Assets.fileExcel
                    //                   : Assets.filetext,
                    //   height: 45,
                    //   width: 45,
                    // ),
                    const SizedBox(width: 8),
                    Expanded(child: Text(url.split('/').last)),
                  ],
                ),
              )
            : GestureDetector(
                onTap: () {
                  if (video == null) {
                    AppImage.viewFull("${ImageBaseUrls.messageAttachment}$url");
                  } else {
                    Get.to(() => AppVideoPlayer(
                        video: "${ImageBaseUrls.messageAttachment}$video"));
                  }
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        child: AppImage.view(
                            "${ImageBaseUrls.messageAttachment}$url",
                            width: video != null ? double.infinity : null,
                            errorShow: true,
                            fit: video != null ? BoxFit.cover : null)),
                    video != null
                        ? const CircleAvatar(
                            backgroundColor: Colors.black54,
                            child: Icon(Icons.play_arrow, color: Colors.white))
                        : const SizedBox.shrink(),
                  ],
                ),
              ));
  }

  Widget localAttachmentView(
          {required String attachment,
          String? thubnail,
          required String type,
          required Function onClose}) =>
      type == MessageType.text
          ? const SizedBox.shrink()
          : ConstrainedBox(
              constraints: BoxConstraints(maxHeight: Get.height * 0.4),
              child: Stack(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 22, right: 22, top: 16),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20)),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        width: double.infinity,
                        decoration: BoxDecoration(color: Colors.grey.shade200),
                        child: type == MessageType.image
                            ? Image.file(
                                File(attachment),
                                fit: BoxFit.fill,
                              )
                            : thubnail == null
                                ? const Center(child: Text("..."))
                                : Image.file(
                                    File(thubnail),
                                    fit: BoxFit.fill,
                                  ),
                      ),
                    ),
                  ),
                  //
                  Positioned(
                      right: 5,
                      top: 0,
                      child: GestureDetector(
                        onTap: () => onClose(),
                        child: CircleAvatar(
                          backgroundColor: Colors.grey.shade300,
                          child: const Icon(Icons.close),
                        ),
                      ))
                ],
              ),
            );

  /// Dialog View
  customDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Material(
              type: MaterialType.transparency,
              child: Align(
                child: Container(
                  height: 390.0, width: 300.0,
                  // padding: const EdgeInsets.symmetric(vertical: 30.0),
                  margin: const EdgeInsets.symmetric(
                      horizontal: 35.0, vertical: 20.0),
                  decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(25)),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12.0, bottom: 30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Align(
                          alignment: Alignment.center,
                          child: AppText(
                            text: "Poll",
                            style: AppTextStyle.title,
                            textSize: 13,
                            color: AppColor.blackColor,
                          ),
                        ),
                        const SizedBox(
                          height: 24.0,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 13.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                text: "Question",
                                style: AppTextStyle.title,
                                textSize: 9,
                                color: AppColor.blackColor,
                              ),
                              SizedBox(
                                height: 7.0,
                              ),
                              AppText(
                                text: "What's your poll question ?",
                                textSize: 9,
                                color: AppColor.blackColor,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 13.0,
                        ),
                        Divider(
                          thickness: 1,
                          color: AppColor.blackColor.withOpacity(0.2),
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 13.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                text: "Expiration",
                                style: AppTextStyle.title,
                                textSize: 9,
                                color: AppColor.blackColor,
                              ),
                              SizedBox(
                                height: 11.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.calendar_month_outlined,
                                    color: AppColor.appColor,
                                    size: 15.0,
                                  ),
                                  SizedBox(
                                    width: 11.0,
                                  ),
                                  AppText(
                                    text: "13-12-2022",
                                    textSize: 9,
                                    color: AppColor.blackColor,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 19.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.watch_later,
                                    color: AppColor.appColor,
                                    size: 15.0,
                                  ),
                                  SizedBox(
                                    width: 11.0,
                                  ),
                                  AppText(
                                    text: "16:35",
                                    textSize: 9,
                                    color: AppColor.blackColor,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 13.0,
                        ),
                        Divider(
                          thickness: 1,
                          color: AppColor.blackColor.withOpacity(0.2),
                        ),
                        const SizedBox(
                          height: 13.0,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 13.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                text: "Options",
                                style: AppTextStyle.title,
                                textSize: 9,
                                color: AppColor.blackColor,
                              ),
                              SizedBox(
                                height: 11.0,
                              ),
                              AppText(
                                text: "Option 1",
                                textSize: 9,
                                color: AppColor.blackColor,
                              ),
                              SizedBox(
                                height: 22.0,
                              ),
                              AppText(
                                text: "Option 2",
                                textSize: 9,
                                color: AppColor.blackColor,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: const CommonButton(
                            color: AppColor.appColor,
                            radius: 17,
                            margin: EdgeInsets.only(right: 30, left: 30),
                            //height: 39,
                            text: "Create Poll",
                            textStyle:
                                TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ));
        });
  }

  List fileTypes = ['pdf', 'docx', 'doc', 'txt', 'pptx', 'ppt', 'xlsx', 'xls'];

  List imageTypes = ["png", "jpeg", "jpg"];
}
