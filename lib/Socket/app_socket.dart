import 'dart:collection';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_controller/home/home_controller.dart';
import 'package:oninto_flutter/model/product/product_details_model.dart';
import 'package:oninto_flutter/service/local/user_info_global.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import 'controller/chat_msg_controller.dart';
import 'model/add_bids_histories.dart';
import 'model/group/group_message_model.dart';
import 'model/group/groups_list_model.dart';
import 'model/one-to-one/chat_product_user_model.dart';
import 'model/one-to-one/message_model.dart';
import 'socket_keys.dart';

class AppSocket {
  static final AppSocket _singleton = AppSocket._internal();

  AppSocket._internal();

  factory AppSocket() => _singleton;

  static io.Socket? _socketIO;
  static io.Socket? socket() {
    if (_socketIO == null) {
      reconnect();
    }
    return _socketIO;
  }

  bool isConnected = false, isUserConnected = false;

  void init() {
    socketPrint("Socket===> *********************");
    _socketIO = io.io(
        SocketKeys.socketUrl,
        io.OptionBuilder()
            .setTransports(['websocket'])
            .enableAutoConnect()
            .setExtraHeaders({'forceNew': true})
            .build());

    //---
    _socketIO?.onConnect((data) {
      isConnected = true;
      socketPrint("Socket===> Connected Success... ${socket()?.connected}");
      SocketEmits.connectUser();
      //
      // SocketEmits.connectUser();
      _initListener();
    });
    _socketIO?.onConnectError((data) {
      isConnected = false;
      socketPrint("Error----> ${data.toString()}");
    });
    _socketIO?.onError((data) {
      socketPrint("Error----> ${data.toString()}");
    });
  }

  static disconnect() {
    if (_socketIO != null) {
      SocketEmits.disConnectUser();
      _socketIO?.disconnect();
      _socketIO?.close();
      _socketIO?.dispose();
      _socketIO?.onDisconnect((data) {
        socketPrint("Socket disconnected...");
      });
      _socketIO = null;
    } else {
      socketPrint("Socket already disconnected...");
    }
  }

  static reconnect() {
    if (_socketIO == null) {
      AppSocket().init();
    } else {
      _socketIO
        ?..disconnect()
        ..connect();
    }
  }

