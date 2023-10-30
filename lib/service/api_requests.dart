import 'dart:io';

import 'package:oninto_flutter/model/auth/cms_model.dart';
import 'package:oninto_flutter/model/auth/user_info_model.dart';
import 'package:oninto_flutter/model/g_place_model.dart';
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
    var bodyData = {
      "phoneEmail": phoneEmail,
      "password": password,
      "deviceType": Platform.isIOS ? 1 : 1,
      "deviceToken": "device_token"
    };
    AppPrint.info("Login Req: $bodyData");
    var data = await BaseApiCall().postReq(AppApis.signin, data: bodyData);

    if (data != null) {
      DataResponse<UserInfoModel?> dataResponse = DataResponse.fromJson(
          data, (json) => UserInfoModel.fromJson(json as Map<String, dynamic>));
      //
      if (dataResponse.body != null) {
        AppPrint.all("Signin Req: ${dataResponse.body!.toJson()}");
        UserStoredInfo().storeUserInfo(dataResponse.body);
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

// firstName:User
// lastName:One
// email:user1@g.com
// countryCode:91
// phone:9696969690
// password:123456
// confirmPassword:123456
// deviceToken:device_token
// deviceType:1
  static Future<bool> signup(
      {required String firstName,
      required String lastName,
      required String email,
      required String countryCode,
      required String phone}) async {
    AppLoader.show();
    // final fcmToken = await FirebaseMessaging.instance.getToken();
    var data = await BaseApiCall().postReq(AppApis.signUp, data: {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "countryCode": countryCode,
      "phone": phone,
      "deviceType": Platform.isIOS ? 1 : 1,
      "deviceToken": "device_token",
      "password": "123456", // temprory
      "confirmPassword": "123456"
    });

    if (data != null) {
      DataResponse<UserInfoModel?> dataResponse = DataResponse.fromJson(
          data, (json) => UserInfoModel.fromJson(json as Map<String, dynamic>));
      //
      if (dataResponse.body != null) {
        AppPrint.all("Signin Req: ${dataResponse.body!.toJson()}");
        UserStoredInfo().storeUserInfo(dataResponse.body);

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

  /// -------Verification--------
  static Future<bool> verifyWithOtp(
      {required String email, required String otp}) async {
    AppLoader.show();
    var data = await BaseApiCall()
        .postReq(AppApis.otpVerify, data: {"email": email, "otp": otp});
    if (data != null) {
      DataResponse<UserInfoModel?> dataResponse = DataResponse.fromJson(
          data, (json) => UserInfoModel.fromJson(json as Map<String, dynamic>));
      //
      if (dataResponse.body != null) {
        AppPrint.all("Verify Resp: ${dataResponse.body!.toJson()}");
        UserStoredInfo().storeUserInfo(dataResponse.body);
        DbHelper.saveMap(
            key: SharedPrefKeys.userInfo, data: dataResponse.body!.toJson());
      }
      AppLoader.hide();
      return true;
    }
    AppLoader.hide();
    return false;
  }

  /// -------Resend Otp--------
  static Future<bool> resendOtp({required String email}) async {
    AppLoader.show();
    var data =
        await BaseApiCall().postReq(AppApis.resendOtp, data: {"email": email});
    if (data != null) {
      AppLoader.hide();
      return true;
    }
    AppLoader.hide();
    return false;
  }

  /// -------Logout--------
  static Future<bool> logout() async {
    AppLoader.show();
    var data = await BaseApiCall().postReq(AppApis.logout, data: {});
    if (data != null) {
      AppLoader.hide();
      return true;
    }
    AppLoader.hide();
    return false;
  }

  /// --------Update Profile---------
  static Future<bool> updateProfile(
      {required String firstName,
      required String lastName,
      required String email,
      required String countryCode,
      required String phone}) async {
    AppLoader.show();
    var data = await BaseApiCall().putReq(AppApis.updateProfile, data: {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "countryCode": countryCode,
      "phone": phone
    });

    if (data != null) {
      Map<String, dynamic> newdata = data['body'] as Map<String, dynamic>;
      newdata.addAll({"token": UserStoredInfo().userInfo!.token ?? ''});

      AppPrint.all("Update Profile Req: $newdata");
      if (newdata.isNotEmpty) {
        UserInfoModel userInfoModel = UserInfoModel.fromJson(newdata);
        UserStoredInfo().storeUserInfo(userInfoModel);
        DbHelper.saveMap(
            key: SharedPrefKeys.userInfo, data: userInfoModel.toJson());
      }

      AppLoader.hide();
      return true;
    }
    AppLoader.hide();
    return false;
  }

  /// -------Change Password--------
  static Future<bool> changePassword(
      {required String oldPassword,
      required String newPassword,
      required String confirmPassword}) async {
    AppLoader.show();
    var data = await BaseApiCall().postReq(AppApis.changePassword, data: {
      "oldPassword": oldPassword,
      "newPassword": newPassword,
      "confirmPassword": confirmPassword
    });
    if (data != null) {
      AppLoader.hide();
      return true;
    }
    AppLoader.hide();
    return false;
  }

  /// -------Get CMS--------
  static Future<bool> getCMS(
      {required String type,
      required Function(CmsModel?) data,
      required Function(bool) loading}) async {
    loading(true);
    var resp =
        await BaseApiCall().getReq(AppApis.getCMS, id: type, showToast: false);
    if (resp != null) {
      DataResponse<CmsModel> dataResponse = DataResponse.fromJson(
          resp, (json) => CmsModel.fromJson(json as Map<String, dynamic>));
      data(dataResponse.body);
      loading(false);
      return false;
    }
    loading(false);
    return false;
  }

  static gPlaceSearch(String query,
      {required Function(List<PlaceResults>) addresses,
      required Function(bool) loading}) async {
    loading(true);
    String googleKey = "AIzaSyDGxkyWAlm8QrBJDT22ph0Y0CtxOFDHUL0";
    String api =
        "https://maps.googleapis.com/maps/api/place/textsearch/json?query=$query&key=$googleKey";
    var resp =
        await BaseApiCall().getReq(api, showToast: false, hideBaseUrl: true);
    AppPrint.all("Google Place: $resp");
    GooglePlaces googlePlaces = GooglePlaces.fromJson(resp);
    if (googlePlaces.status == "OK") {
      addresses(googlePlaces.results ?? []);
    }

    loading(false);
  }
}
