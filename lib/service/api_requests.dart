import 'dart:io';

import 'package:oninto_flutter/model/auth/user_info_model.dart';
import 'package:oninto_flutter/service/local/db_helper.dart';
import 'package:oninto_flutter/service/local/local_store_keys.dart';
import 'package:oninto_flutter/service/local/userInfo_globle.dart';
import 'package:oninto_flutter/utills/app_print.dart';
import 'package:oninto_flutter/utills/app_toast_loader.dart';

import 'apis.dart';
import 'base_api_call.dart';
import 'dio/shared/data_response.dart';

class ApiRequests {
  // Api requests...

  /// ---------Sign Up----------
  static Future<bool> signin(
      {required String phoneEmail, required String password}) async {
    AppLoader.show();
    // final fcmToken = await FirebaseMessaging.instance.getToken();
    var data = await BaseApiCall().postReq(AppApis.signin, data: {
      "phoneEmail": phoneEmail,
      "password": password,
      "deviceType": Platform.isIOS ? 1 : 1,
      "deviceToken": "device_token"
    });

    if (data != null) {
      DataResponse<UserInfoModel?> dataResponse = DataResponse.fromJson(
          data, (json) => UserInfoModel.fromJson(json as Map<String, dynamic>));
      //
      if (dataResponse.body != null) {
        AppPrint.all("Signin Req: ${dataResponse.body!.toJson()}");
        UserStoredInfo().userInfo = dataResponse.body;
        DbHelper.saveMap(
            key: SharedPrefKeys.userInfo, data: dataResponse.body!.toJson());
      }
      //
      AppLoader.hide();
      return true;
    }
    AppLoader.hide();
    return false;
  }

  /// ---------Sign Up----------
  // static Future<bool> signup({
  //   String? profileImage,
  //   required int role,
  //   required String firstName,
  //   required String lastName,
  //   required String email,
  //   required String countryCode,
  //   required String phoneNumber,
  //   required Function(OtpModel?) resp,
  // }) async {
  //   AppLoader.show();
  //   // final fcmToken = await FirebaseMessaging.instance.getToken();
  //   var data = await BaseApiCall().postFormReq(AppApis.signup,
  //       data: {
  //         "role": role,
  //         "firstname": firstName,
  //         "lastname": lastName,
  //         "country_code": countryCode,
  //         "phone": phoneNumber,
  //         "email": email,
  //         "device_token": "fcmToken",
  //         "device_type": Platform.isIOS ? 2 : 1,
  //       },
  //       attachments: profileImage == '' ? null : {"image": profileImage ?? ''});

  //   if (data != null) {
  //     // DataResponse<OtpModel?> dataResponse = DataResponse.fromJson(
  //     //     data, (json) => OtpModel.fromJson(json as Map<String, dynamic>));
  //     // AppLoader.hide();
  //     // AppToast.show("Please enter static otp '${dataResponse.body?.otp}'");
  //     // resp(dataResponse.body);
  //     return true;
  //   }
  //   AppLoader.hide();
  //   return false;
  // }
}

class AppCMS {
  String? id;
  String? title;
  String? description;
  String? role;

  AppCMS({this.id, this.title, this.description, this.role});
}