  _initListener() {
    // Connect user---------------
    _socketIO?.on(SocketKeys.listenerConnectUser, (data) {
      socketPrint(
          "Listener:---------> (${SocketKeys.listenerConnectUser}), ${jsonEncode(data)}");
    });

    // Disconnect user---------------
    _socketIO?.on(SocketKeys.listenerDisconnectUser, (data) {
      socketPrint(
          "Listener:---------> (${SocketKeys.listenerDisconnectUser}), ${jsonEncode(data)}");
    });

    // Get Users---------------
    _socketIO?.on(SocketKeys.listenerGetUsers, (data) {
      //
      socketPrint(
          "Listener:---------> (${SocketKeys.listenerGetUsers}), ${jsonEncode({
            "users": data['getdata']
          })}");

      ChatMsgController cmc = Get.find();

      ChatProductUsersModel usersModel = ChatProductUsersModel.fromJson(data);
      cmc.listenerGetUsers(usersModel.getdata ?? []);
    });

    // Send new message---------------
    _socketIO?.on(SocketKeys.listenerSendMessage, (data) {
      //
      ChatMsgController cmc = Get.find();
      socketPrint(
          "Listener:---------> (${SocketKeys.listenerSendMessage}), ${jsonEncode(data)}");
      Message newMsg = Message.fromJson(data);
      cmc.listenerNewMessage(newMsg);
    });

    // Delete message---------------
    _socketIO?.on(SocketKeys.listenerDeleteMsg, (data) {
      //
      ChatMsgController cmc = Get.find();
      socketPrint(
          "Listener:---------> (${SocketKeys.listenerDeleteMsg}), ${jsonEncode(data)}");

      cmc.listenerDeleteMessage();
    });

    // Histories of chat---------------
    _socketIO?.on(SocketKeys.listenerChatHistories, (data) {
      ChatMsgController cmc = Get.find();
      MessagesModel messagesModel = MessagesModel.fromJson(data);
      socketPrint(
          "Listener:---------> (${SocketKeys.listenerChatHistories}), ${jsonEncode({
            "msgs": data
          })}");
      socketPrint("listenerChatHistories---> $data");
      cmc.listenerChatHistories(messagesModel.messages ?? []);
    });

    // Clear chat---------------
    _socketIO?.on(SocketKeys.listenerClearChat, (data) {
      //
      ChatMsgController cmc = Get.find();
      socketPrint(
          "Listener:---------> (${SocketKeys.listenerClearChat}), ${jsonEncode({
            "msgs": data
          })}"); //

      cmc.listenerClearChat(true);
    });

    // Read/Unread messages ---------------
    _socketIO?.on(SocketKeys.listenerReadUnread, (data) {
      //
      socketPrint(
          "Listener:---------> (${SocketKeys.listenerReadUnread}), ${jsonEncode({
            "msgs": data
          })}");
      ChatMsgController cmc;
      if (ChatMsgController().initialized) {
        cmc = Get.find<ChatMsgController>();
      } else {
        cmc = Get.put(ChatMsgController());
      }

      cmc.listenerReadUnread(
          data['senderId'].toString(), data['receiverId'].toString());
    });

    ///----- Biding Listener ------
    _socketIO?.on(SocketKeys.listenerAddBid, (data) {
      //
      socketPrint(
          "Listener:---------> (${SocketKeys.listenerAddBid}), ${jsonEncode({
            "bid": data
          })}");

      HomeCatProductController controller;
      if (HomeCatProductController().initialized) {
        controller = Get.find<HomeCatProductController>();
      } else {
        controller = Get.put(HomeCatProductController());
      }
      AddBidsHistory? model = AddBidsHistory.fromJson(data);
      controller.addBidListener(model);
    });
    _socketIO?.on(SocketKeys.listenerLastBid, (data) {
      //
      socketPrint(
          "Listener:---------> (${SocketKeys.listenerLastBid}), ${jsonEncode({
            "bid": data
          })}");
      HomeCatProductController controller;
      if (HomeCatProductController().initialized) {
        controller = Get.find<HomeCatProductController>();
      } else {
        controller = Get.put(HomeCatProductController());
      }
      AddBidsHistory? model = AddBidsHistory.fromJson(data);
      controller.getBidHistoriesListener(model);
    });
    _socketIO?.on(SocketKeys.listenerBidOver, (data) {
      //
      socketPrint(
          "Listener:---------> (${SocketKeys.listenerBidOver}), ${jsonEncode({
            "bid": data
          })}");
      HomeCatProductController controller;
      if (HomeCatProductController().initialized) {
        controller = Get.find<HomeCatProductController>();
      } else {
        controller = Get.put(HomeCatProductController());
      }

      controller.bidOverListener(false);
    });

    ///----- Share Product Details -----
    _socketIO?.on(SocketKeys.listenerGetShareProductData, (data) async {
      HomeCatProductController con = Get.find<HomeCatProductController>();
      socketPrint(
          "Listener:---------> (${SocketKeys.listenerGetShareProductData}), ${jsonEncode(data)}");
      ProductDetailsData productData = ProductDetailsData.fromJson(data);
      con.listenerShareProductDetails(productData);
    });

    ///----- Purchage Share Product -----
    _socketIO?.on(SocketKeys.listenerPurchaseShare, (data) {
      HomeCatProductController con = Get.find<HomeCatProductController>();
      socketPrint(
          "Listener:---------> (${SocketKeys.listenerPurchaseShare}), ${jsonEncode(data)}");
      con.listenerPurchageProductShare(data['shareId']);
    });

    ///=========== Group Chat Listener ==============
    // Send new group message---------------
    _socketIO?.on(SocketKeys.listenerSendMessageGroup, (data) {
      ChatMsgController cmc = Get.find();
      socketPrint(
          "Listener:---------> (${SocketKeys.listenerSendMessageGroup}), ${jsonEncode(data)}");
      GroupMessage newMsg = GroupMessage.fromJson(data);
      cmc.listenerGroupSendMessage(newMsg);
    });
    // group list---------------
    _socketIO?.on(SocketKeys.listenerGroupUsersList, (data) {
      ChatMsgController cmc = Get.find();
      socketPrint(
          "Listener:---------> (${SocketKeys.listenerGroupUsersList}), ${jsonEncode(data)}");
      GroupListModel groupList = GroupListModel.fromJson(data);
      cmc.listenerGroupList(groupList.list ?? []);
    });
    // group chat history---------------
    _socketIO?.on(SocketKeys.listenerGroupChatHistories, (data) {
      ChatMsgController cmc = Get.find();
      socketPrint(
          "Listener:---------> (${SocketKeys.listenerGroupChatHistories}), ${jsonEncode(data)}");
      GroupMessageListModel messages = GroupMessageListModel.fromJson(data);
      cmc.listenerGroupChatHistory(messages.list ?? []);
    });
  }
}

