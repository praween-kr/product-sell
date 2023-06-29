import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_controller/bottom_nav_controller.dart';
import 'package:oninto_flutter/common_widget/color_constant.dart';
import 'package:oninto_flutter/routes/routes.dart';
import 'package:oninto_flutter/views/home/home_screen.dart';

class BottomScreen extends StatelessWidget {
  BottomScreen({Key? key}) : super(key: key);
  final controller = Get.put(BottomNavController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
          body: getPage(controller.selectedIndex.value),
          extendBody: true,
          bottomNavigationBar: AnimatedNotchBottomBar(
            notchColor: Colors.red,
            bottomBarWidth: 10,
            color: AppColor.appcolor,
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
          )),
    );
  }

  getPage(int index) {
    switch (index) {
      case 0:
        {
          return HomeScreen();
        }

      case 1:
        {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Page 2"),
            ),
          );
        }

      case 2:
        {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Page 3"),
            ),
          );
        }
      case 3:
        {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Page 4"),
            ),
          );
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
