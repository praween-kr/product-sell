import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/Socket/model/chat_product_user_model.dart';
import 'package:oninto_flutter/service/local/userInfo_globle.dart';
import 'package:oninto_flutter/utills/app_toast_loader.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'controller/chat_msg_controller.dart';
import 'model/message_model.dart';
import 'socket_keys.dart';

class AppSocket {
  static final AppSocket _singleton = AppSocket._internal();

  AppSocket._internal();

  factory AppSocket() => _singleton;

  static IO.Socket? _socketIO;
  static IO.Socket? socket() {
    if (_socketIO == null) {
      reconnect();
    }
    return _socketIO;
  }

  bool isConnected = false, isUserConnected = false;

  void init() {
    socketPrint("Socket===> *********************");
    _socketIO = IO.io(
        SocketKeys.socketUrl,
        IO.OptionBuilder()
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
      _socketIO?.disconnect();
      _socketIO?.close();
      _socketIO?.dispose();
      _socketIO?.onDisconnect((data) {
        socketPrint("Socket disconnected...");
      });
      _socketIO = null;
    } else {
      socketPrint("Socket alrady disconnected...");
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
      //
      socketPrint(
          "Listener:---------> (${SocketKeys.listenerConnectUser}), ${jsonEncode(data)}");

      // if (!data.toString().contains("longitude")) {
      //   ChatMsgController cmc = Get.find();
      //   cmc.listenerUserConnected(data as Map<String, dynamic>);
      // }
    });
    // Get Users---------------
    _socketIO?.on(SocketKeys.listenerGetUsers, (data) {
      //
      ChatMsgController cmc = Get.find();

      List<ChatProductUser> list = [];
      List<Map<String, dynamic>> ulist =
          data['getdata'] as List<Map<String, dynamic>>;
      for (var element in ulist) {
        list.add(ChatProductUser.fromJson(element));
      }
      socketPrint(
          "Listener:---------> (${list.length}) (${SocketKeys.listenerGetUsers}), ${jsonEncode({
            "users": data['getdata']
          })}");
      // ChatUsersModel users = ChatUsersModel.fromJson({"users": data});
      cmc.listenerGetUsers(list);
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
    // Histories of chat---------------
    _socketIO?.on(SocketKeys.listenerChatHistories, (data) {
      //
      ChatMsgController cmc = Get.find();
      socketPrint(
          "Listener:---------> (${SocketKeys.listenerChatHistories}), ${jsonEncode({
            "msgs": data
          })}");
      // MessagesModel messages = MessagesModel.fromJson({"msgs": data});
      // cmc.listenerChatHistories(messages.mssages ?? []);
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
    // Report User---------------
    _socketIO?.on(SocketKeys.listenerReportUser, (data) {
      //
      ChatMsgController cmc = Get.find();
      socketPrint(
          "Listener:---------> (${SocketKeys.listenerReportUser}), ${jsonEncode({
            "msgs": data
          })}");
      AppToast.show(data?['success_message'] ?? '');

      cmc.listenerReportUser(true);
    });
    // Read/Unread messages ---------------
    _socketIO?.on(SocketKeys.listenerReadUnread, (data) {
      //
      ChatMsgController cmc;
      if (ChatMsgController().initialized) {
        cmc = Get.find<ChatMsgController>();
      } else {
        cmc = Get.put(ChatMsgController());
      }

      socketPrint(
          "Listener:---------> (${SocketKeys.listenerReadUnread}), ${jsonEncode({
            "msgs": data
          })}");
      cmc.listenerReadUnread(data['sender_id'], data['receiver_id']);
    });
  }
}

class SocketEmits {
  // Join to Chat Room---------------
  static connectUser() {
    Map<String, dynamic> req = HashMap();
    req['userId'] = UserStoredInfo().userInfo?.id ?? '';
    socketPrint(
        "Emit:---------> connectUser-(${SocketKeys.emitConnectUser}), $req",
        blue: true);
    AppSocket.socket()?.emit(SocketKeys.emitConnectUser, req);
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
      required String productId}) {
    socketPrint("dkfldsjf");
    Map<String, dynamic> req = HashMap();
    req['senderId'] = UserStoredInfo().userInfo?.id ?? '';
    req['receiverId'] = receiverId;
    req['message_type'] = type ?? MessageType.text;
    req['productId'] = productId;
    req['message'] = msg;
    socketPrint(
        "Emit:---------> sendMessage-(${SocketKeys.emitSendMessage}), $req",
        blue: true);
    AppSocket.socket()?.emit(SocketKeys.emitSendMessage, req);
  }

  // Get Chat Histories---------------
  static getChatHistories(String receiverId) {
    Map<String, dynamic> req = HashMap();
    req['sender_id'] = UserStoredInfo().userInfo?.id ?? '';
    req['receiver_id'] = receiverId;
    socketPrint(
        "Emit:---------> getChatHistories-(${SocketKeys.emitChatHistories}), $req",
        blue: true);
    AppSocket.socket()?.emit(SocketKeys.emitChatHistories, req);
  }

  // Clear Chat ---------------
  static clearChat(String receiverId) {
    Map<String, dynamic> req = HashMap();
    req['sender_id'] = UserStoredInfo().userInfo?.id ?? '';
    req['receiver_id'] = receiverId;
    socketPrint(
        "Emit:---------> emitClearChat-(${SocketKeys.emitClearChat}), $req",
        blue: true);
    AppSocket.socket()?.emit(SocketKeys.emitClearChat, req);
  }

  // Report User ---------------
  static reportUser({required String msg, required reportTo}) {
    Map<String, dynamic> req = HashMap();
    req['reportBy'] = UserStoredInfo().userInfo?.id ?? '';
    req['reportTo'] = reportTo;
    req['message'] = msg;
    socketPrint(
        "Emit:---------> emitReportUser-(${SocketKeys.emitReportUser}), $req",
        blue: true);
    AppSocket.socket()?.emit(SocketKeys.emitReportUser, req);
  }

  // Read/Unread messages ---------------
  static readUnread(String receiverId) {
    Map<String, dynamic> req = HashMap();
    req['sender_id'] = UserStoredInfo().userInfo?.id ?? '';
    req['receiver_id'] = receiverId;
    socketPrint("Emit:---------> emitReadUnread-(${SocketKeys.emitReadUnread})",
        blue: true);
    AppSocket.socket()?.emit(SocketKeys.emitReadUnread, req);
  }
}

socketPrint(dynamic data, {bool blue = false}) {
  if (blue) {
    print("Socket Debug: $data");
  } else {
    // log("Socket Debug: $data");
    debugPrint("Socket Debug: $data");
  }
}
