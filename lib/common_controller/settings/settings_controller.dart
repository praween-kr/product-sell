import 'package:get/get.dart';
import 'package:oninto_flutter/common_controller/auth/auth_controller.dart';
import 'package:oninto_flutter/service/api_requests.dart';
import 'package:oninto_flutter/service/local/db_helper.dart';
import 'package:oninto_flutter/service/local/local_store_keys.dart';

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
}
