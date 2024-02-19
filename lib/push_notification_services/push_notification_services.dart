import 'dart:convert';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../views/bid_screen/notification_model.dart';

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
  if (dataJson != null) {
    debugPrint(
        "Navigate: Navigate to page handle here:::: ${jsonDecode(dataJson)}");
    // NotificationNavigation.to(
    //     jsonDecode(jsonDecode(dataJson)['bodyData'])['notitype'].toString());

    //---
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

    debugPrint("Navigate: Navigate to page handle here:::: $data");
  }
}

class MsgSender {
  String? sender;
  String? reaciver;
  String? name;
  MsgSender({this.sender, this.reaciver, this.name});
}

class NotificationNavigation {
  static void to(
    String type, {
    NotificationModel? notification,
    String? jobId,
    MsgSender? msgSender,
  }) async {
    log("Navigate: dddd----> $type");
    //---- Controllers ----

    //---------------------

    // await DbHelper.writeData(SharedPrefKeys.notificationType, "");
    switch (type) {
      case '1':
      //
      default:
      //
    }
  }
}

///-------------------------


// import 'dart:async';
// import 'dart:math';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart';
// import '../routes/routes.dart';
// import '../service/local/db_helper.dart';
// import '../service/local/user_info_global.dart';
// import 'notification_entity.dart';


// class NotificationService {
//   //Singleton pattern
//   static final NotificationService _notificationService =
//       NotificationService._internal();

//   factory NotificationService() {
//     return _notificationService;
//   }

//   NotificationService._internal();

//   /// Create a [AndroidNotificationChannel] for heads up notifications
//   AndroidNotificationChannel channel = const AndroidNotificationChannel(
//     'high_importance_channel', // id
//     'High Importance Notifications', // title
//     description: 'This channel is used for important notifications.',
//     // description
//     importance: Importance.high,
//   );

//   final StreamController<String?> selectNotificationSubject =
//       StreamController<String?>();

//   //instance of FlutterLocalNotificationsPlugin
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   Future<void> init() async {
//     _configureSelectNotificationSubject();
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//     DarwinInitializationSettings initializationSettingsDarwin =
//         DarwinInitializationSettings(
//       requestSoundPermission: true,
//       requestBadgePermission: true,
//       requestAlertPermission: true,
//       onDidReceiveLocalNotification: onDidReceiveLocalNotification,
//     );

//     InitializationSettings initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsDarwin,
//       macOS: null,
//     );

//     await flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse:
//           (NotificationResponse notificationResponse) {
//         if (notificationResponse.notificationResponseType ==
//             NotificationResponseType.selectedNotification) {
//           selectNotificationSubject.add(notificationResponse.payload);
//         }
//       },
//     );
//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(channel);

//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             IOSFlutterLocalNotificationsPlugin>()
//         ?.requestPermissions(alert: true, badge: true, sound: true);
//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//             alert: true, badge: true, sound: true);
//     initFirebaseListeners();
//   }

//   Future<void> clear() async {
//     if (GetPlatform.isIOS) {
//       await flutterLocalNotificationsPlugin
//           .resolvePlatformSpecificImplementation<
//               IOSFlutterLocalNotificationsPlugin>()
//           ?.cancelAll();
//     }
//   }

//   void _configureSelectNotificationSubject() {
//     selectNotificationSubject.stream.listen((String? payload) async {
//       if (UserStoredInfo().userInfo?.token == null) {
//         return;
//       }
//       NotificationEntity? entity =
//           DbHelper().convertStringToNotificationEntity(payload);
//       if (entity != null) {
//         pushNextScreenFromForeground(entity);
//       }
//     });
//   }

//   Future? onDidReceiveLocalNotification(
//       int id, String? title, String? body, String? payload) {
//     if (UserStoredInfo().userInfo?.token == null) {
//       return null;
//     }
//     NotificationEntity? entity =
//         DbHelper().convertStringToNotificationEntity(payload);
//     debugPrint(
//         "notification onDidReceiveLocalNotification ${entity.toString()}");
//     if (entity != null) {
//       pushNextScreenFromForeground(entity);
//     }
//     return null;
//   }

//   void initFirebaseListeners() {
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       debugPrint("onMessageOpenedApp 11");
//       NotificationEntity notificationEntity =
//           NotificationEntity.fromJson(message.data);
//       pushNextScreenFromForeground(notificationEntity);
//       RemoteNotification? notification = message.notification;
//       AndroidNotification? android = message.notification?.android;
//       if (notification != null && android != null && !kIsWeb) {
//         showNotifications(notificationEntity);
//       }
//     });

//     FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
//       debugPrint("on Message  11 ${message.data}");
//       NotificationEntity notificationEntity =
//           NotificationEntity.fromJson(message.data);
//       debugPrint(message.data.toString());
//       notificationEntity.title = notificationEntity.title ?? "LinkingPal";
//       notificationEntity.body = message.notification?.body;
//       showNotifications(notificationEntity);
//     });
//   }

//   Future? onSelectNotification(String? payload) {
//     if (UserStoredInfo().userInfo?.token == null) {
//       return null;
//     }
//     NotificationEntity? entity =
//         DbHelper().convertStringToNotificationEntity(payload);
//     if (entity != null) {
//       pushNextScreenFromForeground(entity);
//     }
//     return null;
//   }

//   Future<void> showNotifications(NotificationEntity notificationEntity) async {
//     if (Get.currentRoute == Routes.messageScreen) {
//       return;
//     }
//     Random random = Random();
//     int id = random.nextInt(900) + 10;
//     await flutterLocalNotificationsPlugin.show(
//       id,
//       notificationEntity.title,
//       notificationEntity.body,
//       NotificationDetails(
//         android: AndroidNotificationDetails(
//           channel.id,
//           channel.name,
//           channelDescription: channel.description,
//           icon: "@mipmap/ic_launcher",
//           channelShowBadge: true,
//           playSound: true,
//           priority: Priority.high,
//           importance: Importance.high,
//           styleInformation:
//               BigTextStyleInformation(notificationEntity.body ?? ""),
//         ),
//       ),
//       payload: DbHelper()
//           .convertNotificationEntityToString(notificationEntity),
//     );
//   }

//   void pushNextScreenFromForeground(
//       NotificationEntity notificationEntity) async {
//     // Utils.showLoader();
// /*    Tuple2<String, Object?>? tuple2 = await callApi(notificationEntity);
//     // await Utils.hideLoader();
//     Utils.printLog("current active screen ${Get.currentRoute}");

//     if (tuple2 != null) {
//       Get.toNamed(tuple2.item1, arguments: tuple2.item2);
//     }*/
//   }

// /*  Future<Tuple2<String, Object?>?> callApi(NotificationEntity entity) async {
//     if (DbHelper().getIsLoggedIn() != true) {
//       Get.toNamed(Routes.LOGIN);
//     } else {
//       switch (entity.type) {

//         default:
//           return const Tuple2<String, Object?>(
//               Routes.NOTIFICATION_VIEW, null);
//       }
//     }
//   }*/
// }
