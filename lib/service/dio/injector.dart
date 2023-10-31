import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:oninto_flutter/service/exception_handle.dart';
import 'package:oninto_flutter/service/local/userInfo_globle.dart';

import '../../main.dart';
import '../app_keys.dart';

class Injector {
  static final Injector _singleton = Injector._internal();
  static final _dio = Dio();

  factory Injector() {
    return _singleton;
  }
  Injector._internal();

  Dio getDio() {
    BaseOptions options = BaseOptions(
        receiveTimeout: const Duration(seconds: 120),
        connectTimeout: const Duration(seconds: 120));
    _dio.options = options;
    _dio.options.followRedirects = false;
    _dio.options.headers["Content-Type"] = "application/json";
    _dio.options.headers["secret_key"] = AppKeys.apiSecretKey;
    _dio.options.headers["publish_key"] = AppKeys.apiPublishKey;
    (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    _dio.interceptors.clear();
    _dio.interceptors.add(LoggingInterceptors());
    return _dio;
  }

  static Options? getHeaderToken() {
    String? token = UserStoredInfo().userInfo?.token;
    if (kDebugMode) {
      print("User Token => $token");
    }
    debugPrint("User Id => ${UserStoredInfo().userInfo?.token}");
    var headerOptions = Options(
      headers: {'Authorization': 'Bearer $token'},
    );
    return headerOptions;
  }

  static Options? requestHeaderToken(String method) {
    String? token = UserStoredInfo().userInfo?.token;
    if (kDebugMode) {
      print("User Token => $token");
    }
    debugPrint("User Id => ${UserStoredInfo().userInfo?.token}");
    var headerOptions =
        Options(headers: {'Authorization': 'Bearer $token'}, method: method);
    return headerOptions;
  }
}

class LoggingInterceptors extends Interceptor {
  String printObject(Object object) {
    // Encode your object and then decode your object to Map variable
    Map jsonMapped = json.decode(json.encode(object));
    // Using JsonEncoder for spacing
    JsonEncoder encoder = const JsonEncoder.withIndent('  ');
    // encode it to string
    String prettyPrint = encoder.convert(jsonMapped);
    return prettyPrint;
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      print(
          "--> ${options.method.toUpperCase()} ${"${options.baseUrl}${options.path}"}");
      print("Headers:");
      options.headers.forEach((k, v) => print('$k: $v'));
      print("queryParameters:");
      options.queryParameters.forEach((k, v) => print('$k: $v'));
      if (options.data != null) {
        try {
          // print("Body: ${printObject(options.data)}");
          FormData formData = options.data as FormData;
          print("Body:");
          var buffer = [];
          for (MapEntry<String, String> pair in formData.fields) {
            buffer.add('${pair.key}:${pair.value}');
          }
          print("Body:{${buffer.join(', ')}}");
        } catch (e) {
          print("Body: ${printObject(options.data)}");
        }
      }
      print(
          "--> END ${options.method != null ? options.method.toUpperCase() : 'METHOD'}");
    }
    return super.onRequest(options, handler);
  }

  @override
  void onError(DioError dioError, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      print(
          "<-- ${dioError.message} ${(dioError.response?.requestOptions != null ? (dioError.response!.requestOptions.baseUrl + dioError.response!.requestOptions.path) : 'URL')}");
      print(
          "${dioError.response != null ? dioError.response!.data : 'Unknown Error'}");
      print("<-- End error");
    }
    // if (dioError.response?.statusCode == 400) {
    //   MyApp.startFirstScreen("Session expire. Please login again.");
    // }
    if (dioError.response?.statusCode == 401) {
      MyApp.startFirstScreen("Session expire. Please login again.");
    }
    ApiException.onError(dioError);
    //else if (dioError.response?.statusCode == 402) {
    //   MyApp.startFirstScreen("Your account is inactive from admin. Please contact at support@karmakid.com");
    // }
    // else if (dioError.response?.statusCode == 403) {
    //   MyApp.startFirstScreen("Session expire. Please login again.");
    // }
    return super.onError(dioError, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      print(
          "<-- ${response.statusCode} ${(response.requestOptions != null ? (response.requestOptions.baseUrl + response.requestOptions.path) : 'URL')}");
      print("Headers:");
      response.headers.forEach((k, v) => print('$k: $v'));
      print("Response: ${response.data}");
      print("<-- END HTTP");
    }
    return super.onResponse(response, handler);
  }
}