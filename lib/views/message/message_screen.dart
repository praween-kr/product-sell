import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_controller/home_controller.dart';
import 'package:oninto_flutter/common_widget/color_constant.dart';
import 'package:oninto_flutter/generated/assets.dart';
import 'package:oninto_flutter/utills/common_appbar.dart';

class MessageScreen extends StatelessWidget {
   MessageScreen({super.key});
  final controller = Get.put(Homecontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const AppText(
          text: "Message",
          textSize: 20.0,
          color: AppColor.blackColor,
          style: AppTextStyle.title,
        ),
        centerTitle: true,
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Obx(() => TabBar(
                splashFactory: NoSplash.splashFactory,
                overlayColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                      // Use the default focused overlay color
                      return states.contains(MaterialState.focused)
                          ? null
                          : Colors.transparent;
                    }),
                onTap: (index) {
                  controller.tabController.value = index;
                },
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                indicator:
                BoxDecoration(borderRadius: BorderRadius.circular(20)),
                // indicatorColor: Colors.grey,
                // labelColor: Colors.black,
                // unselectedLabelColor: Colors.grey,
                indicatorWeight: 1,
                tabs: [
                  Container(
                    height: 42,
                    width: 148,
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                        color: controller.tabController.value == 0
                            ? AppColor.appcolor
                            : Colors.white,
                        border: Border.all(
                          color: controller.tabController.value == 0
                              ? AppColor.appcolor
                              : Colors.grey.shade300,
                        ),
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: AppText(
                        text: "Community",
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w400,
                        color: controller.tabController.value == 0
                            ? Colors.white
                            : Colors.grey.shade500,
                      ),
                    ),
                  ),
                  Container(
                    height: 42,
                    width: 148,
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                        color: controller.tabController.value == 1
                            ? AppColor.appcolor
                            : Colors.white,
                        border: Border.all(
                          color: controller.tabController.value == 1
                              ? AppColor.appcolor
                              : Colors.grey.shade300,
                        ),
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: AppText(
                        text: "Messages",
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w400,
                        color: controller.tabController.value == 1
                            ? Colors.white
                            : Colors.grey.shade500,
                      ),
                    ),
                  ),
                ])),
            Expanded(
              child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                   ListView.builder(
                       itemBuilder: (context, index){
                         return Row(
                           children: [
                            Image.asset(Assets.assetsCrowd)
                         ],
                         );
                       }
                       )
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
