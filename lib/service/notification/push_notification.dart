// import 'dart:convert';
// import 'dart:developer';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart';
// import 'package:jobbie/map/controller/home_map_controller.dart';
// import 'package:jobbie/model/settings/notifications_model.dart';
// import 'package:jobbie/routes/routes_files.dart';
// import 'package:jobbie/service/local/db_helper.dart';
// import 'package:jobbie/service/local/local_store_keys.dart';

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   // String type =
//   // (jsonDecode(message.data['bodyData'])['notitype'] ?? '').toString();
//   // print("FirebaseMessaging.getInitialMessage ${message.data['bodyData']}*");
//   await DbHelper.writeData(
//       SharedPrefKeys.notificationType, message.data['bodyData']);
// }

// AndroidNotificationChannel? channel;

// FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
// late FirebaseMessaging messaging;

// final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// void notificationTapBackground(NotificationResponse notificationResponse) {
//   /// Navigate to page handle here
//   String? data = notificationResponse.payload;
//   if (data != null) {
//     print("Navigate: Navigate to page handle here:::: ${jsonDecode(data)}");
//     // NotificationNavigation.to(
//     //     jsonDecode(jsonDecode(data)['bodyData'])['notitype'].toString());
//     if (jsonDecode(data)['jobId'] != null) {
//       NotificationNavigation.to('1', jobId: jsonDecode(data)['jobId']);
//     } else {
//       NotificationNavigation.to('5');
//     }
//   }
// }

// class PushNotification {
//   void initMain() async {
//     // ///--------------------------

//     messaging = FirebaseMessaging.instance;

//     await messaging.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );

//     //If subscribe based sent notification then use this token
//     final fcmToken = await messaging.getToken();
//     print("Navigate: fcm---> $fcmToken");

//     //If subscribe based on topic then use this
//     await messaging.subscribeToTopic('flutter_notification');

//     // Set the background messaging handler early on, as a named top-level function
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

//     if (!kIsWeb) {
//       channel = const AndroidNotificationChannel(
//           'flutter_notification', // id
//           'flutter_notification_title', // title
//           importance: Importance.high,
//           enableLights: true,
//           enableVibration: true,
//           showBadge: true,
//           playSound: true);

//       flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//       const android = AndroidInitializationSettings('@mipmap/ic_launcher');
//       final iOS = DarwinInitializationSettings(
//           requestSoundPermission: true,
//           requestBadgePermission: true,
//           requestAlertPermission: true,
//           onDidReceiveLocalNotification: onDidReceiveLocalNotification);
//       final initSettings = InitializationSettings(android: android, iOS: iOS);

//       await flutterLocalNotificationsPlugin!.initialize(initSettings,
//           onDidReceiveNotificationResponse: notificationTapBackground,
//           onDidReceiveBackgroundNotificationResponse:
//               notificationTapBackground);

//       await messaging.setForegroundNotificationPresentationOptions(
//           alert: true, badge: true, sound: true);
//     }
//   }

//   Future<void> onDidReceiveLocalNotification(
//       int id, String? title, String? body, String? payload) async {
//     // Handle the received local notification
//     print("Navigate: Hello:::: ${{
//       "id": id,
//       "title": title,
//       "body": body,
//       "payload": payload,
//     }}");
//   }

//   void initNotification() {
//     log("Navigate: Nptification----> init run...");
//     initMain();
//     setupInteractedMessage();

//     FirebaseMessaging.instance
//         .getInitialMessage()
//         .then((RemoteMessage? message) async {
//       RemoteNotification? notification = message?.notification!;

//       print(notification != null ? notification.title : '');
//     });

//     FirebaseMessaging.onMessage.listen((message) async {
//       print("Navigate: message.notification: ${message.notification?.title}");
//       RemoteNotification? notification = message.notification;
//       AndroidNotification? android = message.notification?.android;
//       // AppleNotification? apple =
//       // print("message.notification: ${message.notification?.apple}");

//       if (notification != null && !kIsWeb) {
//         //&& android != null &&
//         String action = jsonEncode(message.data);

//         await DbHelper.writeData(
//             SharedPrefKeys.notificationType, message.data['bodyData']);
//         // print(
//         //     "action::: $action === ${notification.title} ${jsonDecode(jsonDecode(action))}");

//         flutterLocalNotificationsPlugin!.show(
//           notification.hashCode,
//           notification.title,
//           notification.body,
//           NotificationDetails(
//             android: AndroidNotificationDetails(
//               channel!.id,
//               channel!.name,
//               priority: Priority.high,
//               importance: Importance.max,
//               channelDescription: channel!.description,
//               setAsGroupSummary: true,
//               styleInformation: const DefaultStyleInformation(true, true),
//               // largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
//               channelShowBadge: true,
//               autoCancel: true,
//               playSound: true,
//               icon: '@mipmap/ic_launcher',
//             ),
//             iOS: const DarwinNotificationDetails(
//               presentAlert: true,
//               presentBadge: true,
//               presentSound: true,
//               badgeNumber: 0,
//             ),
//           ),
//           payload: action,
//         );
//       }
//     });

//     FirebaseMessaging.onMessageOpenedApp
//         .listen((message) => _handleMessage(message.data));
//   }

//   Future<dynamic> onSelectNotification(payload) async {
//     Map<String, dynamic> action = jsonDecode(payload);
//     _handleMessage(action);
//   }

//   Future<void> setupInteractedMessage() async {
//     await FirebaseMessaging.instance.getInitialMessage().then((value) =>
//         _handleMessage(value != null ? value.data : <String, dynamic>{}));
//   }

//   void _handleMessage(Map<String, dynamic> data) {
//     // Navigation kill/background app

//     log("Navigate: dddd----> 888");
//     // NotificationNavigation.to('5');
//     // if (data['bodyData'] != null) {
//     //   NotificationNavigation.to(
//     //       jsonDecode(data['bodyData'])['notitype'].toString());
//     // }
//   }
// }

// class NotificationNavigation {
//   static void to(String type,
//       {NotificationModel? notification, String? jobId}) async {
//     log("Navigate: dddd----> $type");
//     //---- Controllers ----

//     //---------------------

//     await DbHelper.writeData(SharedPrefKeys.notificationType, "");
//     switch (type) {
//       case '1':
//         Get.toNamed(Routes.jobDetailScreen,
//             arguments: <String, String>{'job_id': jobId ?? ''});
//       default:
//         HomeController homeController = HomeController().initialized
//             ? Get.find<HomeController>()
//             : Get.put(HomeController());
//         homeController.getNotifications();
//         Get.toNamed(Routes.notificationScreen);
//     }
//   }
// }
