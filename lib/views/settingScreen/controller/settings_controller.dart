import 'package:get/get.dart';

class SettingsController extends GetxController {
  RxBool on = false.obs;
  var type = 0.obs;
  void toggle() => on.value = on.value ? false : true;

  var tabController = 0.obs;
}
