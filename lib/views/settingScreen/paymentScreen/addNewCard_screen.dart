import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:oninto_flutter/utils/app_text.dart';
import '../../../utils/app_text_field.dart';
import '../../../utils/appbar.dart';
import '../../../utils/color_constant.dart';
import '../../../utils/common_button.dart';

class AddNewCardScreen extends StatelessWidget {
  const AddNewCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      resizeToAvoidBottomInset: false,
      appBar: const CommonAppbarWidget
        (heading: "Add New Account",
        textStyle: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w500, color: AppColor.blackColor),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppText(
              text: "Account Name",
              color: AppColor.blackColor,
              textSize: 13.0,
              style: AppTextStyle.medium,
            ),
            const SizedBox(
              height: 14.0,
            ),
            AppTextField(
              height: 46.0,
              title: "Enter Name",
              keyBoardType: TextInputAction.next,
              textInputType: TextInputType.name,
              margin: const EdgeInsets.only(right: 0.0),
              borderRadius: BorderRadius.circular(23),
              containerColor: AppColor.textColor,
            ),
            const SizedBox(
              height: 16.0,
            ),
            const AppText(
              text: "Bank Name",
              color: AppColor.blackColor,
              textSize: 13.0,
              style: AppTextStyle.medium,
            ),
            const SizedBox(
              height: 14.0,
            ),
            AppTextField(
              height: 46.0,
              title: "Enter Bank Name",
              keyBoardType: TextInputAction.next,
              textInputType: TextInputType.name,
              margin: const EdgeInsets.only(right: 0.0),
              borderRadius: BorderRadius.circular(23),
              containerColor: AppColor.textColor,
            ),
            const SizedBox(
              height: 16.0,
            ),
            const AppText(
              text: "Short Code",
              color: AppColor.blackColor,
              textSize: 13.0,
              style: AppTextStyle.medium,
            ),
            const SizedBox(
              height: 14.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    margin: EdgeInsets.zero,
                    decoration: const BoxDecoration(
                        color: AppColor.textColor,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child:   IntrinsicHeight (
                      child: Row(
                        children: [
                          AppTextField(
                            height: 46.0,width: 50,
                            keyBoardType: TextInputAction.next,
                            textInputType: TextInputType.number,
                            margin: const EdgeInsets.only(right: 0.0),
                            borderRadius: BorderRadius.circular(23),
                            containerColor: AppColor.textColor,
                          ),
                          const VerticalDivider(
                            color: Colors.grey,width: 2,
                          ),
                          AppTextField(
                            height: 46.0,width: 50,
                            keyBoardType: TextInputAction.next,
                            textInputType: TextInputType.number,
                            margin: const EdgeInsets.only(right: 0.0),
                            borderRadius: BorderRadius.circular(23),
                            containerColor: AppColor.textColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                Container(
                  margin: EdgeInsets.zero,
                  decoration: const BoxDecoration(
                      color: AppColor.textColor,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child:   IntrinsicHeight (
                    child: Row(
                      children: [
                        AppTextField(
                          height: 46.0,width: 50,
                          keyBoardType: TextInputAction.next,
                          textInputType: TextInputType.number,
                          margin: const EdgeInsets.only(right: 0.0),
                          borderRadius: BorderRadius.circular(23),
                          containerColor: AppColor.textColor,
                        ),
                        const VerticalDivider(
                          color: Colors.grey,width: 2,
                        ),
                        AppTextField(
                          height: 46.0,width: 50,
                          keyBoardType: TextInputAction.next,
                          textInputType: TextInputType.number,
                          margin: const EdgeInsets.only(right: 0.0),
                          borderRadius: BorderRadius.circular(23),
                          containerColor: AppColor.textColor,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  decoration: const BoxDecoration(
                      color: AppColor.textColor,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child:   IntrinsicHeight (
                    child: Row(
                      children: [
                        AppTextField(
                          height: 46.0,width: 50,
                          keyBoardType: TextInputAction.next,
                          textInputType: TextInputType.number,
                          margin: const EdgeInsets.only(right: 0.0),
                          borderRadius: BorderRadius.circular(23),
                          containerColor: AppColor.textColor,
                        ),
                        const VerticalDivider(
                          color: Colors.grey,width: 2,
                        ),
                        AppTextField(
                          height: 46.0,width: 50,
                          keyBoardType: TextInputAction.next,
                          textInputType: TextInputType.number,
                          margin: const EdgeInsets.only(right: 0.0),
                          borderRadius: BorderRadius.circular(23),
                          containerColor: AppColor.textColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16.0,
            ),
            const AppText(
              text: "Account Number",
              color: AppColor.blackColor,
              textSize: 13.0,
              style: AppTextStyle.medium,
            ),
            const SizedBox(
              height: 14.0,
            ),
            Pinput(
              length: 11,
              defaultPinTheme: PinTheme(
                  height: 46,
                  width: 80,
                  decoration: BoxDecoration(
                      color: AppColor.textColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColor.textColor, width: 2))),
            ),
            const SizedBox(
              height: 30.0,
            ),
            GestureDetector(
              onTap: () {
                Get.back();
              },
        child: const CommonButton(
                height: 50,
                radius: 15,
                margin: EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                text: "Add Account",
                textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w400),
                color: AppColor.appColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