class SocketEmits {
  // Connect User---------------
  static connectUser() {
    Map<String, dynamic> req = HashMap();
    req['userId'] = UserStoredInfo().userInfo?.id ?? '';
    socketPrint(
        "Emit:---------> connectUser-(${SocketKeys.emitConnectUser}), $req",
        blue: true);
    AppSocket.socket()?.emit(SocketKeys.emitConnectUser, req);
  }

  // Disconnect User---------------
  static disConnectUser() {
    Map<String, dynamic> req = HashMap();
    req['senderId'] = UserStoredInfo().userInfo?.id ?? '';
    socketPrint(
        "Emit:---------> connectUser-(${SocketKeys.emitDisconnectUser}), $req",
        blue: true);
    AppSocket.socket()?.emit(SocketKeys.emitDisconnectUser, req);
  }

  // Get Users---------------
  static getUsers() {
    Map<String, dynamic> req = HashMap();
    req['senderId'] = UserStoredInfo().userInfo?.id ?? '';
    socketPrint("Emit:---------> getUsers-(${SocketKeys.emitGetUsers}), $req",
        blue: true);
    AppSocket.socket()?.emit(SocketKeys.emitGetUsers, req);
  }

  // Send new message ---------------
  static sendMessage(
      {required String receiverId,
      String? type,
      required String msg,
      String? thumbnail,
      required String productId}) {
    socketPrint("dkfldsjf");
    Map<String, dynamic> req = HashMap();
    req['senderId'] = UserStoredInfo().userInfo?.id ?? '';
    req['receiverId'] = receiverId;
    req['messageType'] = type ?? MessageType.text;
    req['productId'] = productId;
    req['message'] = msg;
    req['thumbnail'] = thumbnail ?? '';
    socketPrint(
        "Emit:---------> sendMessage-(${SocketKeys.emitSendMessage}), $req",
        blue: true);
    AppSocket.socket()?.emit(SocketKeys.emitSendMessage, req);
  }

  // Get Chat Histories---------------
  static getChatHistories(String receiverId) {
    Map<String, dynamic> req = HashMap();
    req['senderId'] = receiverId;
    req['receiverId'] = UserStoredInfo().userInfo?.id ?? '';
    socketPrint(
        "Emit:---------> getChatHistories-(${SocketKeys.emitChatHistories}), $req",
        blue: true);
    AppSocket.socket()?.emit(SocketKeys.emitChatHistories, req);
  }

  // Clear Chat ---------------
  static clearChat(String receiverId) {
    Map<String, dynamic> req = HashMap();
    req['senderId'] = UserStoredInfo().userInfo?.id ?? '';
    req['receiverId'] = receiverId;
    socketPrint(
        "Emit:---------> emitClearChat-(${SocketKeys.emitClearChat}), $req",
        blue: true);
    AppSocket.socket()?.emit(SocketKeys.emitClearChat, req);
  }

  // Delete Message Chat ---------------
  static deleteMessage(String messageId, {int? groupId}) {
    Map<String, dynamic> req = HashMap();
    req['senderId'] = groupId ?? UserStoredInfo().userInfo?.id ?? '';
    req['messageId'] = messageId;
    socketPrint(
        "Emit:---------> emitClearChat-(${SocketKeys.emitDeleteMsg}), $req",
        blue: true);
    AppSocket.socket()?.emit(SocketKeys.emitDeleteMsg, req);
  }

  // Read/Unread messages ---------------
  static readUnread(String receiverId) {
    Map<String, dynamic> req = HashMap();
    req['senderId'] = UserStoredInfo().userInfo?.id ?? '';
    req['receiverId'] = receiverId;
    socketPrint(
        "Emit:---------> emitReadUnread-(${SocketKeys.emitReadUnread}) - $req",
        blue: true);
    AppSocket.socket()?.emit(SocketKeys.emitReadUnread, req);
  }

