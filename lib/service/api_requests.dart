import 'dart:io';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oninto_flutter/model/auth/cms_model.dart';
import 'package:oninto_flutter/model/auth/user_info_model.dart';
import 'package:oninto_flutter/model/g_place_model.dart';
import 'package:oninto_flutter/model/home/category_model.dart';
import 'package:oninto_flutter/model/home/home_model.dart';
import 'package:oninto_flutter/model/settings/address_model.dart';
import 'package:oninto_flutter/service/dio/shared/page_response.dart';
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

  static Future<bool> signup(
      {required String firstName,
      required String lastName,
      required String email,
      required String countryCode,
      required String phone,
      required String location,
      required LatLng? cordinates,
      required String password,
      required String confirmPassword}) async {
    AppLoader.show();
    // final fcmToken = await FirebaseMessaging.instance.getToken();
    Map<String, dynamic> reqdata = {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "countryCode": countryCode,
      "phone": phone,
      "deviceType": Platform.isIOS ? 1 : 1,
      "deviceToken": "device_token",
      "location": location,
      "latitude": cordinates?.latitude ?? 0.0,
      "longitude": cordinates?.longitude ?? 0.0,
      "password": password,
      "confirmPassword": confirmPassword
    };
    AppPrint.all("Signup Req: $reqdata");
    var data = await BaseApiCall().postReq(AppApis.signUp, data: reqdata);

    AppPrint.all("Signup Resp: $data");
    if (data != null) {
      DataResponse<UserInfoModel?> dataResponse = DataResponse.fromJson(
          data, (json) => UserInfoModel.fromJson(json as Map<String, dynamic>));
      //
      if (dataResponse.body != null) {
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

  /// -------- Add Address --------
  static addAddress(
      {required String location,
      required String latitude,
      required String longitude,
      required String street,
      required String houseNo,
      required String landMark}) async {
    AppLoader.show();
    var data = await BaseApiCall().postReq(AppApis.addAddress, data: {
      "location": location,
      "latitude": latitude,
      "longitude": longitude,
      "street": street,
      "houseNo": houseNo,
      "landMark": landMark,
    });
    if (data != null) {
      AppLoader.hide();
      return true;
    }
    AppLoader.hide();
    return false;
  }

  /// -------- Add Address --------
  static getAddresses(
      {required Function(List<AddressModel>) data,
      required Function(bool) loading}) async {
    loading(true);
    var respdata =
        await BaseApiCall().getReq(AppApis.getAddresses, showToast: false);
    if (respdata != null) {
      PageResponse<AddressModel> pageResponse =
          PageResponse<AddressModel>.fromJson(respdata,
              (json) => AddressModel.fromJson(json as Map<String, dynamic>));

      data(pageResponse.body ?? []);
      loading(false);
      return true;
    }
    loading(false);
    return false;
  }

  /// -------- Categories List --------
  static getCategories(
      {required Function(List<CategoryModel>) data,
      required Function(bool) loading}) async {
    loading(true);
    var respdata =
        await BaseApiCall().getReq(AppApis.categoryList, showToast: false);
    if (respdata != null) {
      PageResponse<CategoryModel> pageResponse =
          PageResponse<CategoryModel>.fromJson(respdata,
              (json) => CategoryModel.fromJson(json as Map<String, dynamic>));

      data(pageResponse.body ?? []);
      loading(false);
      return true;
    }
    loading(false);
    return false;
  }

  /// -------- Categories List --------
  static getSubCategories(String categoryId,
      {required Function(List<CategoryModel>) data,
      required Function(bool) loading}) async {
    loading(true);
    var respdata = await BaseApiCall()
        .getReq(AppApis.subCategoriesList, showToast: false, id: categoryId);
    if (respdata != null) {
      PageResponse<CategoryModel> pageResponse =
          PageResponse<CategoryModel>.fromJson(respdata,
              (json) => CategoryModel.fromJson(json as Map<String, dynamic>));

      data(pageResponse.body ?? []);
      loading(false);
      return true;
    }
    loading(false);
    return false;
  }

  /// -------- Home Data --------
  static getHomeData(
      {required Function(HomeModel?) data,
      required Function(bool) loading}) async {
    loading(true);
    var respdata =
        await BaseApiCall().getReq(AppApis.homeData, showToast: false);
    if (respdata != null) {
      DataResponse<HomeModel> dataResponse = DataResponse<HomeModel>.fromJson(
          respdata, (json) => HomeModel.fromJson(json as Map<String, dynamic>));

      data(dataResponse.body);
      loading(false);
      return true;
    }
    loading(false);
    return false;
  }

  ///----------------------------

  static gPlaceSearch(String query,
      {required Function(List<PlaceResults>) addresses,
      required Function(bool) loading}) async {
    loading(true);
    String googleKey = "AIzaSyDGxkyWAlm8QrBJDT22ph0Y0CtxOFDHUL0";
    String api =
        "https://maps.googleapis.com/maps/api/place/textsearch/json?query=$query&key=$googleKey";
    var resp =
        await BaseApiCall().getReq(api, showToast: false, hideBaseUrl: true);
    // AppPrint.all("Google Place: $resp");
    GooglePlaces googlePlaces = GooglePlaces.fromJson(resp);
    if (googlePlaces.status == "OK") {
      addresses(googlePlaces.results ?? []);
    }

    loading(false);
  }
}
