import 'dart:async';
import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import '../routes/routes.dart';
import '../service/local/db_helper.dart';
import '../service/local/user_info_global.dart';
import 'notification_entity.dart';


class NotificationService {
  //Singleton pattern
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  /// Create a [AndroidNotificationChannel] for heads up notifications
  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.',
    // description
    importance: Importance.high,
  );

  final StreamController<String?> selectNotificationSubject =
      StreamController<String?>();

  //instance of FlutterLocalNotificationsPlugin
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    _configureSelectNotificationSubject();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      macOS: null,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        if (notificationResponse.notificationResponseType ==
            NotificationResponseType.selectedNotification) {
          selectNotificationSubject.add(notificationResponse.payload);
        }
      },
    );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);
    initFirebaseListeners();
  }

  Future<void> clear() async {
    if (GetPlatform.isIOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.cancelAll();
    }
  }

  void _configureSelectNotificationSubject() {
    selectNotificationSubject.stream.listen((String? payload) async {
      if (UserStoredInfo().userInfo?.token == null) {
        return;
      }
      NotificationEntity? entity =
          DbHelper().convertStringToNotificationEntity(payload);
      if (entity != null) {
        pushNextScreenFromForeground(entity);
      }
    });
  }

  Future? onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    if (UserStoredInfo().userInfo?.token == null) {
      return null;
    }
    NotificationEntity? entity =
        DbHelper().convertStringToNotificationEntity(payload);
    debugPrint(
        "notification onDidReceiveLocalNotification ${entity.toString()}");
    if (entity != null) {
      pushNextScreenFromForeground(entity);
    }
    return null;
  }

  void initFirebaseListeners() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint("onMessageOpenedApp 11");
      NotificationEntity notificationEntity =
          NotificationEntity.fromJson(message.data);
      pushNextScreenFromForeground(notificationEntity);
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        showNotifications(notificationEntity);
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      debugPrint("on Message  11 ${message.data}");
      NotificationEntity notificationEntity =
          NotificationEntity.fromJson(message.data);
      debugPrint(message.data.toString());
      notificationEntity.title = notificationEntity.title ?? "LinkingPal";
      notificationEntity.body = message.notification?.body;
      showNotifications(notificationEntity);
    });
  }

  Future? onSelectNotification(String? payload) {
    if (UserStoredInfo().userInfo?.token == null) {
      return null;
    }
    NotificationEntity? entity =
        DbHelper().convertStringToNotificationEntity(payload);
    if (entity != null) {
      pushNextScreenFromForeground(entity);
    }
    return null;
  }

  Future<void> showNotifications(NotificationEntity notificationEntity) async {
    if (Get.currentRoute == Routes.messageScreen) {
      return;
    }
    Random random = Random();
    int id = random.nextInt(900) + 10;
    await flutterLocalNotificationsPlugin.show(
      id,
      notificationEntity.title,
      notificationEntity.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: "@mipmap/ic_launcher",
          channelShowBadge: true,
          playSound: true,
          priority: Priority.high,
          importance: Importance.high,
          styleInformation:
              BigTextStyleInformation(notificationEntity.body ?? ""),
        ),
      ),
      payload: DbHelper()
          .convertNotificationEntityToString(notificationEntity),
    );
  }

  void pushNextScreenFromForeground(
      NotificationEntity notificationEntity) async {
    // Utils.showLoader();
/*    Tuple2<String, Object?>? tuple2 = await callApi(notificationEntity);
    // await Utils.hideLoader();
    Utils.printLog("current active screen ${Get.currentRoute}");

    if (tuple2 != null) {
      Get.toNamed(tuple2.item1, arguments: tuple2.item2);
    }*/
  }

/*  Future<Tuple2<String, Object?>?> callApi(NotificationEntity entity) async {
    if (DbHelper().getIsLoggedIn() != true) {
      Get.toNamed(Routes.LOGIN);
    } else {
      switch (entity.type) {

        default:
          return const Tuple2<String, Object?>(
              Routes.NOTIFICATION_VIEW, null);
      }
    }
  }*/
}
