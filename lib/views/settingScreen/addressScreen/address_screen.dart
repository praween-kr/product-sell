import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_controller/settings/address_controller.dart';
import 'package:oninto_flutter/common_widget/appbar.dart';
import 'package:oninto_flutter/common_widget/color_constant.dart';
import 'package:oninto_flutter/generated/assets.dart';
import 'package:oninto_flutter/routes/routes.dart';

import '../../../common_widget/common_button.dart';
import '../../../utills/colors_file.dart';
import '../../../utills/common_appbar.dart';

class AddressScreen extends StatelessWidget {
  AddressScreen({super.key});
  // final controller = Get.put(AddressController());
  final AddressController addressController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: CommonAppbarWidget(
        heading: "Addresses",
        textStyle: const TextStyle(
            fontSize: 20,
            color: blackColor,
            fontWeight: FontWeight.w500,
            fontFamily: "Poppins"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: 3,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // controller.selectedContainer.value = index;
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 20.0),
                      margin: const EdgeInsets.fromLTRB(29, 30, 29, 10),
                      decoration: BoxDecoration(
                          color: AppColor.white,
                          border: Border.all(
                              color:
                                  // controller.selectedContainer.value ==
                                  //         index
                                  //     ? AppColor.appcolor
                                  // :
                                  AppColor.borderColor.withOpacity(0.3),
                              width: 1.0),
                          borderRadius: BorderRadius.circular(13.0)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const AppText(
                                text: "Office",
                                style: AppTextStyle.title,
                                textSize: 15.0,
                                color: AppColor.blackColor,
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              AppText(
                                text: "Rio Nakowskic, NZ",
                                style: AppTextStyle.medium,
                                textSize: 13.0,
                                color: AppColor.blackColor.withOpacity(0.3),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              AppText(
                                text: "+1-0000-0000",
                                style: AppTextStyle.medium,
                                textSize: 12.0,
                                color: AppColor.blackColor.withOpacity(0.3),
                              ),
                            ],
                          ),
                          Image.asset(
                            Assets.assetsLocationImage,
                            height: 61.0,
                            width: 61.0,
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 35.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.settingPaymentScreen);
                  },
                  child: CommonButton(
                    color: AppColor.appcolor,
                    margin: const EdgeInsets.only(right: 30.0, left: 30.0),
                    height: 57,
                    text: "Pay Now",
                    textStyle:
                        const TextStyle(color: Colors.white, fontSize: 15),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 35.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.newAddressScreen);
                  },
                  child: CommonButton(
                    color: AppColor.appcolor,
                    margin: const EdgeInsets.only(right: 30.0, left: 30.0),
                    height: 57,
                    text: "Add New Address",
                    textStyle:
                        const TextStyle(color: Colors.white, fontSize: 15),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