  ///======== Biding Emit =========
  static addBid({required String productId, required double bidPrice}) {
    Map<String, dynamic> req = HashMap();
    req['userId'] = UserStoredInfo().userInfo?.id ?? '';
    req['productId'] = productId;
    req['bidPrice'] = bidPrice;
    socketPrint(
        "Emit:---------> emitReadUnread-(${SocketKeys.emitAddBid}) - $req",
        blue: true);
    AppSocket.socket()?.emit(SocketKeys.emitAddBid, req);
  }

  static getLastBidAndHistory({required String productId}) {
    Map<String, dynamic> req = HashMap();
    req['userId'] = UserStoredInfo().userInfo?.id ?? '';
    req['productId'] = productId;
    socketPrint(
        "Emit:---------> emitReadUnread-(${SocketKeys.emitLastBid}) - $req",
        blue: true);
    AppSocket.socket()?.emit(SocketKeys.emitLastBid, req);
  }

  static bidOver({required String productId}) {
    Map<String, dynamic> req = HashMap();
    req['userId'] = UserStoredInfo().userInfo?.id ?? '';
    req['productId'] = productId;
    socketPrint(
        "Emit:---------> emitReadUnread-(${SocketKeys.emitBidOver}) - $req",
        blue: true);
    AppSocket.socket()?.emit(SocketKeys.emitBidOver, req);
  }

  /// ==============Share Product Details Emiter=======
  static getShareProductData({required String productId}) {
    Map<String, dynamic> req = HashMap();
    req['userId'] = UserStoredInfo().userInfo?.id ?? '';
    req['id'] = productId;
    socketPrint(
        "Emit:---------> emitReadUnread-(${SocketKeys.emiterGetShareProductData}) - $req",
        blue: true);
    AppSocket.socket()?.emit(SocketKeys.emiterGetShareProductData, req);
  }

  static purchaseProductShare(
      {required String productId,
      required int shares,
      required double perSharePrice}) {
    Map<String, dynamic> req = HashMap();
    req['userId'] = UserStoredInfo().userInfo?.id ?? '';
    req['shareId'] = productId;
    req['totalSharePurchase'] = shares;
    req['perSharePrice'] = perSharePrice;
    socketPrint(
        "Emit:---------> emitReadUnread-(${SocketKeys.emiterPurchaseShare}) - $req",
        blue: true);
    AppSocket.socket()?.emit(SocketKeys.emiterPurchaseShare, req);
  }

  /// ///=========== Group Chat Emitter ==============
  // Send new group message ---------------
  static sendGroupMessage(
      {required String? groupId,
      String? type,
      required String msg, //groupId,senderId,message,messageType
      String? thumbnail,
      required String productId}) {
    socketPrint("dkfldsjf");
    Map<String, dynamic> req = HashMap();
    req['senderId'] = UserStoredInfo().userInfo?.id ?? '';
    req['groupId'] = groupId;
    req['messageType'] = type ?? MessageType.text;
    req['productId'] = productId;
    req['message'] = msg;
    req['thumbnail'] = thumbnail ?? '';
    socketPrint(
        "Emit:---------> sendMessage-(${SocketKeys.emitSendMessage}), $req",
        blue: true);
    AppSocket.socket()?.emit(SocketKeys.emiterSendMessageGroup, req);
  }

  // Send new group message ---------------
  static groupsList() {
    Map<String, dynamic> req = HashMap();
    req['senderId'] = UserStoredInfo().userInfo?.id ?? '';
    socketPrint(
        "Emit:---------> sendMessage-(${SocketKeys.emiterGroupUsersList}), $req",
        blue: true);
    AppSocket.socket()?.emit(SocketKeys.emiterGroupUsersList, req);
  }

  // Histories of Group message ---------------
  static groupChatHistory({required String groupId}) {
    Map<String, dynamic> req = HashMap();
    req['senderId'] = UserStoredInfo().userInfo?.id ?? '';
    req['groupId'] = groupId;
    socketPrint(
        "Emit:---------> sendMessage-(${SocketKeys.emiterGroupChatHistories}), $req",
        blue: true);
    AppSocket.socket()?.emit(SocketKeys.emiterGroupChatHistories, req);
  }
}

//------------------------------------------------------------------------------------------
socketPrint(dynamic data, {bool blue = false}) {
  if (blue) {
    debugPrint("Socket Debug: $data");
  } else {
    log("Socket Debug: $data");
    // debugPrint("Socket Debug: $data");
  }
}

class SocketChatListener {}
