import 'package:get/get.dart';
import 'package:oninto_flutter/common_controller/auth/auth_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
  }
}
