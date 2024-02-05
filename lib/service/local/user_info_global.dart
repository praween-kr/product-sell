import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/model/auth/user_info_model.dart';
import 'package:oninto_flutter/utils/app_print.dart';

class UserStoredInfo {
  static final UserStoredInfo _instance = UserStoredInfo._internal();
  factory UserStoredInfo() {
    return _instance;
  }

  UserStoredInfo._internal();

  UserInfoModel? userInfo;

  final GlobalController controller = Get.find<GlobalController>();

  // Store
  storeUserInfo(UserInfoModel? userInfoData) {
    if (userInfoData != null) {
      userInfo = userInfoData;
      //
      if (GlobalController().initialized) {
        Get.find<GlobalController>().userInfo.value = userInfoData;
      } else {
        Get.put(GlobalController()).userInfo.value = userInfoData;
      }
    }
  }

  // Clear
  clearUserInfo() {
    userInfo = null;
    //
    if (GlobalController().initialized) {
      Get.find<GlobalController>().userInfo.value = null;
    } else {
      Get.put(GlobalController()).userInfo.value = null;
    }
  }
}

class GlobalController extends GetxController {
  var userInfo = Rx<UserInfoModel?>(null);
  //
  final connectionStatus = Rx<ConnectivityResult>(ConnectivityResult.none);
  final internet = false.obs;
  var connectivity = Rx<Connectivity>(Connectivity());
  var connectivitySubscription =
      Rx<StreamSubscription<ConnectivityResult>?>(null);
  //
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await connectivity.value.checkConnectivity();
    } on PlatformException catch (e) {
      AppPrint.all('Couldn\'t check connectivity status error: $e');
      return;
    }
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    AppPrint.info('Internet Status: $result');
    connectionStatus.value = result;
  }

  @override
  void onInit() {
    super.onInit();
    initConnectivity();
    connectivitySubscription.value = connectivity.value.onConnectivityChanged
        .listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    super.dispose();
    if (connectivitySubscription.value != null) {
      connectivitySubscription.value!.cancel();
    }
  }
}
