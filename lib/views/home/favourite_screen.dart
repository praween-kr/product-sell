import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_controller/home/home_controller.dart';
import 'package:oninto_flutter/common_widget/color_constant.dart';
import 'package:oninto_flutter/routes/routes.dart';
import 'package:oninto_flutter/utills/common_appbar.dart';

import '../../generated/assets.dart';

class FavouriteScreen extends StatelessWidget {
  FavouriteScreen({super.key});
  final Homecontroller controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          children: [
            const Center(
              child: AppText(
                text: "My Favourite",
                textSize: 20,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500,
              ),
            ),
            Expanded(
              child: GridView.builder(
                  physics: const ClampingScrollPhysics(),
                  padding: const EdgeInsets.only(
                    top: 20,
                  ),
                  // padding:
                  //     const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.1,
                      crossAxisSpacing: 2),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    //  var data = controller.Categorydata[index];
                    return GestureDetector(
                      onTap: () {
                        //controller.sub.value = false;
                        //controller.menu.value = false;
                        Get.toNamed(Routes.menshirtScreen);
                      },
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                                bottom: 10, left: 20, right: 20, top: 7),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset(
                                      Assets.assetsGirlJean,
                                      fit: BoxFit.cover,
                                      height: 150,
                                      width: 150,
                                    ),
                                  ),
                                  Positioned(
                                      right: 5,
                                      top: 5,
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle),
                                        child: const Icon(
                                          Icons.favorite,
                                          color: AppColor.appcolor,
                                          size: 20,
                                        ),
                                      )),
                                ]),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
