import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_controller/auth/auth_controller.dart';
import 'package:oninto_flutter/service/api_requests.dart';
import 'package:oninto_flutter/service/local/db_helper.dart';
import 'package:oninto_flutter/service/local/local_store_keys.dart';
import 'package:oninto_flutter/utills/app_print.dart';
import 'package:oninto_flutter/utills/app_toast_loader.dart';

class SettingsController extends GetxController {
  var loadingData = false.obs;
  //
  RxBool on = false.obs;
  var type = 0.obs;
  void toggle() => on.value = on.value ? false : true;

  var tabController = 0.obs;

  logout() async {
    await ApiRequests.logout();
    DbHelper.deleteData(SharedPrefKeys.userInfo);
    NavigateTo.login();
  }

  /// -----Change Password-----
  var oldPassword = TextEditingController(text: '');
  var newPassword = TextEditingController(text: '');
  var confirmPassword = TextEditingController(text: '');

  changePassword() async {
    if (changePasswordValidation()) {
      bool success = await ApiRequests.changePassword(
        oldPassword: oldPassword.text.trim(),
        newPassword: newPassword.text.trim(),
        confirmPassword: confirmPassword.text.trim(),
      );
      if (success) {
        AppPrint.error("Successfully changed password");
        clearChangePasswordFields();
        Get.back();
      } else {
        AppPrint.error("Failed changed password");
      }
    }
  }

  clearChangePasswordFields() {
    oldPassword.clear();
    newPassword.clear();
    confirmPassword.clear();
  }

  bool changePasswordValidation() {
    if (oldPassword.text.trim() == '') {
      AppToast.show("Please enter old password");
      return false;
    }
    if (newPassword.text.trim() == '') {
      AppToast.show("Please enter new password");
      return false;
    }
    if (confirmPassword.text.trim() == '') {
      AppToast.show("Please enter confirm password");
      return false;
    }
    if (newPassword.text.trim() != confirmPassword.text.trim()) {
      AppToast.show("New password and confirm password does not match");
      return false;
    }
    return true;
  }
}
