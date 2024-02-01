import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
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

class ChatMsgController extends GetxController
    implements AppChatSocketListener {
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
  @override
  listenerGetUsers(List<ChatProductUser> data) {
    socketPrint("-----> ===> $data");
    users.value = data;
    allUsers.value = data;
    loadingData.value = false;
    // socketPrint("listenerGetUsers---> ${jsonEncode({"users": data})}");
  }

  // Listener Send Message----------
  @override
  listenerNewMessage(Message? data) {
    if (data != null) {
      messages.add(data);
      messages.refresh();
      if (data.senderId.toString() == activeUser.value?.id.toString()) {
        readUnread(data.senderId.toString());
      }
      clearMsgInput();
    }
    // socketPrint("listenerNewMessage---> $data");
  }

  // Listener Delete Message---------
  var deletedMessage = <int>[
    -1,
    -1
  ].obs; //left: is index and right is type (0 for one-one message and 1 for group message)
  @override
  listenerDeleteMessage() {
    if (deletedMessage[1] == 0 && deletedMessage[0] != -1) {
      messages.removeAt(deletedMessage[0]);
      messages.refresh();
    } else if (deletedMessage[1] == 1 && deletedMessage[0] != -1) {
      groupMessages.removeAt(deletedMessage[0]);
      groupMessages.refresh();
    }
    deletedMessage.value = [-1, -1];
    socketPrint(
        "listenerDeleteMessage---> In Controller ${activeGroup.value?.user?.email} - ${activeUser.value?.email}");
  }

  // Listener Chat Histories----------
  @override
  listenerChatHistories(List<Message> data) async {
    messages.value = data;
    await Future.delayed(const Duration(seconds: 1));
    loadingChatHistories.value = false;
  }

  // Clear chat----------
  @override
  listenerClearChat(bool data) {
    socketPrint("listenerClearChat---> $data");
    messages.clear();
    messages.refresh();
    AppToast.show("Messages are clear successfully");
  }

  // Report User----------
  var newReadedMsg = <String>[].obs;
  @override
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
  deleteMsg(String messageId, int index, {int? groupId}) {
    deletedMessage.value = [index, groupId == null ? 0 : 1];
    SocketEmits.deleteMessage(messageId, groupId: groupId);
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
    SocketEmits.clearChat(receiverId);
    socketPrint("emited for clear all chats...");
  }

  /// Report User -------
  readUnread(String reciverId) {
    SocketEmits.readUnread(reciverId);
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
  // Navigation -------------
  var activeGroup = Rx<ChatGroup?>(null);
  goToGroupChatRoom(ChatGroup? groupInfo) {
    groupMessages.clear();
    Get.toNamed(Routes.groupMessageScreen);
    // readUnread((reciverInfo.receiver?.id ?? '').toString());
    getGroupMessagesHistoriy((activeGroup.value?.id ?? '').toString());
  }

  /// Group Chat Listeners----------------
  var groupsList = <GroupConstant>[].obs;
  var groupMessages = <GroupMessage>[].obs;
  // Listener Group Send Message----------
  listenerGroupSendMessage(GroupMessage? data) {
    if (data != null) {
      groupMessages.add(data);
      groupMessages.refresh();
      clearMsgInput();
    }
  }

  // Listener Groups List----------
  listenerGroupList(List<GroupConstant> data) {
    if (data.isNotEmpty) {
      groupsList.value = data;
      groupsList.refresh();
    }
    loadingData.value = false;
  }

  // Listener Groups List----------
  listenerGroupChatHistory(List<GroupMessage> data) {
    if (data.isNotEmpty) {
      groupMessages.value = data;
      groupMessages.refresh();
    }
    loadingChatHistories.value = false;
  }

  //---------Group Emitters---------
  // Send message
  sendGroupMessage(
      {required String? groupId, required String productId}) async {
    socketPrint(
        "listenerDeleteMessage---> In Controller ${activeGroup.value?.productBaseInfo?.name} - ${activeUser.value?.email}");
    if (groupId != null) {
      if (newMessageType.value == MessageType.replay &&
          replayOnMessage.value != null) {
        String replayText = newMessageInput.text.trim();
        Map<String, dynamic> newReplayMsg = {};
        newReplayMsg
            .addAll({"replayon_msgid": replayOnMessage.value?.id ?? ''});
        newReplayMsg.addAll({"replayon_msg": replayOnMessage.value?.message});
        newReplayMsg
            .addAll({"replayon_datetime": replayOnMessage.value?.createdAt});
        newReplayMsg.addAll({"message": replayText});
        //
        newMessageInput.text = jsonEncode(newReplayMsg);
      }
      if (newMessageType.value == MessageType.text ||
          newMessageType.value == MessageType.poll ||
          (newMessageType.value == MessageType.replay &&
              replayOnMessage.value != null)) {
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

  // group list
  getGroupsList() {
    loadingData.value = true;
    SocketEmits.groupsList();
  }

  // Group Message List
  getGroupMessagesHistoriy(String groupId) {
    loadingChatHistories.value = true;
    SocketEmits.groupChatHistory(groupId: groupId);
  }

  ///======== POLL INPUT =======
  var pollQuestion = TextEditingController(text: '');
  var pollOption = TextEditingController(text: '');
  var pollExpTime = Rx<TimeOfDay?>(null);
  var pollExpDate = Rx<DateTime?>(null);
  var pollOptions = <String>[].obs;
  //
  var replayOnMessage = Rx<GroupMessage?>(null);
}

/*
  room id create with-> connected id, user1, user2, req from comming userid, reciverJoined/Not
*/
