import 'dart:convert';
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
import 'package:oninto_flutter/utils/app_toast_loader.dart';
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

// ignore: must_be_immutable
class GroupMessageScreen extends StatelessWidget {
  GroupMessageScreen({super.key});

  final ChatMsgController _chatMsgController = Get.find();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (b) {
        _chatMsgController.activeGroup.value = null;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CommonAppbarWidget(
          headingChild: Obx(
            () => GestureDetector(
              onTap: () => _chatMsgController.goToGroupDetails(),
              child: Text(
                _chatMsgController.activeGroup.value?.productBaseInfo?.name ??
                    '',
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    overflow: TextOverflow.ellipsis),
              ),
            ),
          ),
          textStyle: const TextStyle(
              fontWeight: FontWeight.w500, fontSize: 18, color: Colors.black),
          action: GestureDetector(
            onTap: () {
              pollCreateDialog(context, createPoll: (inputData) {
                _chatMsgController.newMessageType.value = MessageType.poll;
                _chatMsgController.newMessageInput.text = jsonEncode(inputData);
                socketPrint("Poll Input: $inputData");
                //
                _chatMsgController.sendGroupMessage(
                  groupId: _chatMsgController.activeGroup.value?.id.toString(),
                  productId: (_chatMsgController
                              .activeGroup.value?.productBaseInfo?.id ??
                          '')
                      .toString(),
                );
              });
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
                  borderRadius: BorderRadius.circular(16.0)),
              child: const Center(
                child: Icon(
                  Icons.bar_chart_rounded,
                  color: AppColor.appColor,
                  size: 28.0,
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
                            child: Column(
                              children: [
                                Column(
                                  children: [
                                    const SizedBox(height: 30),
                                    infoMessage(DateFormat("dd-MMM-yyyy")
                                        .format(DateTime.parse(
                                            _chatMsgController.groupInfo.value
                                                    ?.group?.createdAt ??
                                                ''))),
                                    const SizedBox(height: 8),
                                    infoMessage(
                                        "~Group Created (${_chatMsgController.groupInfo.value?.group?.groupName ?? ''})"),
                                    const SizedBox(height: 30),
                                  ],
                                ),
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:
                                      _chatMsgController.groupMessages.length,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  itemBuilder: (context, index) {
                                    GroupMessage message =
                                        _chatMsgController.groupMessages[index];

                                    return messageCard(
                                      index,
                                      message,
                                      onLongClick: () => _deleteMsg(context,
                                          index: index,
                                          groupId: message.groupId,
                                          msgId: message.id.toString()),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
              ),
            ),
            Obx(
              () => localAttachmentView(
                  type: _chatMsgController.newMessageType.value,
                  attachment: _chatMsgController.newMessageAttachment.value,
                  thubnail: _chatMsgController.newMessageType.value ==
                          MessageType.video
                      ? _chatMsgController.newMessageAttachmentThumbnail.value
                      : null,
                  onClose: () {
                    _chatMsgController.clearMsgInput();
                  }),
            ),
            Obx(
              () => replayMessageView(
                  type: _chatMsgController.newMessageType.value,
                  replayMsg:
                      _chatMsgController.replayOnMessage.value?.message ?? '',
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
                          groupId: _chatMsgController.activeGroup.value?.id
                              .toString(),
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
      ),
    );
  }

  Widget infoMessage(String infoMsg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(5),
      ),
      child: AppText(
        text: infoMsg,
        textSize: 11,
        textAlign: TextAlign.center,
        color: AppColor.appColor,
      ),
    );
  }

  _deleteMsg(BuildContext context,
      {required String msgId, required int index, required int? groupId}) {
    AppDialogs.confirm(
      context,
      msg: "Are you sure\nwant to delete message?",
      clickOnYes: () {
        _chatMsgController.deleteMsg(msgId, index, groupId: groupId);
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
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColor.blackColor.withOpacity(0.5)),
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
    return message.messageType.toString() == MessageType.newjoinig
        ? const SizedBox.shrink()
        // Container(
        //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        //     margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        //     decoration: BoxDecoration(
        //       color: Colors.grey.shade100,
        //       borderRadius: BorderRadius.circular(5),
        //     ),
        //     child: AppText(
        //       text: "~$userName Joined",
        //       textSize: 12,
        //       textAlign: TextAlign.center,
        //       color: AppColor.appColor,
        //     ),
        //   )
        : Column(
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
                        crossAxisAlignment: me
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              me
                                  ? const SizedBox.shrink()
                                  : AppImage.profile(
                                      Get.context!,
                                      viewOnly: true,
                                      isNetwork: true,
                                      url: "${ImageBaseUrls.profile}$userImg",
                                      radius: 24,
                                      squareTypeRadius: 12,
                                    ),
                              // ClipRRect(
                              //     borderRadius:
                              //         const BorderRadius.all(Radius.circular(8)),
                              //     child: Container(
                              //       height: Get.context!.width * 0.12,
                              //       width: Get.context!.width * 0.12,
                              //       color: Colors.grey.shade300,
                              //       child: userImg == null
                              //           ? Center(
                              //               child: Text(
                              //                 userNameChar,
                              //                 style: const TextStyle(
                              //                     fontSize: 20,
                              //                     fontWeight: FontWeight.w700,
                              //                     color: AppColor.themeColor),
                              //               ),
                              //             )
                              //           : AppImage.view(
                              //               "${ImageBaseUrls.profile}$userImg",
                              //               fit: BoxFit.cover,
                              //               isProfile: true),
                              //     ),
                              //   ),
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
                                                color: AppColor.grey
                                                    .withOpacity(0.2),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(2))),
                                            child: Text(
                                              userName,
                                              style:
                                                  const TextStyle(fontSize: 10),
                                            )),
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: !me &&
                                                  message.messageType
                                                          .toString() ==
                                                      MessageType.poll
                                              ? 5
                                              : 0,
                                          top: !me &&
                                                  message.messageType
                                                          .toString() ==
                                                      MessageType.poll
                                              ? 5
                                              : 0),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 14),
                                      decoration: BoxDecoration(
                                          color: me
                                              ? Colors.grey.shade700
                                                  .withOpacity(message
                                                              .messageType
                                                              .toString() ==
                                                          MessageType.poll
                                                      ? 0.2
                                                      : 1)
                                              : AppColor.themeColor.withOpacity(
                                                  message.messageType
                                                              .toString() ==
                                                          MessageType.poll
                                                      ? 0.1
                                                      : 0.0),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(12))),
                                      child: message.messageType.toString() ==
                                              MessageType.text
                                          ? AppText(
                                              text: message.message ?? '',
                                              lineHeight: 1.5,
                                              letterSpacing: 0.6,
                                              color: me
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontFamily: "Oswald",
                                              fontWeight: FontWeight.w500,
                                              textSize: 14)
                                          : message.messageType.toString() ==
                                                  MessageType.poll
                                              ? pollMessage(message, me, replay:
                                                  (GroupMessage replayMesage) {
                                                  _chatMsgController
                                                          .newMessageType
                                                          .value =
                                                      MessageType.replay;
                                                  _chatMsgController
                                                      .replayOnMessage
                                                      .value = replayMesage;
                                                })
                                              : message.messageType
                                                          .toString() ==
                                                      MessageType.replay
                                                  ? _replayMsgView(message, me)
                                                  : _attachmentView(
                                                      message.messageType
                                                                  .toString() ==
                                                              MessageType.video
                                                          ? message.thumbnail ??
                                                              ''
                                                          : message.message ??
                                                              '',
                                                      video: message.messageType
                                                                  .toString() ==
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
                                      color: isRead
                                          ? Colors.blue
                                          : Colors.grey.shade400,
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

  Widget _replayMsgView(GroupMessage message, bool me) {
    ReplayMessage replayMessage =
        ReplayMessage.fromJson(jsonDecode(message.message ?? ''));
    // socketPrint("djfksdj: $dd");
    PollMessage pollMessage =
        PollMessage.fromJson(jsonDecode(replayMessage.replayonMsg ?? ''));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColor.appColor.withOpacity(0.2)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: AppText(
                        text: "Poll",
                        lineHeight: 1.5,
                        letterSpacing: 0.6,
                        color: me ? Colors.white : Colors.black,
                        fontFamily: "Oswald",
                        fontWeight: FontWeight.w600,
                        textSize: 15),
                  ),
                  Icon(
                    Icons.reply_sharp,
                    color: me ? Colors.white : Colors.black,
                  ),
                ],
              ),
              Divider(
                  height: 1.5,
                  color: (me ? Colors.white : Colors.black).withOpacity(0.5)),
              AppText(
                  text: pollMessage.question ?? '',
                  lineHeight: 1.5,
                  letterSpacing: 0.6,
                  color: me ? Colors.white : Colors.black,
                  fontFamily: "Oswald",
                  fontWeight: FontWeight.w600,
                  textSize: 14),
              const SizedBox(height: 8),
              AppText(
                  text:
                      "${AppDateTime.getDateTime(pollMessage.expDate, format: DateFormat('EEE DD MMM yyyy'))} at ${AppDateTime.time12hr(timeString: pollMessage.expTime)}",
                  lineHeight: 1.5,
                  letterSpacing: 0.6,
                  color: me ? Colors.white : Colors.black,
                  fontFamily: "Oswald",
                  fontWeight: FontWeight.w600,
                  textSize: 10),
            ],
          ),
        ),
        const SizedBox(height: 8),
        AppText(
            text: replayMessage.message ?? '',
            lineHeight: 1.5,
            letterSpacing: 0.6,
            color: me ? Colors.white : Colors.black,
            fontFamily: "Oswald",
            fontWeight: FontWeight.w600,
            textSize: 14),
      ],
    );
  }

  Widget pollMessage(GroupMessage message, bool me,
      {required Function(GroupMessage replayMsg) replay}) {
    PollMessage pollMsg =
        PollMessage.fromJson(jsonDecode(message.message ?? ''));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
              child: AppText(
                  text: "Poll",
                  lineHeight: 1.5,
                  letterSpacing: 0.6,
                  color: Colors.black,
                  fontFamily: "Oswald",
                  fontWeight: FontWeight.w600,
                  textSize: 15),
            ),
            GestureDetector(
                onTap: () {
                  replay(message);
                },
                child:
                    const Icon(Icons.question_answer, color: Colors.black54)),
          ],
        ),
        Divider(height: 1, color: (Colors.black).withOpacity(0.5)),
        const SizedBox(height: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
                text: "Question".toUpperCase(),
                lineHeight: 1.5,
                letterSpacing: 0.6,
                color: Colors.black54,
                fontFamily: "Oswald",
                fontWeight: FontWeight.w600,
                textSize: 14),
            const SizedBox(height: 5),
            AppText(
                text: pollMsg.question ?? '',
                lineHeight: 1.5,
                letterSpacing: 0.6,
                color: Colors.black,
                fontFamily: "Oswald",
                fontWeight: FontWeight.w500,
                textSize: 14),
          ],
        ),
        const SizedBox(height: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
                text: "Expiration".toUpperCase(),
                lineHeight: 1.5,
                letterSpacing: 0.6,
                color: Colors.black54,
                fontFamily: "Oswald",
                fontWeight: FontWeight.w600,
                textSize: 14),
            const SizedBox(height: 5),
            AppText(
                text:
                    "${AppDateTime.getDateTime(pollMsg.expDate, format: DateFormat('EEE DD MMM yyyy'))} at ${AppDateTime.time12hr(timeString: pollMsg.expTime)}",
                lineHeight: 1.5,
                letterSpacing: 0.6,
                color: Colors.black,
                fontFamily: "Oswald",
                fontWeight: FontWeight.w500,
                textSize: 13),
          ],
        ),
        const SizedBox(height: 8),
        pollMsg.options == null
            ? const SizedBox.shrink()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                      text: "Options".toUpperCase(),
                      lineHeight: 1.5,
                      letterSpacing: 0.6,
                      color: Colors.black54,
                      fontFamily: "Oswald",
                      fontWeight: FontWeight.w600,
                      textSize: 14),
                  const SizedBox(height: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: (pollMsg.options ?? [])
                        .map((option) => Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              margin:
                                  const EdgeInsets.only(bottom: 5, right: 5),
                              decoration: BoxDecoration(
                                  color: AppColor.appColor.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20)),
                              child: AppText(
                                  text: option,
                                  lineHeight: 1.5,
                                  letterSpacing: 0.6,
                                  color: Colors.black,
                                  fontFamily: "Oswald",
                                  fontWeight: FontWeight.w600,
                                  textSize: 14),
                            ))
                        .toList(),
                  ),
                ],
              ),
        // AppText(
        //     text: message.message ?? '',
        //     lineHeight: 1.5,
        //     letterSpacing: 0.6,
        //     color: me ? Colors.white : Colors.black,
        //     fontFamily: "Oswald",
        //     fontWeight: FontWeight.w500,
        //     textSize: 14),
      ],
    );
  }

  Widget _attachmentView(String url, {String? video}) {
    String ext = url.split('.').last;
    socketPrint("Msg Attachment: $url");
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

  Widget replayMessageView(
      {required String replayMsg,
      required String type,
      required Function onClose}) {
    socketPrint("dsflsd==> $replayMsg");
    if (replayMsg == '') return const SizedBox.shrink();
    PollMessage pollMsg = PollMessage.fromJson(jsonDecode(replayMsg));
    return type == MessageType.replay
        ? ConstrainedBox(
            constraints: BoxConstraints(maxHeight: Get.height * 0.4),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 22, right: 22, top: 16),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20)),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 14),
                      width: double.infinity,
                      decoration: BoxDecoration(color: Colors.grey.shade200),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.reply_sharp, color: Colors.black),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: AppText(
                                      text: "Poll",
                                      lineHeight: 1.5,
                                      letterSpacing: 0.6,
                                      color: Colors.black,
                                      fontFamily: "Oswald",
                                      fontWeight: FontWeight.w600,
                                      textSize: 15),
                                ),
                              ),
                              SizedBox(width: 8),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Divider(
                              height: 1.5,
                              color: (Colors.black).withOpacity(0.5)),
                          const SizedBox(height: 14),
                          AppText(
                            text: pollMsg.question ?? '',
                            style: AppTextStyle.title,
                            textSize: 13,
                            color: AppColor.blackColor,
                          ),
                        ],
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
          )
        : const SizedBox.shrink();
  }

  Widget localAttachmentView(
          {required String attachment,
          String? thubnail,
          required String type,
          required Function onClose}) =>
      type == MessageType.image || type == MessageType.video
          ? ConstrainedBox(
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
            )
          : const SizedBox.shrink();

  /// Dialog View
  pollCreateDialog(BuildContext context,
      {required Function(Map<String, dynamic>) createPoll}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: Wrap(
              children: [
                Material(
                  type: MaterialType.transparency,
                  child: Align(
                    child: Container(
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
                            const SizedBox(height: 24.0),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 13.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const AppText(
                                    text: "Question",
                                    style: AppTextStyle.title,
                                    textSize: 11,
                                    color: AppColor.blackColor,
                                  ),
                                  const SizedBox(height: 7.0),
                                  pollInput(_chatMsgController.pollQuestion),
                                ],
                              ),
                            ),
                            Divider(
                                thickness: 1,
                                color: AppColor.blackColor.withOpacity(0.2)),
                            const SizedBox(height: 12.0),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 13.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const AppText(
                                    text: "Expiration",
                                    style: AppTextStyle.title,
                                    textSize: 11,
                                    color: AppColor.blackColor,
                                  ),
                                  const SizedBox(height: 12.0),
                                  GestureDetector(
                                    onTap: () async {
                                      AppDateTimePicker.pickDate(
                                          onChanged: (DateTime? value) {
                                        _chatMsgController.pollExpDate.value =
                                            value;
                                      });
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Icon(
                                            Icons.calendar_month_outlined,
                                            color: AppColor.appColor,
                                            size: 15.0),
                                        const SizedBox(width: 12.0),
                                        Obx(
                                          () => AppText(
                                            text: _chatMsgController
                                                        .pollExpDate.value ==
                                                    null
                                                ? 'DD-MM-YYYY'
                                                : DateFormat('dd-MM-yyyy')
                                                    .format(_chatMsgController
                                                        .pollExpDate.value!),
                                            textSize: 11,
                                            color: AppColor.blackColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 19.0),
                                  GestureDetector(
                                    onTap: () async {
                                      _chatMsgController.pollExpTime.value =
                                          await showTimePicker(
                                        context: context,
                                        initialTime: const TimeOfDay(
                                            hour: 7, minute: 15),
                                      );
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.watch_later,
                                            color: AppColor.appColor,
                                            size: 15.0),
                                        const SizedBox(width: 11.0),
                                        Obx(
                                          () => AppText(
                                              text: _chatMsgController
                                                          .pollExpTime.value ==
                                                      null
                                                  ? "00:00 AM"
                                                  : AppDateTime.time12hr(
                                                      timeOfDay:
                                                          _chatMsgController
                                                              .pollExpTime
                                                              .value),
                                              textSize: 11,
                                              color: AppColor.blackColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 13.0),
                            Divider(
                              thickness: 1,
                              color: AppColor.blackColor.withOpacity(0.2),
                            ),
                            const SizedBox(height: 13.0),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 13.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const AppText(
                                    text: "Options",
                                    style: AppTextStyle.title,
                                    textSize: 9,
                                    color: AppColor.blackColor,
                                  ),
                                  const SizedBox(height: 11.0),
                                  Obx(
                                    () => _chatMsgController.pollOptions.isEmpty
                                        ? const SizedBox.shrink()
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: List.generate(
                                              _chatMsgController
                                                  .pollOptions.length,
                                              (index) => Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: AppText(
                                                        text:
                                                            "${index + 1}. ${_chatMsgController.pollOptions[index]}",
                                                        style:
                                                            AppTextStyle.title,
                                                        textSize: 11,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            AppColor.blackColor,
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        _chatMsgController
                                                            .pollOptions
                                                            .removeAt(index);
                                                        _chatMsgController
                                                            .pollOptions
                                                            .refresh();
                                                      },
                                                      child: const Icon(
                                                        Icons.close,
                                                        size: 18,
                                                        color:
                                                            AppColor.appColor,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )),
                                  ),
                                  const SizedBox(height: 8),
                                  Obx(
                                    () => _chatMsgController
                                                .pollOptions.length >=
                                            5
                                        ? const SizedBox.shrink()
                                        : Row(
                                            children: [
                                              // const Icon(
                                              //     Icons.add_circle_rounded,
                                              //     color: AppColor.appColor),
                                              // const SizedBox(width: 8),
                                              Expanded(
                                                  child: pollInput(
                                                      _chatMsgController
                                                          .pollOption,
                                                      hint: "Add option")),
                                              const SizedBox(width: 8),
                                              GestureDetector(
                                                onTap: () {
                                                  if (_chatMsgController
                                                          .pollOptions.length <
                                                      5) {
                                                    if (_chatMsgController
                                                            .pollOption.text
                                                            .trim() ==
                                                        '') return;
                                                    _chatMsgController
                                                        .pollOptions
                                                        .add(_chatMsgController
                                                            .pollOption.text
                                                            .trim());
                                                    _chatMsgController
                                                        .pollOption
                                                        .clear();
                                                    _chatMsgController
                                                        .pollOptions
                                                        .refresh();
                                                  }
                                                },
                                                child: Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 12,
                                                        vertical: 5),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color: AppColor.appColor,
                                                    ),
                                                    child: const AppText(
                                                      text: "Add Option",
                                                      textSize: 10,
                                                      color: AppColor.white,
                                                    )),
                                              ),
                                            ],
                                          ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            GestureDetector(
                              onTap: () =>
                                  createPollAction(createPoll: createPoll),
                              child: const CommonButton(
                                color: AppColor.appColor,
                                radius: 17,
                                margin: EdgeInsets.only(right: 30, left: 30),
                                //height: 39,
                                text: "Create Poll",
                                textStyle: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  void createPollAction({required Function(Map<String, dynamic>) createPoll}) {
    if (_chatMsgController.pollQuestion.text.trim() == '') {
      AppToast.show("Please enter poll question");
      return;
    }
    if (_chatMsgController.pollExpDate.value == null) {
      AppToast.show("Please add expiration date");
      return;
    }
    if (_chatMsgController.pollExpTime.value == null) {
      AppToast.show("Please add expiration time");
      return;
    }

    ///
    Map<String, dynamic> inputData = {};
    // Poll question
    inputData.addAll({"question": _chatMsgController.pollQuestion.text.trim()});
    // Poll expiration date
    inputData.addAll({
      "exp_date":
          AppDateTime.defaultDateTime(_chatMsgController.pollExpDate.value!)
    });
    // Poll expiration time
    inputData.addAll({
      "exp_time":
          AppDateTime.time24hr(timeOfDay: _chatMsgController.pollExpTime.value!)
    });
    // Poll options
    if (_chatMsgController.pollOptions.isNotEmpty) {
      inputData.addAll({"options": _chatMsgController.pollOptions});
    }
    createPoll(inputData);
    _chatMsgController.pollOptions.clear();
    _chatMsgController.pollQuestion.clear();
    Get.back();
  }

  Widget pollInput(TextEditingController input, {String? hint, int? index}) {
    return TextField(
      controller: input,
      keyboardType: TextInputType.text,
      style: const TextStyle(fontSize: 12),
      decoration: InputDecoration(
        prefix: index == null ? null : Text("$index.  "),
        isDense: true,
        hintText: hint ?? "What's your poll question ?",
        contentPadding: EdgeInsets.zero,
        hintStyle:
            TextStyle(color: Colors.black.withOpacity(0.4), fontSize: 12),
        border: const OutlineInputBorder(borderSide: BorderSide.none),
      ),
    );
  }

  List fileTypes = ['pdf', 'docx', 'doc', 'txt', 'pptx', 'ppt', 'xlsx', 'xls'];

  List imageTypes = ["png", "jpeg", "jpg"];
}
