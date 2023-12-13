import 'package:dio/dio.dart';
import 'package:oninto_flutter/utils/app_toast_loader.dart';

class ApiException {
  static onError(DioException error) {
    printError("API ERROR ==> [${error.response}] ---> ${error.message}");
    if (error.response != null) {
      AppToast.show((error.response?.data?['message']).toString());
    } else {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          AppToast.show("Connection time out");
        case DioExceptionType.receiveTimeout:
          AppToast.show("Receive time out");
        case DioExceptionType.sendTimeout:
          AppToast.show("Request send time out");
        case DioExceptionType.connectionError:
          AppToast.show("No internet connection available");
        case DioExceptionType.unknown:
          AppToast.show("Unknown error");
        default:
          AppToast.show("No internet connection available");
      }
    }
  }

  ///
  static printError(String text) {
    print("\x1B[31m$text\x1B[0m");
  }
}
