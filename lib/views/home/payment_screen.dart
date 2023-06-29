import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_widget/appbar.dart';
import 'package:oninto_flutter/common_widget/common_button.dart';
import 'package:oninto_flutter/generated/assets.dart';
import 'package:oninto_flutter/routes/routes.dart';
import 'package:oninto_flutter/utills/colors_file.dart';
import 'package:oninto_flutter/utills/common_appbar.dart';

import '../../common_widget/color_constant.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonAppbarWidget(
              heading: "Pay Now",
              textStyle: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w500, color: blackColor),
              leading: const Icon(Icons.arrow_back, color: blackColor),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: "Payment Method",
                    textSize: 16,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 20, left: 20, top: 10),
              padding: const EdgeInsets.all(10),
              width: Get.width,
              decoration: BoxDecoration(
                color: const Color(0xffE7F9F5),
                borderRadius: BorderRadius.circular(10),
                // boxShadow: const [
                //   BoxShadow(
                //       offset: Offset(
                //         3.0,
                //         3.0,
                //       ),
                //       blurRadius: 6.0,
                //       color: Color(0xff29000000)),
                // ] //BoxShadow
              ),
              child: Stack(children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            Assets.assetjean,
                            height: 20,
                            width: 20,
                          ),
                          const AppText(
                            text: "**** **** **** 1234",
                            textSize: 12,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400,
                          ),
                          Spacer(),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(20)),
                            child: Icon(
                              Icons.done,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      const AppText(
                        text: "Edit | Delete",
                        textSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff333333),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
            Container(
              margin: const EdgeInsets.only(right: 20, left: 20, top: 10),
              padding: const EdgeInsets.all(10),
              width: Get.width,
              decoration: BoxDecoration(
                color: const Color(0xffF5F8FB),
                borderRadius: BorderRadius.circular(10),
                // boxShadow: const [
                //   BoxShadow(
                //       offset: Offset(
                //         3.0,
                //         3.0,
                //       ),
                //       blurRadius: 6.0,
                //       color: Color(0xff29000000)),
                // ] //BoxShadow
              ),
              child: Stack(children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            Assets.assetcredit,
                            height: 20,
                            width: 20,
                          ),
                          const AppText(
                            text: "**** **** **** 1234",
                            textSize: 12,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400,
                          ),
                          Spacer(),
                          CircleAvatar(
                            radius: 14,
                            backgroundColor: Color(0xffE5E5E5),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      const AppText(
                        text: "Edit | Delete",
                        textSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff333333),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: DottedBorder(
                borderPadding: EdgeInsets.only(top: 20),
                borderType: BorderType.RRect,
                radius: Radius.circular(12),
                padding: EdgeInsets.only(top: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  child: Container(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        child: AppText(
                          text: '+ Add New Card',
                          fontWeight: FontWeight.w600,
                          fontFamily: "Poppins",
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(Routes.productScreen);
              },
              child: CommonButton(
                height: 50,
                radius: 15,
                margin: const EdgeInsets.only(left: 20, right: 20, top: 80),
                text: "Pay Now",
                textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w400),
                color: AppColor.appcolor,
              ),
            ),
          ],
        ));
  }
}
