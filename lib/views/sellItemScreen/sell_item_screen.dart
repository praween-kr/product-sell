import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_controller/product/sellItem_controller.dart';
import 'package:oninto_flutter/common_widget/app_textfield.dart';
import 'package:oninto_flutter/common_widget/appbar.dart';
import 'package:oninto_flutter/common_widget/color_constant.dart';
import 'package:oninto_flutter/common_widget/common_button.dart';
import 'package:oninto_flutter/utills/colors_file.dart';

import '../../routes/routes.dart';
import '../../utills/common_appbar.dart';

class SellItemScreen extends StatelessWidget {
  SellItemScreen({super.key});
  final SellItemController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: CommonAppbarWidget(
        heading: "Sell an Item",
        textStyle: const TextStyle(
            fontSize: 20,
            color: blackColor,
            fontWeight: FontWeight.w500,
            fontFamily: "Poppins"),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Obx(
            () => Row(
              children: [
                Expanded(
                  flex: 1,
                  child: tabButton(
                    title: "Physical Product",
                    selected: controller.tabController.value == 0,
                    onClick: () {
                      controller.tabController.value = 0;
                    },
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  flex: 1,
                  child: tabButton(
                    title: "Co-Owner",
                    selected: controller.tabController.value == 1,
                    onClick: () {
                      controller.tabController.value = 1;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 80.0),
                    decoration: BoxDecoration(
                        color: AppColor.text1.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(17.0)),
                    child: GestureDetector(
                      onTap: () {},
                      child: Center(
                        child: Icon(
                          Icons.camera_alt,
                          size: 35.0,
                          color: AppColor.blackColor.withOpacity(0.3),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14.0),
                  SizedBox(
                    height: 70.0,
                    child: ListView.builder(
                      itemCount: 4,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, position) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 23.0),
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                              color: AppColor.text1.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(17.0)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.camera_alt,
                                size: 22.0,
                                color: AppColor.blackColor.withOpacity(0.3),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              AppText(
                                text: "JPEG",
                                color: AppColor.blackColor.withOpacity(0.3),
                                textSize: 10.0,
                                style: AppTextStyle.regular,
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 19.0),
                  GestureDetector(
                    onTap: () {},
                    child: CommonButton(
                        color: AppColor.appcolor,
                        radius: 25,
                        margin: const EdgeInsets.only(right: 0),
                        height: 57,
                        text: "Add more",
                        textStyle:
                            const TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                  const SizedBox(height: 23.0),
                  const AppText(
                      text: "Add Title",
                      color: AppColor.blackColor,
                      textSize: 13.0,
                      style: AppTextStyle.medium),
                  const SizedBox(height: 14),
                  AppTextField(
                      height: 46.0,
                      title: "Add",
                      //contentPadding: const EdgeInsets.only(top: 8.0,left: 13.0),
                      margin: const EdgeInsets.only(right: 0.0),
                      borderRadius: BorderRadius.circular(23),
                      containerColor: AppColor.TextColor),
                  const SizedBox(height: 16.0),
                  const AppText(
                      text: "Location",
                      color: AppColor.blackColor,
                      textSize: 13.0,
                      style: AppTextStyle.medium),
                  const SizedBox(height: 14.0),
                  AppTextField(
                    height: 46.0,
                    title: "Add",
                    //contentPadding: const EdgeInsets.only(top: 8.0,left: 13.0),
                    margin: const EdgeInsets.only(right: 0.0),
                    borderRadius: BorderRadius.circular(23),
                    containerColor: AppColor.TextColor,
                    suffix: const Icon(Icons.my_location,
                        size: 18.0, color: AppColor.appcolor),
                  ),
                  const SizedBox(height: 16.0),
                  const AppText(
                      text: "Shares",
                      color: AppColor.blackColor,
                      textSize: 13.0,
                      style: AppTextStyle.medium),
                  const SizedBox(height: 14.0),
                  AppTextField(
                    height: 46.0,
                    title: "50",
                    //contentPadding: const EdgeInsets.only(top: 8.0,left: 13.0),
                    margin: const EdgeInsets.only(right: 0.0),
                    borderRadius: BorderRadius.circular(23),
                    containerColor: AppColor.TextColor,
                  ),
                  const SizedBox(height: 16.0),
                  const AppText(
                    text: "Base Price",
                    color: AppColor.blackColor,
                    textSize: 13.0,
                    style: AppTextStyle.medium,
                  ),
                  const SizedBox(height: 14.0),
                  AppTextField(
                    height: 46.0,
                    title: "Enter Price",
                    //contentPadding: const EdgeInsets.only(top: 8.0,left: 13.0),
                    margin: const EdgeInsets.only(right: 0.0),
                    borderRadius: BorderRadius.circular(23),
                    containerColor: AppColor.TextColor,
                  ),
                  const SizedBox(height: 16.0),
                  const AppText(
                    text: "Description",
                    color: AppColor.blackColor,
                    textSize: 13.0,
                    style: AppTextStyle.medium,
                  ),
                  const SizedBox(height: 14.0),
                  Container(
                    decoration: const BoxDecoration(
                      color: AppColor.TextColor,
                      borderRadius: BorderRadius.all(Radius.circular(23)),
                    ),
                    child: TextFormField(
                      minLines: 8,
                      maxLines: null,
                      cursorColor: AppColor.blackColor,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        counterText: "",
                        hintText: "Write here...",
                        contentPadding:
                            const EdgeInsets.only(left: 20, top: 20),
                        hintStyle:
                            TextStyle(color: Colors.black.withOpacity(0.4)),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 31.0),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.subscriptionScreen);
                    },
                    child: CommonButton(
                      color: AppColor.TextColor,
                      height: 57,
                      radius: 23,
                      text: "Boost your post",
                      textStyle: TextStyle(
                          color: AppColor.blackColor.withOpacity(0.3),
                          fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 31.0),
                  GestureDetector(
                    onTap: () async {
                      await controller.addSellItem();
                      // customDialog(context, () {
                      //   Get.toNamed(Routes.productScreen, arguments: 2);
                      // });
                    },
                    child: CommonButton(
                      color: AppColor.appcolor,
                      height: 57,
                      text: "Submit",
                      textStyle:
                          const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Widget tabButton(
      {required String title,
      bool selected = false,
      required Function onClick}) {
    return GestureDetector(
      onTap: () => onClick(),
      child: Container(
        width: Get.width * 0.45,
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
            color: selected ? AppColor.appcolor : Colors.white,
            border: Border.all(
              color: selected ? AppColor.appcolor : Colors.grey.shade300,
            ),
            borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: AppText(
            text: title,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w400,
            color: selected ? Colors.white : Colors.grey.shade500,
          ),
        ),
      ),
    );
  }

  ///Start and End Date View
  // Widget columnData(BuildContext context) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       const AppText(
  //         text: "Start Date",
  //         color: AppColor.blackColor,
  //         textSize: 13.0,
  //         style: AppTextStyle.medium,
  //       ),
  //       const SizedBox(
  //         height: 16.0,
  //       ),
  //       AppTextField(
  //         readOnly: true,
  //         controller: controller.startDateController,
  //         height: 46.0,
  //         title: "Start Date",
  //         hintStyle: const TextStyle(color: AppColor.blackColor, fontSize: 13),
  //         //contentPadding: const EdgeInsets.only(top: 8.0,left: 13.0),
  //         margin: const EdgeInsets.only(right: 0.0),
  //         borderRadius: BorderRadius.circular(23),
  //         containerColor: AppColor.TextColor,
  //         suffix: IconButton(
  //             onPressed: () => controller.pickDate(context, 0),
  //             icon: Icon(
  //               Icons.calendar_month_outlined,
  //               size: 16,
  //               color: AppColor.blackColor.withOpacity(0.3),
  //             )),
  //       ),
  //       const SizedBox(
  //         height: 14.0,
  //       ),
  //       const AppText(
  //         text: "End Date",
  //         color: AppColor.blackColor,
  //         textSize: 13.0,
  //         style: AppTextStyle.medium,
  //       ),
  //       const SizedBox(
  //         height: 16.0,
  //       ),
  //       AppTextField(
  //         controller: controller.endDateController,
  //         readOnly: true,
  //         height: 46.0,
  //         title: "End Date",
  //         hintStyle: const TextStyle(color: AppColor.blackColor, fontSize: 13),
  //         //contentPadding: const EdgeInsets.only(top: 8.0,left: 13.0),
  //         margin: const EdgeInsets.only(right: 0.0),
  //         borderRadius: BorderRadius.circular(23),
  //         containerColor: AppColor.TextColor,
  //         suffix: IconButton(
  //             onPressed: () => controller.pickDate(context, 2),
  //             icon: Icon(
  //               Icons.calendar_month_outlined,
  //               size: 16,
  //               color: AppColor.blackColor.withOpacity(0.3),
  //             )),
  //       ),
  //       const SizedBox(
  //         height: 29.0,
  //       ),
  //     ],
  //   );
  // }

  /// DialogBox View
  customDialog(BuildContext context, Function okClick) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Material(
              type: MaterialType.transparency,
              child: Align(
                //alignment: Alignment.center,
                child: Container(
                  height: 250.0, width: 300.0,
                  //padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                  decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(25)),
                  child: Stack(alignment: Alignment.bottomCenter, children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Column(
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 25.0),
                            decoration: const BoxDecoration(
                                color: AppColor.appcolor,
                                shape: BoxShape.circle),
                            child: const Center(
                              child: Icon(
                                Icons.check,
                                color: AppColor.white,
                                size: 35,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 17.0,
                          ),
                          const AppText(
                            text:
                                "Your product has been submitted successfully!",
                            textSize: 15,
                            color: AppColor.blackColor,
                            style: AppTextStyle.medium,
                            lineHeight: 1.4,
                            letterSpacing: 0.2,
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 21.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        okClick();
                        //Get.toNamed(Routes.productScreen);
                      },
                      child: CommonButton(
                        color: AppColor.appcolor,
                        radius: 25,
                        //  margin: const EdgeInsets.only(right: 30),
                        height: 57,
                        text: "Ok",
                        textStyle:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    )
                  ]),
                ),
              ));
        });
  }
}
