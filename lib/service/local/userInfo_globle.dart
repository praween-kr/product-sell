import 'package:oninto_flutter/model/auth/user_info_model.dart';

class UserStoredInfo {
  static final UserStoredInfo _instance = UserStoredInfo._internal();
  factory UserStoredInfo() {
    return _instance;
  }

  UserStoredInfo._internal();

  UserInfoModel? userInfo;
  // TrackingModel? startTracking;
}
