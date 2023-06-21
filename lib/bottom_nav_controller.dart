import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:get/get.dart';

class BottomNavController extends GetxController {
  NotchBottomBarController notchBottomBarController =
      NotchBottomBarController();
  RxInt selectedIndex = RxInt(0);

  void changeTab(int index) {
    selectedIndex.value = index;
  }
}
