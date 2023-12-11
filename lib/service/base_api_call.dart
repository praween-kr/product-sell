import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:oninto_flutter/utills/app_print.dart';
import 'package:oninto_flutter/utills/app_toast_loader.dart';

import 'apis.dart';
import 'dio/injector.dart';
import 'exception_handle.dart';

class BaseApiCall {
  // static Dio? dio;

  // static init() {
  //   dio = Dio();
  // }
  late Dio _dio;

  BaseApiCall() {
    _dio = Injector().getDio();
  }

  // Base api call...
  getReq(String endPoint,
      {bool showToast = true,
      Map<String, dynamic>? urlEncodedData,
      Map<String, dynamic>? params,
      String? id,
      Map<String, List<dynamic>>? multiParams,
      bool hideBaseUrl = false}) async {
    //

    try {
      String newEndPoint = endPoint;
      if (params != null) {
        for (final entry in params.entries) {
          if (entry.value != '') {
            if (!newEndPoint.contains('?')) {
              newEndPoint += "?${entry.key}=${entry.value}";
            } else {
              newEndPoint += "&${entry.key}=${entry.value}";
            }
          }
        }
      }
      if (multiParams != null) {
        for (final entry in multiParams.entries) {
          if (entry.value != '') {
            for (var v in entry.value) {
              if (!newEndPoint.contains('?')) {
                newEndPoint += "?${entry.key}=$v";
              } else {
                newEndPoint += "&${entry.key}=$v";
              }
            }
          }
        }
      }
      if (id != null) {
        newEndPoint += "/$id";
      }
      if (urlEncodedData == null) {
        final response = await _dio.get(
          hideBaseUrl ? newEndPoint : AppApis.baseUrl + newEndPoint,
          options: Injector
              .getHeaderToken(), //Options(headers: getHeaders(token: token, sctKey: sctKey)),
        );

        log("GET RESP [$newEndPoint] ===> ${jsonEncode(response.data)}");
        if (response.statusCode == 200) {
          showToast ? AppToast.show(response.data['message'].toString()) : null;
          return response.data;
        }
      } else {
        // This api request dio request for urlencoded data prams
        final response = await _dio.request(AppApis.baseUrl + newEndPoint,
            options: Injector.requestHeaderToken('GET'), data: urlEncodedData);

        log("GET RESP [$newEndPoint] ===> ${jsonEncode(response.data)}");
        if (response.statusCode == 200) {
          showToast ? AppToast.show(response.data['message'].toString()) : null;
          return response.data;
        }
      }
    } on DioException catch (error) {
      ApiException.onError(error);
    }
  }

  postReq(String endPoint,
      {bool showToast = true, Map<String, dynamic>? data}) async {
    AppPrint.all("POST REQUEST: $endPoint -> $data");
    Response response;
    try {
      response = await Dio().post(AppApis.baseUrl + endPoint,
          data: data, options: Injector.getHeaderToken());

      if (response.statusCode == 200 || response.statusCode == 201) {
        showToast ? AppToast.show(response.data['message'] ?? '') : null;
        return response.data;
      } else {
        log("Exp: $response");
        showToast ? AppToast.show(response.data['message']) : null;
      }
      // ignore: deprecated_member_use
    } on DioException catch (error) {
      ApiException.onError(error);
    }
    return null;
  }

  putReq(String endPoint,
      {bool showToast = true, Map<String, dynamic>? data}) async {
    AppPrint.all("PUT REQUEST: $endPoint -> $data");
    Response response;
    try {
      response = await Dio().put(AppApis.baseUrl + endPoint,
          data: data, options: Injector.getHeaderToken());

      if (response.statusCode == 200) {
        showToast ? AppToast.show(response.data['message'] ?? '') : null;
        return response.data;
      } else {
        log("Exp: $response");
        showToast ? AppToast.show(response.data['message']) : null;
      }
      // ignore: deprecated_member_use
    } on DioException catch (error) {
      ApiException.onError(error);
    }
    return null;
  }

