import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_widget/appbar.dart';
import 'package:oninto_flutter/common_widget/color_constant.dart';
import 'package:oninto_flutter/utills/common_appbar.dart';
import 'package:oninto_flutter/views/settings/payments/setting_payment_controller.dart';
import '../../../generated/assets.dart';
import '../../../utills/colors_file.dart';

class SettingPaymentScreen extends StatelessWidget {
   SettingPaymentScreen({super.key});
  final controller = Get.put(SettingPaymentController());

  @override
  Widget build(BuildContext context) {
    var dim = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: CommonAppbarWidget(
        heading: "Payments",
        textStyle: const TextStyle(
        fontSize: 20,
        color: blackColor,
        fontWeight: FontWeight.w500,
        fontFamily: "Poppins"
      ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30.0,),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 20.0),
                  decoration: BoxDecoration(
                    color: AppColor.appcolor,
                    borderRadius: BorderRadius.circular(6.0)
                  ),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: AppText(
                      text: "John Smith",
                      textSize: 12.0,
                      style: AppTextStyle.regular,
                      color: AppColor.white,
                    ),
                  ),
                ),
                const SizedBox(height: 12.0,),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 15.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColor.blackColor
                      ),
                      borderRadius: BorderRadius.circular(6.0)
                  ),
                  child: const Center(
                    child:AppText(
                      text: "Add New Card",
                    ),
                  ),
                ),
                const SizedBox(height: 15.0,),
               const AppText(
                  text: "Saved Cards",
                  textSize: 12.0,
                  style: AppTextStyle.medium,
                  color: AppColor.blackColor,
                ),
                const SizedBox(height: 15.0,),
                SizedBox(
                  height: 95,
                  child: ListView.builder(
                      itemCount: 3,
                    //shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index){
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Image.asset(Assets.assetsGirlJean,
                          ),
                        );
                      }
                      ),
                ),
                const SizedBox(height: 20.0,),
              ],
            ),
          ),
          Expanded(
            child: Container(
              //width: dim.width,
              padding: EdgeInsets.only(
              top: dim.height * 0.04,
              left: dim.width * 0.10,
              right: dim.width * 0.10),
              decoration: const BoxDecoration(
              color: AppColor.appcolor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
              )
              ),
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppText(
                text: "Transactions",
                textSize: 15.0,
                style: AppTextStyle.medium,
                color: AppColor.white,
              ),
              const SizedBox(height: 20.0,),
              ListView.builder(
                  itemCount: 2,
                  shrinkWrap: true,
                  itemBuilder: (context, position) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 29.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset(Assets.assetsGirlJean,
                                height: 100.0,width: 80.0,
                              ),
                              const SizedBox(width: 10.0,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const AppText(
                                    text: "Men T-shirt",
                                    textSize: 16.0,
                                    style: AppTextStyle.regular,
                                    color: AppColor.white,
                                  ),
                                  const SizedBox(height: 1.0,),
                                  const Row(
                                    children: [
                                      Icon(Icons.location_on,
                                        size: 15.0, color: AppColor.white,
                                      ),
                                      SizedBox(width: 5.0,),
                                      AppText(
                                        text: "Elberta, Canada",
                                        textSize: 10.0,
                                        style: AppTextStyle.regular,
                                        color: AppColor.white,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 3.0,),
                                  const AppText(
                                    text: "June 19, 2022 | 9:15AM",
                                    textSize: 10.0,
                                    style: AppTextStyle.small,
                                    color: AppColor.white,
                                  ),
                                  const SizedBox(height: 11.0,),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 6.0),
                                    decoration: BoxDecoration(
                                      color: AppColor.blackColor,
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: const Center(
                                      child: AppText(
                                        text: "\$5000",
                                        textSize: 10.0,
                                        style: AppTextStyle.small,
                                        color: AppColor.white,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  }
              ),
            ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
