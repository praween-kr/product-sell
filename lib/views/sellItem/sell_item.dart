import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_controller/home_controller.dart';
import 'package:oninto_flutter/common_widget/appbar.dart';
import 'package:oninto_flutter/common_widget/color_constant.dart';
import 'package:oninto_flutter/generated/assets.dart';
import 'package:oninto_flutter/utills/colors_file.dart';

import '../../utills/common_appbar.dart';

class SellItem extends StatelessWidget {
   SellItem({super.key});
  final controller = Get.put(Homecontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbarWidget(
        heading: "Sell an Item",
        textStyle: const TextStyle(
            fontSize: 20,
            color: blackColor,
            fontWeight: FontWeight.w500,
            fontFamily: "Poppins"),
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
                        text: "Physical Product",
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
                        text: "Co-Owner",
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
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 20.0),
                          decoration: BoxDecoration(
                            color:AppColor.text1.withOpacity(0.1) ,
                            borderRadius: BorderRadius.circular(17.0)
                          ),
                          child: const Center(
                            child: Icon(Icons.camera_alt,
                            size: 20.0,color: AppColor.forgotText,
                            ),
                          ),
                        ),
                        const SizedBox(height: 14.0,),
                        ListView.builder(
                          itemCount: 4,
                          itemBuilder: (context, position){
                            return Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0,
                                  vertical: 5.0),
                              decoration: BoxDecoration(
                                  color:AppColor.text1.withOpacity(0.1) ,
                                  borderRadius: BorderRadius.circular(17.0)
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.camera_alt,
                                    size: 20.0,color: AppColor.forgotText,
                                  ),
                                  AppText(text: "JPEG",
                                    color: AppColor.blackColor.withOpacity(0.3),
                                    textSize: 10.0,
                                    style: AppTextStyle.regular,
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: 4,
                          shrinkWrap: true,
                          itemBuilder: (context, position){
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 35.0,
                                      vertical: 15.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              Image.asset(Assets.assetsGirlJean,
                                                height: 57.0,width: 57.0,
                                              ),
                                              const SizedBox(width: 12.0,),
                                              Column(
                                                children: [
                                                  const AppText(
                                                    text: "Men Tshirt",
                                                    textSize: 15.0,
                                                    color: AppColor.blackColor,
                                                    style: AppTextStyle.title,
                                                  ),
                                                  const SizedBox(height: 7.0,),
                                                  AppText(
                                                    text: "Send Images",
                                                    textSize: 12.0,
                                                    color: AppColor.blackColor.withOpacity(0.3),
                                                    style: AppTextStyle.medium,
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 10.0,
                                                    vertical: 10.0),
                                                decoration: const BoxDecoration(
                                                  color: AppColor.appcolor,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Center(
                                                  child: AppText(
                                                    text: "2",
                                                    color: AppColor.white,
                                                    textSize: 10.0,
                                                    style: AppTextStyle.regular,
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),

                                    ],
                                  ),
                                ),
                                Divider(
                                  color: AppColor.blackColor.withOpacity(0.1),
                                  height: 1.0,thickness: 1.0,
                                )
                              ],
                            );
                          }
                      ),
                    )
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
