import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/Socket/app_socket.dart';
import 'package:oninto_flutter/Socket/model/group/groups_list_model.dart';
import 'package:oninto_flutter/Socket/model/one-to-one/chat_product_user_model.dart';
import 'package:oninto_flutter/Socket/socket_keys.dart';
import 'package:oninto_flutter/routes/routes.dart';
import 'package:oninto_flutter/service/api_requests.dart';
import 'package:oninto_flutter/service/local/user_info_global.dart';
import 'package:oninto_flutter/utils/app_toast_loader.dart';

import '../model/group/group_message_model.dart';
import '../model/one-to-one/message_model.dart';

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
  var newMessageInputThumb = TextEditingController(text: '');
  var newMessageAttachment = ''.obs;
  var newMessageAttachmentThumbnail = ''.obs;
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
    socketPrint("Listener:---------> (send_message_listener) ===> $data");
    if (data != null) {
      messages.add(data);
      messages.refresh();
      socketPrint(
          "Listener:---------> (send_message_listener) ===> ${data.message}-- ${messages.length}");
      socketPrint(
          "Listener:---------> ${data.senderId.toString()} == ${activeUser.value?.id.toString()} -> ${data.senderId.toString() == activeUser.value?.id.toString()}");
      if (data.senderId.toString() == activeUser.value?.id.toString()) {
        readUnread(data.senderId.toString());
      }
      clearMsgInput();
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
    await Future.delayed(const Duration(seconds: 1));
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
          messages[i].readStatus = 1;
        }
      }
      messages.refresh();
    }
    socketPrint("listenerReadUnread---> $sender, $reciver");
    // messages.refresh();
  }

  // Navigation -------------
  var activeUser = Rx<Receiver?>(null);
  var activeProduct = Rx<Product?>(null);
  goToChatRoom(Receiver? reciverInfo) {
    messages.clear();
    Get.toNamed(Routes.messageScreen);
    // readUnread((reciverInfo.receiver?.id ?? '').toString());
    SocketEmits.getChatHistories((reciverInfo?.id ?? '').toString());

    loadingChatHistories.value = true;
  }

  /// Load users --------
  getUsers() {
    loadingData.value = true;
    SocketEmits.getUsers();
  }

  /// Send new message --------
  sendNewMessage(String? receiverId, String productId) async {
    socketPrint("Send First Message--> $receiverId");
    if (receiverId != null) {
      if (newMessageType.value == MessageType.text) {
        if (newMessageInput.text.trim() != '') {
          SocketEmits.sendMessage(
              receiverId: receiverId,
              msg: newMessageInput.text.trim(),
              type: newMessageType.value,
              productId: productId);
        }
      } else if (newMessageAttachment.value != '') {
        socketPrint("thum: ${newMessageInputThumb.text}");
        await _uploadAttachment(() {
          if (newMessageAttachment.value != '') {
            SocketEmits.sendMessage(
                receiverId: receiverId,
                msg: newMessageInput.text.trim(),
                type: newMessageType.value,
                productId: productId,
                thumbnail: newMessageInputThumb.text);
          }
        });
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
    newMessageAttachmentThumbnail.value = '';
    newMessageInputThumb.clear();
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

  /// API
  _uploadAttachment(Function success) async {
    await ApiRequests.uploadAttachment(
        attachment: newMessageAttachment.value,
        type: newMessageType.value,
        thumbnail: newMessageAttachmentThumbnail.value,
        respdata: (type, url, thubUrl) {
          newMessageInput.text = url;
          newMessageInputThumb.text = thubUrl;
          socketPrint("type: $type, url: $url, thubUrl: $thubUrl");
          success();
        },
        loading: (loading) {
          attachmentUploading.value = loading;
        });
  }

  @override
  void onInit() {
    super.onInit();
    getGroupsList();
    getUsers();
  }

  ///=========================================================================
  /// Group Chat Listeners----------------
  var groupsList = <GroupConstant>[].obs;
  var groupMessages = <GroupMessage>[].obs;
  // Listener Group Send Message----------
  listenerGroupSendMessage(GroupMessage? data) {
    socketPrint("Listener:---------> (send_message_listener) ===> $data");
    if (data != null) {
      groupMessages.add(data);
      groupMessages.refresh();
      socketPrint(
          "Listener:---------> (send_message_listener) ===> ${data.message}-- ${messages.length}");
      socketPrint(
          "Listener:---------> ${data.senderId.toString()} == ${activeUser.value?.id.toString()} -> ${data.senderId.toString() == activeUser.value?.id.toString()}");
      clearMsgInput();
    }
  }

  // socketPrint("listenerNewMessage---> $data");
  // Listener Groups List----------
  listenerGroupList(List<GroupConstant> data) {
    socketPrint("Listener:---------> (listenerGroupUsersList) ===> $data");
    if (data.isNotEmpty) {
      groupsList.value = data;
      groupsList.refresh();
      socketPrint(
          "Listener:---------> (listenerGroupUsersList) ===> $data-- ${messages.length}");
    }
    loadingData.value = true;
  }

  // Listener Groups List----------
  listenerGroupChatHistory(List<GroupMessage> data) {
    socketPrint("Listener:---------> (listenerGroupUsersList) ===> $data");
    if (data.isNotEmpty) {
      groupMessages.value = data;
      groupMessages.refresh();
      socketPrint(
          "Listener:---------> (listenerGroupUsersList) ===> $data-- ${messages.length}");
    }
    loadingData.value = true;
  }

  //---------Group Emitters---------
  sendGroupMessage(
      {required String? groupId, required String productId}) async {
    SocketEmits.sendGroupMessage(
        groupId: groupId,
        msg: newMessageInput.text.trim(),
        type: newMessageType.value,
        productId: productId);
    //
    if (groupId != null) {
      if (newMessageType.value == MessageType.text) {
        if (newMessageInput.text.trim() != '') {
          SocketEmits.sendGroupMessage(
              groupId: groupId,
              msg: newMessageInput.text.trim(),
              type: newMessageType.value,
              productId: productId);
        }
      } else if (newMessageAttachment.value != '') {
        socketPrint("thum: ${newMessageInputThumb.text}");
        await _uploadAttachment(() {
          if (newMessageAttachment.value != '') {
            SocketEmits.sendGroupMessage(
                groupId: groupId,
                msg: newMessageInput.text.trim(),
                type: newMessageType.value,
                productId: productId,
                thumbnail: newMessageInputThumb.text);
          }
        });
      }
      // readUnread(receiverId);
      clearMsgInput();
    }
  }

  getGroupsList() {
    loadingData.value = true;
    SocketEmits.groupsList();
  }
}

/*
  room id create with-> connected id, user1, user2, req from comming userid, reciverJoined/Not
*/
