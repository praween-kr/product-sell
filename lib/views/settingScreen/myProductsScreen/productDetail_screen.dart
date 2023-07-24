import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/generated/assets.dart';

import '../../../common_widget/app_text.dart';
import '../../../common_widget/appbar.dart';
import '../../../common_widget/color_constant.dart';
import '../../../common_widget/common_button.dart';
import '../../../routes/routes.dart';
import '../../../utills/colors_file.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: CommonAppbarWidget(
        leading: GestureDetector(
          onTap: (){
            Get.back();
          },
          child: Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.only(left: 12),
            decoration: BoxDecoration(
                color: AppColor.appcolor,
                borderRadius: BorderRadius.circular(15)),
            child: const Icon(Icons.arrow_back_ios),
          ),
        ),
        heading: "Samsung Note 10",
        textStyle: const TextStyle(
            fontSize: 20,
            color: blackColor,
            fontWeight: FontWeight.w500,
            fontFamily: "Poppins"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0,bottom: 30.0),
          child: Column(
            children: [
              Stack(
                children: [
                  Image.asset(Assets.assetsPhoneImage,
                fit: BoxFit.fill,width: Get.width,
                ),
                  Positioned(
                    left: 20,
                    top: MediaQuery.of(context).size.height * 0.30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(Assets.assetsPhoneBack,
                            height: 80, width: 80,
                          ),
                          const SizedBox(width: 10,),
                          Image.asset(Assets.assetsPhoneFront,
                            height: 80,
                            width: 80,
                          ),
                          const SizedBox(width: 10,),
                          Image.asset(Assets.assetsMobile,
                            height: 80,
                            width: 80,
                          ),
                        ],
                      ),
                  )
                ]
              ),
              Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0,right: 30.0,top: 15.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                 Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     const AppText(
                                       text: "Jenny Johnson",
                                       textSize: 17.0,
                                       color: AppColor.appcolor,
                                       style: AppTextStyle.medium,
                                     ),
                                     const SizedBox(height: 10,),
                                     const AppText(
                                       text: "Samsung Note 10",
                                       textSize: 15.0,
                                       color: AppColor.blackColor,
                                       style: AppTextStyle.medium,
                                     ),
                                     const SizedBox(height: 10,),
                                     const AppText(
                                       text: "\$2000",
                                       textSize: 23.0,
                                       color: AppColor.appcolor,
                                       style: AppTextStyle.title,
                                     ),
                                     const SizedBox(height: 5,),
                                     AppText(
                                       text: "Inclusive of all taxes",
                                       textSize: 10.0,
                                       color: AppColor.blackColor.withOpacity(0.3),
                                       style: AppTextStyle.regular,
                                     ),
                                   ],
                                 ),
                                ],
               ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      const Icon(Icons.favorite,color: AppColor.appcolor,),
                                      const SizedBox(height: 5,),
                                      AppText(
                                        text: "12",
                                        textSize: 15.0,
                                        color: AppColor.blackColor.withOpacity(0.3),
                                        style: AppTextStyle.regular,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 20,),
                                  Column(
                                    children: [
                                      const Icon(Icons.visibility,color: AppColor.appcolor,),
                                      const SizedBox(height: 5,),
                                      AppText(
                                        text: "199",
                                        textSize: 15.0,
                                        color: AppColor.blackColor.withOpacity(0.3),
                                        style: AppTextStyle.regular,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 20,),
                          commonText("Category", "Electronic"),
                          const SizedBox(height: 10,),
                          commonText("Sub Category", "Mobile"),
                          const SizedBox(height: 10,),
                          commonText("Color", "Golden"),
                          const SizedBox(height: 10,),
                          commonText("Brand", "Samsung"),
                          //const SizedBox(height: 20,),

                        ],
                      ),
                    ),
                    Divider(
                      color: AppColor.blackColor.withOpacity(0.1),
                      thickness: 2,
                    ),
                    const SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0,right: 30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const AppText(text: "Condition",
                            color: AppColor.appcolor,
                            textSize: 15,style: AppTextStyle.title,
                          ),
                          const SizedBox(height: 5,),
                          const AppText(text: "New with tags",
                            color: AppColor.blackColor,
                            textSize: 13,style: AppTextStyle.title,
                          ),
                          const SizedBox(height: 5,),
                          AppText(text: "A brand-new, unused item with tags attached or "
                              "in the original packing.",
                            color: AppColor.blackColor.withOpacity(0.3),
                            textSize: 12,style: AppTextStyle.medium,
                          )
                        ],
                      ),
                    ),
                    Divider(
                      color: AppColor.blackColor.withOpacity(0.1),
                      thickness: 2,
                    ),
                    const SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0,right: 30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          commonText("Location :", "Lorem Ipsum California"),
                          const SizedBox(height: 10,),
                          commonText("Posted Date", "26 May 2020"),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20,),
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Image.asset(Assets.assetsSale),
                       const SizedBox(
                         height: 15,
                       ),
                       Padding(
                         padding: const EdgeInsets.only(left: 30.0),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             const AppText(
                               text: "Item Description",
                               textSize: 13,
                               fontFamily: "Poppins",
                               color: blackColor,
                             ),
                            const SizedBox(
                               height: 5,
                             ),
                             AppText(
                                 text: "Comfort Experience comfort to greates",
                                 textSize: 13,
                                 fontFamily: "Poppins",
                                 color: AppColor.blackColor.withOpacity(0.3)
                             ),
                           ],
                         ),
                       ),

                     ],
                   ),
                    const SizedBox(
                      height: 31.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.subscriptionScreen,
                            // arguments: "plan"
                        );
                      },
                      child: CommonButton(
                        color: AppColor.TextColor,
                        height: 57,
                        radius: 23,
                        text: "Boost your post",
                        margin: const EdgeInsets.symmetric(horizontal: 35),
                        textStyle:  TextStyle(
                            color: AppColor.blackColor.withOpacity(0.3),
                            fontSize: 16),
                      ),
                    ),
                    const SizedBox(
                      height: 31.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.editItemScreen);
                      },
                      child: CommonButton(
                        color: AppColor.appcolor,
                        height: 57,
                        text: "Edit",
                        margin: const EdgeInsets.symmetric(horizontal: 35),
                        textStyle: const TextStyle(
                            color: Colors.white, fontSize: 16),
                      ),
                    )

                  ],
                ),

            ],
          ),
        ),
      ),
    );
  }
  /// Common Text View
  Widget commonText(String title, String value){
    return Row(
      children: [
        AppText(text: title,
        color: AppColor.itemBorderColor,
          textSize: 12,style: AppTextStyle.medium,
        ),
        const SizedBox(width: 10,),
        AppText(text: value,
          color: AppColor.blackColor,
          textSize: 12,style: AppTextStyle.medium,
        ),
      ],
    );
  }
}
