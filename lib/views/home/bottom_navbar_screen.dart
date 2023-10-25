import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_controller/bottom_nav_controller.dart';
import 'package:oninto_flutter/common_widget/color_constant.dart';
import 'package:oninto_flutter/views/home/favourite_screen.dart';
import 'package:oninto_flutter/views/home/home_screen.dart';
import 'package:oninto_flutter/views/navBarMsgScreen/navBarMsgScreen.dart';
import 'package:oninto_flutter/views/settingScreen/settings_screen.dart';

class BottomScreen extends StatelessWidget {
  BottomScreen({
    Key? key,
  }) : super(key: key);
  final controller = Get.put(BottomNavController());

  List<TabItem> items = [
    const TabItem(
      icon: Icons.home,
    ),
    const TabItem(
      icon: Icons.favorite_border,
    ),
    const TabItem(
      icon: Icons.chat_bubble_outline,
    ),
    const TabItem(
      icon: Icons.settings_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: controller.bottomBarPages[controller.selectedIndex.value],
          extendBody: true,
          bottomNavigationBar: BottomBarInspiredOutside(
            items: items,
            iconSize: 25,
            backgroundColor: AppColor.appcolor,
            color: AppColor.white,
            colorSelected: AppColor.white,
            indexSelected: controller.selectedIndex.value,
            onTap: controller.changeTab,
            animated: true,
            itemStyle: ItemStyle.circle,
            chipStyle: const ChipStyle(
              background: AppColor.appcolor,
              notchSmoothness: NotchSmoothness.sharpEdge,
            ),
          ),
          /*bottomNavigationBar: AnimatedNotchBottomBar(
        notchColor: Colors.red,
        bottomBarWidth: 10,
        color: AppColor.appColor,
        bottomBarItems: const [
          BottomBarItem(
            inActiveItem: Icon(Icons.home),
            activeItem: Icon(Icons.home_filled),
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.favorite_outline,
              color: Colors.white,
            ),
            activeItem: Icon(
              Icons.favorite,
              color: Colors.white,
            ),
          ),

          ///svg item
          BottomBarItem(
            inActiveItem: Icon(
              Icons.chat_bubble_outline,
              color: Colors.white,
            ),
            activeItem: Icon(Icons.message),
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.person_outline,
              color: Colors.white,
            ),
            activeItem: Icon(Icons.person),
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.settings_outlined,
              color: Colors.white,
            ),
            activeItem: Icon(Icons.search),
            // itemLabel: 'Page 3',
          ),
        ],
        onTap: (index) {
          // controller.notchBottomBarController.jumpTo(index);
        },
        notchBottomBarController: controller.notchBottomBarController,
      )),*/
        ));
  }

  getPage(int index) {
    switch (index) {
      case 0:
        {
          return HomeScreen();
        }

      case 1:
        {
          return FavouriteScreen();
        }

      case 2:
        {
          return NavBarMsgScreen();
        }
      case 3:
        {
          return SettingScreen();
        }

      default:
        {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Welcome"),
            ),
          );
        }
    }
  }
}
