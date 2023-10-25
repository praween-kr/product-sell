import 'dart:convert';

import 'package:get_storage/get_storage.dart';

class DbHelper {
  static GetStorage box = GetStorage();
  static const JsonDecoder _decoder = JsonDecoder();
  static const JsonEncoder _encoder = JsonEncoder.withIndent('  ');

  static writeData(String key, dynamic value) async {
    await box.write(key, value);
  }

  static readData(String key) {
    return box.read(key);
  }

  static deleteData(String key) async {
    await box.remove(key);
  }

  static eraseData() async {
    await box.erase();
  }

  //===================
  /// Save Data Map
  static saveMap(
      {required String key, required Map<String, dynamic> data}) async {
    await writeData(key, jsonEncode(data));
  }

  /// Get Map Data
  static Map<String, dynamic>? getMap(String key) {
    String? data = readData(key);
    return data == null || data == '' ? null : jsonDecode(data);
  }
}

/*class KeysDbHelper {
  static String isLogin = "isLogin";
  static String id = "id";
  static String name = "name";
  static String image = "image";
  static String email = "email";
  static String password = "password";
  static String phoneNo = "phoneNo";
  static String age = "age";
  static String gender = "gender";
  static String occupation = "occupation";
  static String idProof = "idProof";
  static String location = "location";
  static String forgotPasswordHash = "forgotPasswordHash";
  static String latitude = "latitude";
  static String longitude = "longitude";
  static String role = "role";
  static String status = "status";
  static String verifyOtp = "verifyOtp";
  static String otpCode = "otpCode";
  static String isNotification = "isNotification";
  static String isVerified = "isVerified";
  static String deviceType = "deviceType";
  static String deviceToken = "deviceToken";
  static String loginTime = "loginTime";
  static String createdAt = "createdAt";
  static String updatedAt = "updatedAt";
  static String token = "token";
}*/
