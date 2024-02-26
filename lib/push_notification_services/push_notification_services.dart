import 'dart:convert';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/model/product/product_model.dart';

import '../Socket/controller/chat_msg_controller.dart';
import '../Socket/model/one-to-one/chat_product_user_model.dart';
import '../common_controller/product/my_product_controller.dart';
import '../routes/routes.dart';
import '../views/home/product/product_details_navigation.dart';
import 'notification_payload_model.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // String type =
  // (jsonDecode(message.data['bodyData'])['notitype'] ?? '').toString();
  // print("FirebaseMessaging.getInitialMessage ${message.data['bodyData']}*");
  // await DbHelper.writeData(
  //     SharedPrefKeys.notificationType, message.data['bodyData']);
}

AndroidNotificationChannel? channel;

FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
late FirebaseMessaging messaging;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void notificationTapBackground(NotificationResponse notificationResponse) {
  /// Navigate to page handle here
  String? dataJson = notificationResponse.payload;
  // if (dataJson != null) {
  log("Navigate: Navigate to page handle here:::: $dataJson");
  //   // NotificationNavigation.to(
  //   //     jsonDecode(jsonDecode(dataJson)['bodyData'])['notitype'].toString());
  //   PushNotificationData payload =
  //       PushNotificationData.fromJson(jsonDecode(dataJson));

  //   //---
  // }
  if (dataJson != null) {
    PushNotificationModel payload =
        PushNotificationModel.fromJson(jsonDecode(dataJson));
    navigation(payload);
  }
}

class PushNotification {
  void initMain() async {
    messaging = FirebaseMessaging.instance;
    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    //If subscribe based sent notification then use this token
    final fcmToken = await messaging.getToken();
    print("Navigate: fcm---> $fcmToken");

    //If subscribe based on topic then use this
    await messaging.subscribeToTopic('flutter_notification');

    // Set the background messaging handler early on, as a named top-level function
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
          'flutter_notification', // id
          'flutter_notification_title', // title
          importance: Importance.high,
          enableLights: true,
          enableVibration: true,
          showBadge: true,
          playSound: true);

      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      const android = AndroidInitializationSettings('@mipmap/ic_launcher');
      final iOS = DarwinInitializationSettings(
          requestSoundPermission: true,
          requestBadgePermission: true,
          requestAlertPermission: true,
          onDidReceiveLocalNotification: onDidReceiveLocalNotification);
      final initSettings = InitializationSettings(android: android, iOS: iOS);

      await flutterLocalNotificationsPlugin!.initialize(initSettings,
          onDidReceiveNotificationResponse: notificationTapBackground,
          onDidReceiveBackgroundNotificationResponse:
              notificationTapBackground);

      await messaging.setForegroundNotificationPresentationOptions(
          alert: true, badge: true, sound: true);
    }
  }

  Future<void> onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // Handle the received local notification
    debugPrint("Navigate: Hello:::: ${{
      "id": id,
      "title": title,
      "body": body,
      "payload": payload,
    }}");
  }

  void initNotification() {
    initMain();
    // setupInteractedMessage();
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) async {
      RemoteNotification? notification = message?.notification!;

      debugPrint(notification != null ? notification.title : '');
    });

    FirebaseMessaging.onMessage.listen((message) async {
      debugPrint("Navigate: message.notification: data-${message.data}");
      RemoteNotification? notification = message.notification;
      // AndroidNotification? android = message.notification?.android;
      // AppleNotification? apple =
      // print("message.notification: ${message.notification?.apple}");
      //
      String? reciverIdChatRoom = '';
      // DbHelper.readData(SharedPrefKeys.userInChatRoomGetOrSaveReciverId);

      if ((reciverIdChatRoom != message.data['sender_id']) &&
          notification != null &&
          !kIsWeb) {
        String action = jsonEncode(message.data);
        if (GetPlatform.isIOS) {
          return;
        }

        flutterLocalNotificationsPlugin!.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel!.id,
              channel!.name,
              priority: Priority.high,
              importance: Importance.max,
              channelDescription: channel!.description,
              setAsGroupSummary: true,
              styleInformation: const DefaultStyleInformation(true, true),
              // largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
              channelShowBadge: true,
              autoCancel: true,
              playSound: true,
              icon: '@mipmap/ic_launcher',
            ),
            iOS: const DarwinNotificationDetails(
              presentAlert: true,
              presentBadge: true,
              presentSound: true,
              badgeNumber: 0,
            ),
          ),
          payload: action,
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp
        .listen((message) => _handleMessage(message.data));
  }

  Future<dynamic> onSelectNotification(payload) async {
    Map<String, dynamic> action = jsonDecode(payload);
    _handleMessage(action);
  }

  Future<void> setupInteractedMessage() async {
    await FirebaseMessaging.instance.getInitialMessage().then((value) =>
        _handleMessage(value != null ? value.data : <String, dynamic>{}));
  }

  void _handleMessage(Map<String, dynamic> data) {
    // Navigation kill/background app
    log("Navigate: Navigate to page handle here::|:: ${jsonEncode(data)}");
    PushNotificationModel payload = PushNotificationModel.fromJson(data);
    navigation(payload);
  }
}

/// Notification Navigation Method
navigation(PushNotificationModel data) {
  // Chat
  NotificationNavigation().to(data);
}

class MsgSender {
  String? sender;
  String? reaciver;
  String? name;
  MsgSender({this.sender, this.reaciver, this.name});
}

class NotificationNavigation extends PushNavigationMethods {
  void to(
    PushNotificationModel notification, {
    String? jobId,
    MsgSender? msgSender,
  }) async {
    String type = (notification.notificationType ?? '').toString();
    log("Navigate: dddd----> $type");
    //---- Controllers ----

    //---------------------

    // await DbHelper.writeData(SharedPrefKeys.notificationType, "");
    switch (type) {
      case '1': // one to one chat
        oneToOneChatRoom(notification);
      case '2': // group chat
      //
      case '4': // group chat
        publicProductDetails(
            productId: int.parse(notification.productId ?? '0'),
            productType: notification.type);
      case '5': // product approuved by admin
        myProductsScreen();
      default:
      //
    }
  }
}

class PushNavigationMethods {
  // One To One Chat
  oneToOneChatRoom(PushNotificationModel data) {
    ChatMsgController con;
    if (ChatMsgController().initialized) {
      con = Get.find<ChatMsgController>();
    } else {
      con = Get.put(ChatMsgController());
    }
    con.activeUser.value = Receiver(
        id: data.data?.senderId,
        image: data.senderDetail?.image,
        firstName: data.senderDetail?.firstName,
        lastName: data.senderDetail?.lastName);
    con.goToChatRoom(Receiver(id: data.data?.senderId));
  }

  // Approved Product
  myProductsScreen() {
    MyProductController con;
    if (MyProductController().initialized) {
      con = Get.find<MyProductController>();
    } else {
      con = Get.put(MyProductController());
    }
    con.tabController.value = 4;
    con.getMyProducts();
    Get.toNamed(Routes.productScreen);
  }

  // Product Details screen
  publicProductDetails({required int? productId, required int? productType}) {
    gotoProductDetaiesScreen(
        ProductModel(id: productId ?? 0, type: productType ?? 0));
  }
}
