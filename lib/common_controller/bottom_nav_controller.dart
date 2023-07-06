import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/views/home/favourite_screen.dart';
import 'package:oninto_flutter/views/home/home_screen.dart';
import 'package:oninto_flutter/views/navBarMessage/navBarMessage.dart';
import '../views/settings/settings_screen.dart';

class BottomNavController extends GetxController {
  NotchBottomBarController notchBottomBarController =
      NotchBottomBarController();
  RxInt selectedIndex = RxInt(0);

  final List<Widget> bottomBarPages = [
    HomeScreen(
      data: {},
    ),
    FavouriteScreen(),
    NavBarMessage(),
    SettingScreen(),
  ];
  int maxCount = 5;

  void changeTab(int index) {
    selectedIndex.value = index;
  }
}
