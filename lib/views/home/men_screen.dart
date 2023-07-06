import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_controller/home_controller.dart';
import 'package:oninto_flutter/common_widget/app_text.dart';
import 'package:oninto_flutter/common_widget/appbar.dart';
import 'package:oninto_flutter/routes/routes.dart';

import '../../common_controller/bottom_nav_controller.dart';

class MenScreen extends StatelessWidget {
  MenScreen({super.key});
  final controller = Get.put(Homecontroller());
  final bottomcontroller = Get.put(BottomNavController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            CommonAppbarWidget(
              heading: "Men",
            ),
            Expanded(
              child: GridView.builder(
                  physics: const ClampingScrollPhysics(),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, childAspectRatio: 0.75),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    var data = controller.Categorydata[index];
                    return GestureDetector(
                      onTap: () {
                        controller.menu.value = true;
                        Get.offAndToNamed(
                          Routes.bottomScreen,
                        );
                      },
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            padding: const EdgeInsets.only(
                                top: 15, bottom: 15, left: 20, right: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: Colors.grey, width: 1)),
                            child: Image.asset(
                              data.image,
                              fit: BoxFit.contain,
                              height: 70,
                              width: 50,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          AppText(
                            text: controller.Categorydata[index].Name,
                            color: Colors.black,
                            textSize: 14,
                          )
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
