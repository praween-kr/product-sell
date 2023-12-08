import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/Socket/app_socket.dart';
import 'package:oninto_flutter/Socket/socket_keys.dart';
import 'package:oninto_flutter/service/local/userInfo_globle.dart';
import 'package:oninto_flutter/utills/app_toast_loader.dart';

import '../model/chat_user_model.dart';
import '../model/message_model.dart';

class ChatMsgController extends GetxController {
  var users = <ChatUser>[].obs;
  var allUsers = <ChatUser>[].obs;
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
      users.value = allUsers.where((user) {
        //-------
        ChatUserInfo receiver = (user.sender ?? []).isEmpty
            ? (user.userInfo ?? []).first
            : UserStoredInfo().userInfo?.id.toString() ==
                    (user.sender ?? []).first.sId
                ? (user.userInfo ?? []).first
                : (user.sender ?? []).first;
        //-------
        return ("${receiver.firstname} ${receiver.lastname}")
            .toLowerCase()
            .contains(searchKey.text.trim().toLowerCase());
      }).toList();
    }
    users.refresh();
  }

  // Emit Get Users ----------

  // Listener join chat room ----------
  listenerUserConnected(Map<String, dynamic> data) {
    // socketPrint("listenerUserConnected---> $data");
  }

  // Listener Get Users ----------
  listenerGetUsers(List<ChatUser> data) {
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
      // messages.add(data);
      // messages.refresh();
      if (UserStoredInfo().userInfo?.id.toString() ==
          data.senderId.toString()) {
        SocketEmits.getChatHistories((data.receiverId ?? '').toString());
      } else {
        SocketEmits.getChatHistories((data.senderId ?? '').toString());
      }
    }
    // socketPrint("listenerNewMessage---> $data");
  }

  // Listener Chat Histories----------
  listenerChatHistories(List<Message> data) {
    messages.value = data;
    loadingChatHistories.value = false;
    // socketPrint("listenerChatHistories---> $data");
  }

  // Clear chat----------
  listenerClearChat(bool data) {
    socketPrint("listenerClearChat---> $data");
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
      // Socket Debug: listenerReadUnread---> 65290ca7cb057231ad36edb9, 652909f1cb057231ad36ed54
      // logedin-> 65290ca7cb057231ad36edb9
    }
    socketPrint("listenerReadUnread---> $sender, $reciver");
    // messages.refresh();
  }

  //----------------------------------------------------------------------------
  // Navigation -------------
  goToChatRoom(ChatUserInfo reciverInfo) {
    readUnread(reciverInfo.sId ?? '');

    SocketEmits.getChatHistories(reciverInfo.sId ?? '');
    // Get.toNamed(Routes.chatScreen, arguments: {'reciver_info': reciverInfo});
    loadingChatHistories.value = true;
  }

  @override
  void onInit() {
    super.onInit();
    SocketEmits.connectUser();
    // SocketEmits.sendMessage(
    //     receiverId: "64f9c7095c8ed265e5c100b3", msg: "First name...");
    // SocketEmits.getChatHistories(
    //     UserStoredInfo().userInfo?.role == UserRole.worker
    //         ? "64f9c7095c8ed265e5c100b3"
    //         : "64f9b5575c8ed265e5c10005");
    getUsers();
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

  clearMsgInput() {
    newMessageInput.clear();
    newMessageType.value = MessageType.text;
    newMessageAttachment.value = '';
  }

  /// Clear chats -------
  clearAllChats() {
    //---
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
}


/*
  room id create with-> connected id, user1, user2, req from comming userid, reciverJoined/Not
*/