  postFormReq(
    String endPoint, {
    Map<String, String>? attachments,
    Map<String, List<String>>? multiAttachment,
    // String? attachmentKey,
    Map<String, dynamic>? data,
    showToast = true,
  }) async {
    AppPrint.all(
        "FORM POST REQUEST: $endPoint -> $data [Attachment]: $attachments list: {$multiAttachment}");
    // dio!.interceptors.add(DioInterceptor());
    Map<String, dynamic> map = data ?? {};

    debugPrint(
        "POST REQ WITH ATCHMENT [$endPoint] ===> $data | FILE: $attachments-|-$multiAttachment  ");
    try {
      // Add multipart single attachment
      if (attachments != null) {
        for (String key in attachments.keys) {
          String? attachment = attachments[key];
          String attachmentKey = key;
          //
          if ((attachment ?? '') != '' && attachmentKey != '') {
            File file = File(attachment!);
            String fileType =
                attachment.substring(attachment.lastIndexOf(".") + 1);
            map[attachmentKey] = await MultipartFile.fromFile(file.path,
                filename: attachment.split("/").last,
                contentType: MediaType(getFileType(attachment)!, fileType));
          }
        }
      }
      // Add multipart multiple attachments
      if (multiAttachment != null) {
        for (String key in multiAttachment.keys) {
          List<String> ats = multiAttachment[key] ?? [];

          List<MultipartFile> filesList = [];
          for (String fileData in ats) {
            if ((fileData) != '') {
              filesList.add(await getFormFile(fileData));
              // formData.files.add(MapEntry(atsKey, await getFormFile(fileData)));
            }
          }
          map.addAll({key: filesList});
        }
      }
      // Conver
      FormData formData = FormData.fromMap(map);
      debugPrint("Form Post Request Data===> ${formData.fields}");
      Response response = await _dio.post(AppApis.baseUrl + endPoint,
          data: FormData.fromMap(map),
          options: Injector
              .getHeaderToken() // Options(headers: getHeaders(token: token, sctKey: sctKey)),
          );
      log("POST RESP WITH ATCHMENT [$endPoint] ===> ${response.data}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (showToast) {
          AppToast.show(response.data['message']);
        }

        return response.data;
      } else {
        log("Exp: $response");
        AppToast.show(response.data['message']);
      }
      // ignore: deprecated_member_use
    } on DioException catch (error) {
      ApiException.onError(error);
    }
    return null;
  }

  putFormReq(
    String endPoint, {
    Map<String, String>? attachments,
    Map<String, List<String>>? multiAttachment,
    // String? attachmentKey,
    Map<String, dynamic>? data,
    showToast = true,
  }) async {
    AppPrint.all(
        "FORM PUT REQUEST: $endPoint -> $data [Attachment]: $attachments list: {$multiAttachment}");

    // dio!.interceptors.add(DioInterceptor());
    Map<String, dynamic> map = data ?? {};

    debugPrint(
        "POST REQ WITH ATCHMENT [$endPoint] ===> $data | FILE: $attachments-|-$multiAttachment  ");
    try {
      // Add multipart single attachment
      if (attachments != null) {
        for (String key in attachments.keys) {
          String? attachment = attachments[key];
          String attachmentKey = key;
          //
          if ((attachment ?? '') != '' && attachmentKey != '') {
            File file = File(attachment!);
            String fileType =
                attachment.substring(attachment.lastIndexOf(".") + 1);
            map[attachmentKey] = await MultipartFile.fromFile(file.path,
                filename: attachment.split("/").last,
                contentType: MediaType(getFileType(attachment)!, fileType));
          }
        }
      }
      // Add multipart multiple attachments
      if (multiAttachment != null) {
        for (String key in multiAttachment.keys) {
          List<String> ats = multiAttachment[key] ?? [];

          List<MultipartFile> filesList = [];
          for (String fileData in ats) {
            if ((fileData) != '') {
              filesList.add(await getFormFile(fileData));
              // formData.files.add(MapEntry(atsKey, await getFormFile(fileData)));
            }
          }
          map.addAll({key: filesList});
        }
      }
      // Conver
      FormData formData = FormData.fromMap(map);
      debugPrint("Form Post Request Data===> ${formData.fields}");
      Response response = await _dio.put(AppApis.baseUrl + endPoint,
          data: FormData.fromMap(map),
          options: Injector
              .getHeaderToken() // Options(headers: getHeaders(token: token, sctKey: sctKey)),
          );
      log("POST RESP WITH ATCHMENT [$endPoint] ===> ${response.data}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (showToast) {
          AppToast.show(response.data['message']);
        }

        return response.data;
      } else {
        log("Exp: $response");
        AppToast.show(response.data['message']);
      }
      // ignore: deprecated_member_use
    } on DioException catch (error) {
      ApiException.onError(error);
    }
    return null;
  }

  // Base api call...
  deleteReq(String endPoint,
      {bool showToast = true, String? id, Map<String, dynamic>? data}) async {
    //
    try {
      if (data == null) {
        final response = await _dio.delete(
          '${AppApis.baseUrl}$endPoint/$id',
          options: Injector
              .getHeaderToken(), //Options(headers: getHeaders(token: token, sctKey: sctKey)),
        );

        log("DELETE RESP [$endPoint] ===> ${response.data}");
        if (response.statusCode == 200) {
          showToast ? AppToast.show(response.data['message'].toString()) : null;
          return response.data;
        }
      } else {
        // This api request dio request for urlencoded data prams
        final response = await _dio.request(AppApis.baseUrl + endPoint,
            options: Injector.requestHeaderToken('DELETE'), data: data);

        log("DELETE RESP [$endPoint] ===> ${response.data}");
        if (response.statusCode == 200) {
          showToast ? AppToast.show(response.data['message'].toString()) : null;
          return response.data;
        }
      }
    } on DioException catch (error) {
      ApiException.onError(error);
    }
  }

  //
  String? getFileType(String path) {
    final mimeType = lookupMimeType(path);
    String? result = mimeType?.substring(0, mimeType.indexOf('/'));
    return result;
  }

  Future<MultipartFile> getFormFile(String fileData) async {
    File file = File(fileData);
    String fileType = fileData.substring(fileData.lastIndexOf(".") + 1);
    var dd = await MultipartFile.fromFile(file.path,
        filename: fileData.split("/").last,
        contentType: MediaType(getFileType(fileData)!, fileType));
    // formData.files.add(MapEntry(atsKey, dd));
    return dd;
  }
}
