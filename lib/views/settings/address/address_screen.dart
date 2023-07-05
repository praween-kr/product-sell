import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_widget/appbar.dart';
import 'package:oninto_flutter/common_widget/color_constant.dart';
import 'package:oninto_flutter/generated/assets.dart';
import 'package:oninto_flutter/routes/routes.dart';
import '../../../common_widget/common_button.dart';
import '../../../utills/colors_file.dart';
import '../../../utills/common_appbar.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

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
          ListView.builder(
              itemCount: 3,
              shrinkWrap: true,
              itemBuilder: (context, position) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 20.0),
                  margin: const EdgeInsets.fromLTRB(29, 30, 29, 10),
                  decoration: BoxDecoration(
                      color: AppColor.white,
                      border: Border.all(
                          color: AppColor.borderColor.withOpacity(0.3),
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
                );
              }),
          const SizedBox(
            height: 40.0,
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.addressScreen);
            },
            child: CommonButton(
              color: AppColor.appcolor,
              margin: const EdgeInsets.only(right: 30, left: 30),
              height: 57,
              text: "Add New Address",
              textStyle: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}
