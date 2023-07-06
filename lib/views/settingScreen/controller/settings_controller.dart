import 'package:get/get.dart';

class SettingsController extends GetxController{

  RxBool on = false.obs;
  void toggle() => on.value = on.value ? false: true;
}