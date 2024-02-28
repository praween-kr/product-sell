import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oninto_flutter/model/payment/transaction_model.dart';
import 'package:oninto_flutter/model/product/my_purchase_share_model.dart';

import '../model/auth/cms_model.dart';
import '../model/auth/user_info_model.dart';
import '../model/g_place_model.dart';
import '../model/home/category_model.dart';
import '../model/home/home_model.dart';
import '../model/product/my_purchase_share_details_model.dart';
import '../model/product/product_details_model.dart';
import '../model/product/product_fav_view_model.dart';
import '../model/product/product_model.dart';
import '../model/settings/address_model.dart';
import '../model/settings/dashboard_info_model.dart';
import '../model/settings/my_favourite_product_model.dart';
import '../utils/app_print.dart';
import '../utils/app_toast_loader.dart';
import '../utils/date_time_formates.dart';
import '../views/bid_screen/notification_model.dart';
import 'apis.dart';
import 'base_api_call.dart';
import 'dio/shared/data_response.dart';
import 'dio/shared/page_response.dart';
import 'local/db_helper.dart';
import 'local/local_store_keys.dart';
import 'local/user_info_global.dart';

class ApiRequests {
  ApiRequests._();
  // Api requests...

  /// ---------Sign Up----------
  static Future<bool> signin(
      {required String phoneEmail, required String password}) async {
    AppLoader.show();

    final fcmToken = await FirebaseMessaging.instance.getToken();
    AppPrint.all("FCM Token: $fcmToken");
    var bodyData = {
      "phoneEmail": phoneEmail,
      "password": password,
      "deviceType": Platform.isIOS ? 2 : 1,
      "deviceToken": fcmToken ?? ''
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
      {String? profileImage,
      required String firstName,
      required String lastName,
      required String email,
      required String countryCode,
      required String phone,
      required String location,
      required LatLng? cordinates,
      required String password,
      required String confirmPassword}) async {
    AppLoader.show();
    final fcmToken = await FirebaseMessaging.instance.getToken();
    Map<String, dynamic> reqdata = {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "countryCode": countryCode,
      "phone": phone,
      "deviceType": Platform.isIOS ? 2 : 1,
      "deviceToken": fcmToken ?? '',
      "location": location,
      "latitude": cordinates?.latitude ?? 0.0,
      "longitude": cordinates?.longitude ?? 0.0,
      "password": password,
      "confirmPassword": confirmPassword
    };
    AppPrint.all("Signup Req: $reqdata");
    var data = await BaseApiCall().postFormReq(
      AppApis.signUp,
      data: reqdata,
      attachments: profileImage == null ? null : {"images": profileImage},
    );

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
        // UserStoredInfo().storeUserInfo(dataResponse.body);
        // DbHelper.saveMap(
        //     key: SharedPrefKeys.userInfo, data: dataResponse.body!.toJson());
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
  static Future<bool> updateProfile({
    String? profileImage,
    required String firstName,
    required String lastName,
    required String email,
    required String countryCode,
    required String phone,
    required String location,
    required LatLng? cordinates,
  }) async {
    AppLoader.show();
    debugPrint("location.text.trim(): $location");
    var data = await BaseApiCall().putFormReq(AppApis.updateProfile,
        data: {
          "firstName": firstName,
          "lastName": lastName,
          "email": email,
          "countryCode": countryCode,
          "phone": phone,
          "location": location,
          "latitude": cordinates?.latitude ?? 0.0,
          "longitude": cordinates?.longitude ?? 0.0,
        },
        attachments: profileImage == null ? null : {"images": profileImage});

    if (data != null) {
      Map<String, dynamic> newdata = data['body'] as Map<String, dynamic>;
      newdata.addAll({"token": UserStoredInfo().userInfo!.token ?? ''});

      AppPrint.all("Update Profile Req: $data");
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
  // Add
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

  // Update
  static updateAddress(
      {required String addressId,
      required String location,
      required String latitude,
      required String longitude,
      required String street,
      required String houseNo,
      required String landMark}) async {
    AppLoader.show();
    var data = await BaseApiCall().putReq(AppApis.updateAddress, data: {
      "addressId": addressId,
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
  static deleteAddress(String addressId) async {
    AppLoader.show();
    var data =
        await BaseApiCall().deleteReq(AppApis.deleteAddress, id: addressId);
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

  /// ---- Add Physical Product -------
  static addPhysicalProduct({
    required List<String> images,
    required List<String> videos,
    required String title,
    required String location,
    required LatLng cordinates,
    required String category,
    required String subcategory,
    required String color,
    required List<String> sizes,
    required String brand,
    required String condition,
    required String selloption,
    DateTime? startDate,
    DateTime? endDate,
    TimeOfDay? startBidingTime,
    required String price,
    required String description,
  }) async {
    Map<String, dynamic> mapData = {
      "name": title,
      "location": location,
      "latitude": cordinates.latitude,
      "longitude": cordinates.longitude,
      "categoryId": category,
      "subCategoryId": subcategory,
      "color": color,
      "brand": brand,
      "productCondition": category,
      "sellOption": selloption,
      "price": price,
      "description": description,
      "startDate": startDate == null
          ? ''
          : AppDateTime.defaultDateTime(
              startDate), //"${startDate.year}-${startDate.month}-${startDate.day}",
      "endDate": endDate == null
          ? ''
          : AppDateTime.defaultDateTime(
              endDate), //"${endDate.year}-${endDate.month}-${endDate.day}",
      "bidTime": AppDateTime.time24hr(timeOfDay: startBidingTime),
      "boostCode": "",
      "size": jsonEncode(sizes)
    };
    AppPrint.all(
        "Add Product Req: data--> $mapData images---> $images videos---> $videos");

    AppLoader.show();
    var data = await BaseApiCall().postFormReq(
      AppApis.addPhysicalProduct,
      data: mapData,
      multiAttachment: {'images': images, 'video': videos},
    );
    AppPrint.all("Add Product Resp: $data");
    if (data != null) {
      AppLoader.hide();
      return true;
    }
    AppLoader.hide();
    return false;
  }

  static editPhysicalProduct({
    required String id,
    List<String>? images,
    List<String>? oldImagesId,
    List<String>? videos,
    String? title,
    String? location,
    LatLng? cordinates,
    String? category,
    String? subcategory,
    String? color,
    List<String>? sizes,
    List<int>? removeSizes,
    String? brand,
    String? condition,
    String? selloption,
    DateTime? startDate,
    DateTime? endDate,
    TimeOfDay? startBidingTime,
    String? price,
    String? description,
  }) async {
    Map<String, dynamic> mapData = {"id": id};
    if (title != null) {
      mapData.addAll({"name": title});
    }
    if (location != null) {
      mapData.addAll({"location": location});
    }
    if (cordinates != null) {
      mapData.addAll(
          {"latitude": cordinates.latitude, "longitude": cordinates.longitude});
    }
    if (category != null) {
      mapData.addAll({"categoryId": category});
    }
    if (subcategory != null) {
      mapData.addAll({"subCategoryId": subcategory});
    }
    if (color != null) {
      mapData.addAll({"color": color});
    }
    if (brand != null) {
      mapData.addAll({"brand": brand});
    }
    if (condition != null) {
      mapData.addAll({"productCondition": condition});
    }
    if (selloption != null) {
      mapData.addAll({"sellOption": selloption});
    }
    if (price != null) {
      mapData.addAll({"price": price});
    }
    if (description != null) {
      mapData.addAll({"description": description});
    }
    if (startDate != null) {
      mapData.addAll({
        "startDate": "${startDate.year}-${startDate.month}-${startDate.day}"
      });
    }
    if (endDate != null) {
      mapData.addAll(
          {"endDate": "${endDate.year}-${endDate.month}-${endDate.day}"});
    }
    if (startBidingTime != null) {
      mapData.addAll(
          {"bidTime": AppDateTime.time24hr(timeOfDay: startBidingTime)});
    }
    if (oldImagesId != null) {
      String ids = "";
      for (int i = 0; i < oldImagesId.length; i++) {
        ids += "${oldImagesId[i]}${(i == oldImagesId.length - 1) ? '' : ','}";
      }
      mapData.addAll({"old_images_id": "[$ids]"});
    }
    if ((sizes ?? []).isNotEmpty) {
      mapData.addAll({"size": jsonEncode(sizes)});
    }
    // if(price!=null){
    //   mapData.addAll({"boostCode": price});
    // }
    if (removeSizes != null) {
      String ids = "";
      for (int i = 0; i < removeSizes.length; i++) {
        ids += "${removeSizes[i]}${(i == removeSizes.length - 1) ? '' : ','}";
      }
      mapData.addAll({"old_size": "[$ids]"});
    }

    AppPrint.all(
        "Add Product Req: data--> $mapData images---> $images videos---> $videos");
    AppLoader.show();
    var data = await BaseApiCall().putFormReq(
      AppApis.editPhysicalProduct,
      data: mapData,
      multiAttachment:
          images == null ? null : {'images': images, 'video': videos ?? []}, //,
    );
    AppPrint.all("Add Product Resp: $data");
    if (data != null) {
      AppLoader.hide();
      return true;
    }
    AppLoader.hide();
    return false;
  }

  /// ---- Add Co Owner Product -------
  static addCoOwnerProduct({
    required List<String> images,
    required List<String> videos,
    required String title,
    required String location,
    required LatLng cordinates,
    required String basePrice,
    required String description,
    required int shares,
  }) async {
    Map<String, dynamic> mapData = {
      "name": title,
      "location": location,
      "latitude": cordinates.latitude,
      "longitude": cordinates.longitude,
      "price": basePrice,
      "description": description,
      "boostCode": "",
      "share": shares,
    };
    AppPrint.all("Add Product Req: $mapData");
    AppLoader.show();
    var data = await BaseApiCall().postFormReq(AppApis.addCownerProduct,
        data: mapData,
        multiAttachment: {'images': images, 'video': videos}); //,
    AppPrint.all(
        "Add Product Req: data--> $mapData images---> $images videos---> $videos");
    if (data != null) {
      AppLoader.hide();
      return true;
    }
    AppLoader.hide();
    return false;
  }

  /// ---- Product Details -------
  static productDetails(String productId,
      {required Function(ProductDetailsData?) data,
      required Function(bool) loading}) async {
    loading(true);
    var respdata = await BaseApiCall()
        .getReq(AppApis.productDetatils, showToast: false, id: productId);
    if (respdata != null) {
      DataResponse<ProductDetailsData> dataResponse =
          DataResponse<ProductDetailsData>.fromJson(
              respdata,
              (json) =>
                  ProductDetailsData.fromJson(json as Map<String, dynamic>));

      data(dataResponse.body);
      loading(false);
      return true;
    }
    loading(false);
    return false;
  }

  /// ---- Get My Products -------
  // type 1 for myProduct 2 for CownerProducts 3 for buy product and 4 for sell product that my added product is sell
  // for filter keys is (sold,new_added,pending) with values is 1 when we apply any filter
  static getMyProducts({
    required Function(List<Product>) data,
    required Function(bool) loading,
    required int type,
    bool sold = false,
    bool newAdded = false,
    bool pending = false,
  }) async {
    Map<String, dynamic> reqData = {"type": type};
    if (sold) {
      reqData.addAll({"sold": 1});
    }
    if (newAdded) {
      reqData.addAll({"new_added": 1});
    }

    if (pending) {
      reqData.addAll({"pending": 1});
    }

    AppPrint.all("text::: R-- ${jsonEncode(reqData)}");

    ///
    loading(true);
    var respdata = await BaseApiCall()
        .postReq(AppApis.myProducts, showToast: false, data: reqData);
    AppPrint.all("text::: ${jsonEncode(respdata)}");
    if (respdata != null) {
      PageResponse<Product> pageResponse;
      if (type == 3 || type == 4) {
        pageResponse = PageResponse<BuyProductModel>.fromJson(respdata,
            (json) => BuyProductModel.fromJson(json as Map<String, dynamic>));
      } else {
        pageResponse = PageResponse<ProductModel>.fromJson(respdata,
            (json) => ProductModel.fromJson(json as Map<String, dynamic>));
      }

      data(pageResponse.body ?? []);
      loading(false);
      return true;
    }
    loading(false);
    return false;
  }

// For filter send keys is (endingSoon,highestPrice,lowestPrice,mostBid,leastBid,recentBid) with value 1
  static getProducts({
    required Function(List<ProductModel>) data,
    required Function(bool) loading,
    String? searchKey,
    bool endingSoon = false,
    bool highestPrice = false,
    bool lowestPrice = false,
    bool mostBid = false,
    bool leastBid = false,
    bool recentBid = false,
    String? categoryId,
    String? subCategoryId,
    int? limit,
    int? pageno,
    // Filter by product type [1 for bid, 2 for fixed, 3 for share]
    int? productType,
  }) async {
    Map<String, dynamic> reqData = {"search": searchKey ?? ''};
    if (endingSoon) {
      reqData.addAll({"endingSoon": 1});
    }
    if (highestPrice) {
      reqData.addAll({"highestPrice": 1});
    }
    if (lowestPrice) {
      reqData.addAll({"lowestPrice": 1});
    }
    if (mostBid) {
      reqData.addAll({"mostBid": 1});
    }
    if (leastBid) {
      reqData.addAll({"leastBid": 1});
    }
    if (recentBid) {
      reqData.addAll({"recentBid": 1});
    }
    if (categoryId != null) {
      reqData.addAll({"categoryId": categoryId});
    }
    if (subCategoryId != null) {
      reqData.addAll({"subCategoryId": subCategoryId});
    }
    if (limit != null) {
      reqData.addAll({"limit": limit});
    }
    if (pageno != null) {
      reqData.addAll({"skip": pageno});
    }
    if (productType != null) {
      reqData.addAll({"product_type": productType});
    }

    AppPrint.all("text::: R-- ${jsonEncode(reqData)}");

    ///
    loading(true);
    var respdata = await BaseApiCall()
        .postReq(AppApis.getProducts, showToast: false, data: reqData);
    AppPrint.all("text::: ${jsonEncode(respdata)}");
    if (respdata != null) {
      PageResponse<ProductModel> pageResponse =
          PageResponse<ProductModel>.fromJson(respdata,
              (json) => ProductModel.fromJson(json as Map<String, dynamic>));

      data(pageResponse.body ?? []);
      loading(false);
      return true;
    }
    loading(false);
    return false;
  }

  /// -------- Add Address --------
  static addProductAsFavourite(String productId,
      {required Function(bool) loading, required Function(bool) status}) async {
    loading(true);
    var data = await BaseApiCall().postReq(AppApis.addProductAsFavourite,
        data: {"productId": productId}, showToast: false);
    print("r->, rp-> $data");
    if (data['body'] == 1) {
      status(false);
    } else {
      if (data['body'] != null) {
        if (data['body']['id'] != productId) {
          status(true);
        }
      }
    }
    if (data != null) {
      loading(false);
      return true;
    }
    loading(false);
    return false;
  }

  /// ---- Get Favourite Products -------
  static getFavouriteProducts(
      {required Function(List<MyFavProduct>) data,
      required Function(bool) loading}) async {
    loading(true);
    var respdata = await BaseApiCall()
        .getReq(AppApis.myFavouriteProducts, showToast: false);
    if (respdata != null) {
      PageResponse<MyFavProduct> pageResponse =
          PageResponse<MyFavProduct>.fromJson(respdata,
              (json) => MyFavProduct.fromJson(json as Map<String, dynamic>));

      data(pageResponse.body ?? []);
      loading(false);
      return true;
    }
    loading(false);
    return false;
  }

  /// ---- Get Views and Likes of Products -------
  static getViewsAndLikesOfProduct(
      {required String id,
      required Function(ProductFavViewModel?) data,
      required Function(bool) loading}) async {
    loading(true);
    var respdata = await BaseApiCall()
        .getReq(AppApis.viewAndLikesOfProduct, showToast: false, id: id);
    if (respdata != null) {
      DataResponse<ProductFavViewModel> viewsLikes =
          DataResponse<ProductFavViewModel>.fromJson(
              respdata,
              (json) =>
                  ProductFavViewModel.fromJson(json as Map<String, dynamic>));

      data(viewsLikes.body);
      loading(false);
      return true;
    }
    loading(false);
    return false;
  }

  /// ---- Upload Message Attachment -------
  static uploadAttachment(
      {required String attachment,
      required String type,
      required String thumbnail,
      required Function(bool) loading,
      required Function(String, String, String) respdata}) async {
    Map<String, dynamic> mapData = {"messageType": type};

    loading(true);
    var data = await BaseApiCall().postFormReq(AppApis.uploadAttachment,
        data: mapData,
        attachments: {'message': attachment, "thumbnail": thumbnail},
        showToast: false);
    AppPrint.all("Add Product Resp: $data");
    if (data != null) {
      respdata(data['body']['messageType'].toString(),
          data['body']['message'] ?? '', data['body']['thumbnail'] ?? '');
      loading(false);
      return true;
    }
    loading(false);
    return false;
  }

  /// ---- Get All Purchase Shares -------
  static getAllMyPurchaseShares(
      {required Function(MySharesModel?) data,
      required Function(bool) loading}) async {
    loading(true);
    var respdata = await BaseApiCall()
        .getReq(AppApis.allMyPurchaseShares, showToast: false);
    if (respdata != null) {
      DataResponse<MySharesModel> resqData =
          DataResponse<MySharesModel>.fromJson(respdata,
              (json) => MySharesModel.fromJson(json as Map<String, dynamic>));

      data(resqData.body);
      loading(false);
      return true;
    }
    loading(false);
    return false;
  }

  /// ---- Get Purchase Shares Details -------
  static getMyPurchaseShareDetails(String shareId,
      {required Function(PurchaseShareDetails?) data,
      required Function(bool) loading}) async {
    loading(true);
    var respdata = await BaseApiCall().postReq(
        AppApis.getMyPurchaseShareDetails,
        data: {"shareId": shareId},
        showToast: false);
    if (respdata != null) {
      AppPrint.all("dd--> ${jsonEncode(respdata)}");
      DataResponse<PurchaseShareDetails> resqData =
          DataResponse<PurchaseShareDetails>.fromJson(
              respdata,
              (json) =>
                  PurchaseShareDetails.fromJson(json as Map<String, dynamic>));

      data(resqData.body);
      loading(false);
      return true;
    }
    loading(false);
    return false;
  }

  ///------------
  // transaction_id,paymentJSON,productId,amount,shpingAddressId,chargedAmount
  static buyAndAddShippingAddress(
      {required String productId,
      required double amount,
      String? shpingAddressId,
      required double chargeAccount,
      required int type,
      int? shareQty,
      required Function(Map<String, dynamic>?) intentData,
      paymentId}) async {
    AppLoader.show();
    Map<String, dynamic>? requestData = {
      "productId": productId,
      "amount": amount,
      "chargedAmount": chargeAccount,
      "type": type,
    };
    if (shpingAddressId != null) {
      requestData.addAll({"shpingAddressId": shpingAddressId});
    }
    if (shareQty != null) {
      requestData.addAll({"numberOfShare": shareQty});
    }
    AppPrint.all("requestData: buyAndAddShippingAddress-Req> $requestData");
    var data = await BaseApiCall().postReq(AppApis.shippingAddressAddProductBuy,
        data: requestData, showToast: true);

    AppPrint.all(
        "requestData: buyAndAddShippingAddress -Resp> $requestData ||| ${data['body']['paymentIntent']['client_secret']}");
    if (data != null) {
      intentData(data['body']);
      AppLoader.hide();
      return true;
    }
    AppLoader.hide();
    return false;
  }

  // stripeWebhookConfirmPayment
  static stripeWebhookConfirmPayment(String transactionId) async {
    AppLoader.show();
    var data = await BaseApiCall().postReq(AppApis.stripeWebhookConfirmPayment,
        data: {"transaction_id": transactionId}, showToast: true);
    if (data != null) {
      AppLoader.hide();
      return true;
    }
    AppLoader.hide();
    return false;
  }

  // Shipped Poduct Status Update
  // 0 shipping pending, 1 for shipping started and 2 for shipped to buyer
  static shippedPoductStatusUpdate(
      {required String productId,
      required String transactionId,
      required int shippedProductStatus}) async {
    AppLoader.show();
    var data = await BaseApiCall().postReq(AppApis.shippedPoductStatusUpdate,
        data: {
          "productId": productId,
          "id": transactionId,
          "shipped_product_status": shippedProductStatus
        },
        showToast: true);
    AppPrint.info("Shipping Product Status Updated: $data");
    if (data != null) {
      AppLoader.hide();
      return true;
    }
    AppLoader.hide();
    return false;
  }

  /// -------- Transaction Histories --------
  static getTransactionsHistory(
      {required Function(List<TransactionModel>) data,
      required Function(bool) loading}) async {
    loading(true);
    var respdata = await BaseApiCall()
        .getReq(AppApis.transactionHistory, showToast: false);
    if (respdata != null) {
      PageResponse<TransactionModel> pageResponse =
          PageResponse<TransactionModel>.fromJson(
              respdata,
              (json) =>
                  TransactionModel.fromJson(json as Map<String, dynamic>));

      data(pageResponse.body ?? []);
      loading(false);
      return true;
    }
    loading(false);
    return false;
  }

  // Share Purchage
  static purchageShare({
    required String shareId,
    required int noOfShares,
    required double perSharePrice,
  }) async {
    AppLoader.show();
    var data = await BaseApiCall().postReq(AppApis.purchaseShare,
        data: {
          "shareId": shareId,
          "totalSharePurchase": noOfShares,
          "perSharePrice": perSharePrice
        },
        showToast: true);
    if (data != null) {
      AppLoader.hide();
      return true;
    }
    AppLoader.hide();
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

  static getNotificationListing(
      {required Function(List<NotificationModel>) data,
      required Function(bool) loading}) async {
    loading(true);
    var respdata = await BaseApiCall()
        .getReq(AppApis.notificationListing, showToast: false);
    if (respdata != null) {
      PageResponse<NotificationModel> pageResponse =
          PageResponse<NotificationModel>.fromJson(
              respdata,
              (json) =>
                  NotificationModel.fromJson(json as Map<String, dynamic>));

      data(pageResponse.body ?? []);
      loading(false);
      return true;
    }
    loading(false);
    return false;
  }

  /// My Dashboard Infoi
  static getMyDasboardData(
      {required Function(DashboardInfo?) data,
      required Function(bool) loading}) async {
    loading(true);
    var respdata =
        await BaseApiCall().getReq(AppApis.mydashboard, showToast: false);
    if (respdata != null) {
      DataResponse<DashboardInfo> pageResponse =
          DataResponse<DashboardInfo>.fromJson(respdata,
              (json) => DashboardInfo.fromJson(json as Map<String, dynamic>));

      data(pageResponse.body);
      loading(false);
      return true;
    }
    loading(false);
    return false;
  }

  static Future<bool> deleteNotification(
      {required String notificationId}) async {
    AppLoader.show();
    var data = await BaseApiCall().deleteReq(AppApis.deleteNotification, data: {
      "id": notificationId,
    });
    if (data != null) {
      AppLoader.hide();
      return true;
    }
    AppLoader.hide();
    return false;
  }
}
