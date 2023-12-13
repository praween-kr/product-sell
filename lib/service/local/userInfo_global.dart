import 'package:get/get.dart';
import 'package:oninto_flutter/model/auth/user_info_model.dart';

class UserStoredInfo {
  static final UserStoredInfo _instance = UserStoredInfo._internal();
  factory UserStoredInfo() {
    return _instance;
  }

  UserStoredInfo._internal();

  UserInfoModel? userInfo;

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
}
