import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/Socket/app_socket.dart';
import 'package:oninto_flutter/Socket/model/chat_product_user_model.dart';
import 'package:oninto_flutter/Socket/socket_keys.dart';
import 'package:oninto_flutter/routes/routes.dart';
import 'package:oninto_flutter/service/local/userInfo_global.dart';
import 'package:oninto_flutter/utils/app_toast_loader.dart';

import '../model/message_model.dart';

class ChatMsgController extends GetxController {
  var messageController = 0.obs;

  ///--------------------------
  var users = <ChatProductUser>[].obs;
  var allUsers = <ChatProductUser>[].obs;
  var messages = <Message>[].obs;
  var loadingData = false.obs;
  var loadingChatHistories = false.obs;
  //
  var newMessageInput = TextEditingController(text: '');
  var newMessageAttachment = ''.obs;
  var newMessageType = MessageType.text.obs;
  var attachmentUploading = false.obs;

  //=======================================

  // Report
  var reportMsg = TextEditingController(text: '');
  var searchKey = TextEditingController(text: '');

  searching() {
    if (searchKey.text.trim() == '') {
      users.value = allUsers;
    } else {
      log("searchKey.text.trim().toLowerCase(): ${searchKey.text.trim().toLowerCase()}");
      // users.value = allUsers.where((user) {
      //   //-------
      //   ChatUserInfo receiver = (user.sender ?? []).isEmpty
      //       ? (user.userInfo ?? []).first
      //       : UserStoredInfo().userInfo?.id.toString() ==
      //               (user.sender ?? []).first.sId
      //           ? (user.userInfo ?? []).first
      //           : (user.sender ?? []).first;
      //   //-------
      //   return ("${receiver.firstname} ${receiver.lastname}")
      //       .toLowerCase()
      //       .contains(searchKey.text.trim().toLowerCase());
      // }).toList();
    }
    users.refresh();
  }

  // Emit Get Users ----------

  // Listener join chat room ----------
  listenerUserConnected(Map<String, dynamic> data) {
    // socketPrint("listenerUserConnected---> $data");
  }

  // Listener Get Users ----------
  listenerGetUsers(List<ChatProductUser> data) {
    socketPrint("-----> ===> $data");
    users.value = data;
    allUsers.value = data;
    loadingData.value = false;
    // socketPrint("listenerGetUsers---> ${jsonEncode({"users": data})}");
  }

  // Listener Send Message----------
  listenerNewMessage(Message? data) {
    if (UserStoredInfo().userInfo?.id.toString() ==
        data?.receiverId.toString()) {
      readUnread((data?.senderId ?? '').toString());
    }
    // socketPrint("Listener:---------> (send_message_listener) ===> $data");
    if (data != null) {
      messages.add(data);
      messages.refresh();
    }
    // socketPrint("listenerNewMessage---> $data");
  }

  // Listener Delete Message---------
  listenerDeleteMessage() {
    socketPrint("listenerDeleteMessage---> In Controller");
  }

  // Listener Chat Histories----------
  listenerChatHistories(List<Message> data) async {
    messages.value = data;
    await Future.delayed(const Duration(seconds: 5));
    loadingChatHistories.value = false;
    socketPrint("listenerChatHistories---> $data");
  }

  // Clear chat----------
  listenerClearChat(bool data) {
    socketPrint("listenerClearChat---> $data");
    messages.clear();
    messages.refresh();
    AppToast.show("Messages are clear successfully");
  }

  // Report User----------
  listenerReportUser(bool data) {
    AppLoader.hide();

    Get.back();
    Get.back();
    reportMsg.clear();

    socketPrint("listenerReportUser---> successfully reported!");
  }

  // Report User----------
  var newReadedMsg = <String>[].obs;
  listenerReadUnread(String sender, String reciver) {
    if (UserStoredInfo().userInfo?.id.toString() == reciver) {
      for (int i = messages.length - 1; i >= 0; i--) {
        if (messages[i].readStatus == 1) {
          break;
        } else {
          newReadedMsg.add(sender);
        }
      }
      newReadedMsg.refresh();
    }
    socketPrint("listenerReadUnread---> $sender, $reciver");
    // messages.refresh();
  }

  //----------------------------------------------------------------------------
  // Navigation -------------
  var activeUser = Rx<ChatProductUser?>(null);
  goToChatRoom(ChatProductUser reciverInfo) {
    activeUser.value = reciverInfo;
    messages.clear();
    Get.toNamed(Routes.messageScreen);
    // readUnread((reciverInfo.receiver?.id ?? '').toString());
    SocketEmits.getChatHistories((reciverInfo.receiver?.id ?? '').toString());

    loadingChatHistories.value = true;
  }

  /// Load users --------
  getUsers() {
    loadingData.value = true;
    SocketEmits.getUsers();
  }

  /// Send new message --------
  sendNewMessage(String? receiverId) async {
    if (receiverId != null) {
      if (newMessageType.value == MessageType.text) {
        if (newMessageInput.text != '') {
          socketPrint("Send First Message--> $receiverId");
          SocketEmits.sendMessage(
              receiverId: receiverId,
              msg: newMessageInput.text,
              type: newMessageType.value,
              productId: '1');
        }
      } else if (newMessageAttachment.value != '') {
        // await ApiRequests.messageAttachmentUpload(
        //   attachment: newMessageAttachment.value,
        //   loading: (loading) {
        //     attachmentUploading.value = loading;
        //   },
        //   successFile: (attachmentFile) {
        //     if ((attachmentFile ?? '') != '') {
        //       SocketEmits.sendMessage(
        //         receiverId: receiverId,
        //         msg: attachmentFile!,
        //         type: newMessageType.value,
        //       );
        //     }
        //   },
        // );
      }
      // readUnread(receiverId);
      clearMsgInput();
    }
  }

  // Delete Message Emit
  deleteMsg(String messageId) {
    SocketEmits.deleteMessage(messageId);
  }

  clearMsgInput() {
    newMessageInput.clear();
    newMessageType.value = MessageType.text;
    newMessageAttachment.value = '';
  }

  /// Clear chats -------
  clearAllChats(String receiverId) {
    //---
    SocketEmits.clearChat(receiverId);
    socketPrint("emited for clear all chats...");
  }

  /// Report User -------
  reportUser(String reciverId) {
    if (reportMsg.text.trim() == '') {
      AppToast.show("Please enter your reason");
    } else {
      AppLoader.show();
      socketPrint("Report: ${reportMsg.text}");
      SocketEmits.reportUser(msg: reportMsg.text.trim(), reportTo: reciverId);
      //--

      socketPrint("emited for report user...");
    }
  }

  /// Report User -------
  readUnread(String reciverId) {
    SocketEmits.readUnread(reciverId);
    //--
    socketPrint("emited for read all messages...");
  }

  @override
  void onSuccessFile(String file, String fileType) {
    log("fileTypefileType: $fileType");
    if (fileType == 'document') {
      newMessageType.value = MessageType.file;
    } else {
      newMessageType.value = MessageType.image;
    }
    newMessageAttachment.value = file;
  }

  @override
  void onInit() {
    super.onInit();
    getUsers();
  }
}


/*
  room id create with-> connected id, user1, user2, req from comming userid, reciverJoined/Not
*/