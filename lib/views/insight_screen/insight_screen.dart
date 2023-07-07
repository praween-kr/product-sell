import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_widget/appbar.dart';
import 'package:oninto_flutter/generated/assets.dart';
import 'package:oninto_flutter/views/insight_screen/insight_controller.dart';
import '../../common_widget/app_text.dart';
import '../../common_widget/color_constant.dart';
import '../../utills/colors_file.dart';

class InsightsScreen extends StatelessWidget {
   InsightsScreen({super.key});
final controller = Get.put(InsightController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: CommonAppbarWidget(
        heading: "Insights",
        textStyle: const TextStyle(
            fontSize: 20,
            color: blackColor,
            fontWeight: FontWeight.w500,
            fontFamily: "Poppins"),
      ),
      body:  Padding(
        padding: const EdgeInsets.only(left: 25.0,top: 15.0,right: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() =>
                   DropdownButtonHideUnderline(
                     child: DropdownButton2<String>(
                       style: const TextStyle(
                         color: AppColor.blackColor
                       ),
                       onChanged: (newValue) {
                         controller.dropDownValue.value = newValue!;
                       },
                       value: controller.dropDownValue.value,
                       items:controller.insightItems.value.map((items) {
                         return DropdownMenuItem(
                           value: items,
                           child: AppText(
                             text: items,
                             style: AppTextStyle.regular,
                             color: AppColor.white,
                             textSize: 13,
                           ),
                         );
                       }).toList(),
                       buttonStyleData: ButtonStyleData(
                         height: 42, width:116,
                        padding: const EdgeInsets.only(left: 10.0,right: 5.0),
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(19),
                           color: AppColor.appcolor,
                         ),
                         //elevation: 2,
                       ),
                       iconStyleData:  const IconStyleData(
                         icon: Icon(
                           Icons.arrow_drop_down_outlined,
                         ),
                         iconSize: 28,
                         iconEnabledColor: AppColor.white,
                         iconDisabledColor:AppColor.white,
                       ),
                       dropdownStyleData: DropdownStyleData(
                       maxHeight: 200,
                         decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(19),
                             color: AppColor.white,
                           border: Border.all(
                             color: AppColor.itemBorderColor,width: 2
                           )
                         ),
                         offset: const Offset(-2, 0),
                         scrollbarTheme: ScrollbarThemeData(
                           radius: const Radius.circular(40),
                           thickness: MaterialStateProperty.all<double>(6),
                           thumbVisibility: MaterialStateProperty.all<bool>(true),
                         ),
                       ),
                       menuItemStyleData: const MenuItemStyleData(
                         height: 40,
                         //padding: EdgeInsets.symmetric(horizontal: 10.0),
                       ),
                     ),
                   ),
               ),
              const AppText(text: "May 10 - May 16",
                style: AppTextStyle.medium,
                textSize: 12.0,
                color: AppColor.blackColor,
              ),
            ],
          ),
          const SizedBox(height: 30.0,),
          const Align(
            alignment: Alignment.center,
            child: AppText(text: "Overview",
              style: AppTextStyle.medium,
              textSize: 15.0,
              color: AppColor.blackColor,
            ),
          ),
            const SizedBox(height: 14.0,),
        Align( alignment: Alignment.center,
          child: Image.asset(Assets.assetsGraphImage,
          ),
        ),
          const SizedBox(height: 30.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const AppText(text: "Product You Shared",
                style: AppTextStyle.title,
                textSize: 15.0,
                color: AppColor.blackColor,
              ),
               AppText(text: "See all",
                style: AppTextStyle.medium,
                textSize: 10.0,
                color: AppColor.blackColor.withOpacity(0.3),
              ),
            ],
          ),
            const SizedBox(height: 23.0,),
            SizedBox(
              height: 200,
              child: ListView.builder(
                itemCount: 3,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index){
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 2),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(19),
                          boxShadow: const [
                            BoxShadow(
                                color:Colors.grey,
                                offset: Offset(0, 3),
                                blurRadius: 6)
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                Assets.assetsMobile,
                                height: 130,
                                width: 130,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Positioned(
                                left: 5,
                                top: 5,
                                right: 0,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        height: 20,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            color: const Color(0xff30E165),
                                            borderRadius:
                                            BorderRadius.circular(
                                                10)),
                                        child: const Center(
                                          child: AppText(
                                            text: "Sold",
                                            textSize: 10,
                                            color: Colors.white,
                                          ),
                                        )),
                                    const Icon(Icons.more_vert,
                                        color: Colors.white)
                                  ],
                                )),
                          ]),
                          const SizedBox(
                            height: 5,
                          ),
                          const Padding(
                            padding:
                            EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    AppText(
                                      text: "10 mins ago",
                                      textSize: 12,
                                      color: Color(0x4d000000),
                                      fontWeight: FontWeight.w400,
                                    ),
                                    AppText(
                                      text: "Girl Denim",
                                      textSize: 13,
                                      color: Color(0xff000000),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    AppText(
                                      text: "\$2000",
                                      textSize: 18,
                                      color: Color(0xff000000),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Icon(
                                      Icons.favorite,
                                      color: AppColor.appcolor,
                                      size: 12,
                                    ),
                                    AppText(
                                      text: "12",
                                      textSize: 12,
                                      color: Color(0x4d000000),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    Icon(
                                      Icons.remove_red_eye_outlined,
                                      color: AppColor.appcolor,
                                      size: 12,
                                    ),
                                    AppText(
                                      text: "199",
                                      textSize: 13,
                                      color: Color(0x4d000000),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  ),
            )
        ],),
      ),
    );
  }
}
