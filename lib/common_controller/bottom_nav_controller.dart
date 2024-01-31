import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/views/home/favourite_screen.dart';
import 'package:oninto_flutter/views/home/home_screen.dart';
import 'package:oninto_flutter/views/message/navBarMsgScreen.dart';
import 'package:oninto_flutter/views/settingScreen/settings_screen.dart';

class BottomNavController extends GetxController {
  RxInt selectedIndex = RxInt(0);

  final List<Widget> bottomBarPages = [
    HomeScreen(),
    FavouriteScreen(),
    NavBarMsgScreen(),
    SettingScreen(),
  ];
  int maxCount = 5;

  void changeTab(int index) {
    selectedIndex.value = index;
  }
}
