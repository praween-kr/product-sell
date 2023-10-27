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
  storeUserInfo(UserInfoModel? uinfodata) {
    if (uinfodata != null) {
      userInfo = uinfodata;
      //
      if (GlobleController().initialized) {
        Get.find<GlobleController>().userInfo.value = uinfodata;
      } else {
        Get.put(GlobleController()).userInfo.value = uinfodata;
      }
    }
  }

  // Clear
  clearUserInfo() {
    userInfo = null;
    //
    if (GlobleController().initialized) {
      Get.find<GlobleController>().userInfo.value = null;
    } else {
      Get.put(GlobleController()).userInfo.value = null;
    }
  }
}

class GlobleController extends GetxController {
  var userInfo = Rx<UserInfoModel?>(null);
}
