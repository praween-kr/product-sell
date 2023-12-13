import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_widget/appbar.dart';
import 'package:oninto_flutter/views/settingScreen/controller/editItem_screen_controller.dart';

import '../../../common_widget/app_text.dart';
import '../../../common_widget/app_textfield.dart';
import '../../../common_widget/color_constant.dart';
import '../../../common_widget/common_button.dart';
import '../../../routes/routes.dart';
import '../../../utils/colors_file.dart';

class EditItemScreen extends StatelessWidget {
   EditItemScreen({super.key});
  final controller = Get.put(EditItemScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: CommonAppbarWidget(
        heading: "Edit Item",
        textStyle: const TextStyle(
            fontSize: 20,
            color: blackColor,
            fontWeight: FontWeight.w500,
            fontFamily: "Poppins"),
      ),
      body:  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(35, 20, 36, 40),
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
              const SizedBox(
                height: 14.0,
              ),
              SizedBox(
                height: 70.0,
                child: ListView.builder(
                  itemCount: 4,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, position) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 23.0),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 5.0),
                      decoration: BoxDecoration(
                          color: AppColor.text1.withOpacity(0.1),
                          borderRadius:
                          BorderRadius.circular(17.0)),
                      child: Column(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.camera_alt,
                            size: 22.0,
                            color: AppColor.blackColor
                                .withOpacity(0.3),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          AppText(
                            text: "JPEG",
                            color: AppColor.blackColor
                                .withOpacity(0.3),
                            textSize: 10.0,
                            style: AppTextStyle.regular,
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 19.0,
              ),
              GestureDetector(
                onTap: () {},
                child: CommonButton(
                  color: AppColor.appcolor,
                  radius: 25,
                  margin: const EdgeInsets.only(right: 0),
                  height: 57,
                  text: "Add more",
                  textStyle: const TextStyle(
                      color: Colors.white, fontSize: 16),
                ),
              ),
              const SizedBox(
                height: 23.0,
              ),
              const AppText(
                text: "Add Title",
                color: AppColor.blackColor,
                textSize: 13.0,
                style: AppTextStyle.medium,
              ),
              const SizedBox(
                height: 14.0,
              ),
              AppTextField(
                height: 46.0,
                title: "Add",
                //contentPadding: const EdgeInsets.only(top: 8.0,left: 13.0),
                margin: const EdgeInsets.only(right: 0.0),
                borderRadius: BorderRadius.circular(23),
                containerColor: AppColor.TextColor,
              ),
              const SizedBox(
                height: 16.0,
              ),
              const AppText(
                text: "Location",
                color: AppColor.blackColor,
                textSize: 13.0,
                style: AppTextStyle.medium,
              ),
              const SizedBox(
                height: 14.0,
              ),
              AppTextField(
                height: 46.0,
                title: "Add",
                //contentPadding: const EdgeInsets.only(top: 8.0,left: 13.0),
                margin: const EdgeInsets.only(right: 0.0),
                borderRadius: BorderRadius.circular(23),
                containerColor: AppColor.TextColor,
                suffix: const Icon(
                  Icons.my_location,
                  size: 18.0,
                  color: AppColor.appcolor,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              const AppText(
                text: "Category",
                color: AppColor.blackColor,
                textSize: 13.0,
                style: AppTextStyle.medium,
              ),
              const SizedBox(
                height: 14.0,
              ),
              Obx(
                    () => DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    onChanged: (newValue) {
                     // controller.dropDownValue.value = newValue!;
                    },
                    value: controller.categoryDropDown.value,
                    items: controller.categoryItems.value
                        .map((items) {
                      return DropdownMenuItem(
                        value: items,
                        child: AppText(
                          text: items,
                          style: AppTextStyle.regular,
                          color: AppColor.blackColor,
                          textSize: 13,
                        ),
                      );
                    }).toList(),
                    buttonStyleData: ButtonStyleData(
                      height: 44,
                      width: Get.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(23),
                        color: AppColor.TextColor,
                      ),
                      //elevation: 2,
                    ),
                    iconStyleData: const IconStyleData(
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                      ),
                      iconSize: 20,
                      iconEnabledColor: AppColor.blackColor,
                      iconDisabledColor: AppColor.blackColor,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(23),
                          color: AppColor.white,
                          border: Border.all(
                              color: AppColor.itemBorderColor)),
                      offset: const Offset(-2, 0),
                      scrollbarTheme: ScrollbarThemeData(
                        radius: const Radius.circular(40),
                        thickness:
                        MaterialStateProperty.all<double>(6),
                        thumbVisibility:
                        MaterialStateProperty.all<bool>(true),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                      padding:
                      EdgeInsets.symmetric(horizontal: 10.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              const AppText(
                text: "Sub Category",
                color: AppColor.blackColor,
                textSize: 13.0,
                style: AppTextStyle.medium,
              ),
              const SizedBox(
                height: 14.0,
              ),
              Obx(
                    () => DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    onChanged: (newValue) {
                      controller.subCategoryDropDown.value = newValue!;
                    },
                    value: controller.subCategoryDropDown.value,
                    items: controller.subItems.value.map((items) {
                      return DropdownMenuItem(
                        value: items,
                        child: AppText(
                          text: items,
                          style: AppTextStyle.regular,
                          color: AppColor.blackColor,
                          textSize: 13,
                        ),
                      );
                    }).toList(),
                    buttonStyleData: ButtonStyleData(
                      height: 44,
                      width: Get.width,
                      padding: const EdgeInsets.only(
                          left: 14.0, right: 16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(23),
                        color: AppColor.TextColor,
                      ),
                      //elevation: 2,
                    ),
                    iconStyleData: const IconStyleData(
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                      ),
                      iconSize: 20,
                      iconEnabledColor: AppColor.blackColor,
                      iconDisabledColor: AppColor.blackColor,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(23),
                          color: AppColor.white,
                          border: Border.all(
                              color: AppColor.itemBorderColor)),
                      offset: const Offset(-2, 0),
                      scrollbarTheme: ScrollbarThemeData(
                        radius: const Radius.circular(40),
                        thickness:
                        MaterialStateProperty.all<double>(6),
                        thumbVisibility:
                        MaterialStateProperty.all<bool>(true),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                      padding:
                      EdgeInsets.only(left: 23, right: 24),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              const AppText(
                text: "Color",
                color: AppColor.blackColor,
                textSize: 13.0,
                style: AppTextStyle.medium,
              ),
              const SizedBox(
                height: 14.0,
              ),
              Obx(
                    () => DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    onChanged: (newValue) {
                      controller.colorDropDown.value = newValue!;
                    },
                    value: controller.colorDropDown.value,
                    items:
                    controller.colorItems.value.map((items) {
                      return DropdownMenuItem(
                        value: items,
                        child: AppText(
                          text: items,
                          style: AppTextStyle.regular,
                          color: AppColor.blackColor,
                          textSize: 13,
                        ),
                      );
                    }).toList(),
                    buttonStyleData: ButtonStyleData(
                      height: 44,
                      width: Get.width,
                      padding: const EdgeInsets.only(
                          left: 14.0, right: 16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(23),
                        color: AppColor.TextColor,
                      ),
                      //elevation: 2,
                    ),
                    iconStyleData: const IconStyleData(
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                      ),
                      iconSize: 20,
                      iconEnabledColor: AppColor.blackColor,
                      iconDisabledColor: AppColor.blackColor,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(23),
                          color: AppColor.white,
                          border: Border.all(
                              color: AppColor.itemBorderColor)),
                      offset: const Offset(-2, 0),
                      scrollbarTheme: ScrollbarThemeData(
                        radius: const Radius.circular(40),
                        thickness:
                        MaterialStateProperty.all<double>(6),
                        thumbVisibility:
                        MaterialStateProperty.all<bool>(true),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                      padding:
                      EdgeInsets.only(left: 23, right: 24),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              const AppText(
                text: "Size",
                color: AppColor.blackColor,
                textSize: 13.0,
                style: AppTextStyle.medium,
              ),
              const SizedBox(
                height: 14.0,
              ),
              Obx(
                    () => DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    onChanged: (newValue) {
                      controller.sizeDropDown.value = newValue!;
                    },
                    value: controller.sizeDropDown.value,
                    items: controller.sizeItems.value.map((items) {
                      return DropdownMenuItem(
                        value: items,
                        child: AppText(
                          text: items,
                          style: AppTextStyle.regular,
                          color: AppColor.blackColor,
                          textSize: 13,
                        ),
                      );
                    }).toList(),
                    buttonStyleData: ButtonStyleData(
                      height: 44,
                      width: Get.width,
                      padding: const EdgeInsets.only(
                          left: 14.0, right: 16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(23),
                        color: AppColor.TextColor,
                      ),
                      //elevation: 2,
                    ),
                    iconStyleData: const IconStyleData(
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                      ),
                      iconSize: 20,
                      iconEnabledColor: AppColor.blackColor,
                      iconDisabledColor: AppColor.blackColor,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(23),
                          color: AppColor.white,
                          border: Border.all(
                              color: AppColor.itemBorderColor)),
                      offset: const Offset(-2, 0),
                      scrollbarTheme: ScrollbarThemeData(
                        radius: const Radius.circular(40),
                        thickness:
                        MaterialStateProperty.all<double>(6),
                        thumbVisibility:
                        MaterialStateProperty.all<bool>(true),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                      padding:
                      EdgeInsets.only(left: 23, right: 24),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              const AppText(
                text: "Brand",
                color: AppColor.blackColor,
                textSize: 13.0,
                style: AppTextStyle.medium,
              ),
              const SizedBox(
                height: 14.0,
              ),
              Obx(
                    () => DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    onChanged: (newValue) {
                      controller.brandDropDown.value = newValue!;
                    },
                    value: controller.brandDropDown.value,
                    items:
                    controller.brandItems.value.map((items) {
                      return DropdownMenuItem(
                        value: items,
                        child: AppText(
                          text: items,
                          style: AppTextStyle.regular,
                          color: AppColor.blackColor,
                          textSize: 13,
                        ),
                      );
                    }).toList(),
                    buttonStyleData: ButtonStyleData(
                      height: 44,
                      width: Get.width,
                      padding: const EdgeInsets.only(
                          left: 14.0, right: 16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(23),
                        color: AppColor.TextColor,
                      ),
                      //elevation: 2,
                    ),
                    iconStyleData: const IconStyleData(
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                      ),
                      iconSize: 20,
                      iconEnabledColor: AppColor.blackColor,
                      iconDisabledColor: AppColor.blackColor,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(23),
                          color: AppColor.white,
                          border: Border.all(
                              color: AppColor.itemBorderColor)),
                      offset: const Offset(-2, 0),
                      scrollbarTheme: ScrollbarThemeData(
                        radius: const Radius.circular(40),
                        thickness:
                        MaterialStateProperty.all<double>(6),
                        thumbVisibility:
                        MaterialStateProperty.all<bool>(true),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                      padding:
                      EdgeInsets.only(left: 23, right: 24),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              const AppText(
                text: "Condition",
                color: AppColor.blackColor,
                textSize: 13.0,
                style: AppTextStyle.medium,
              ),
              const SizedBox(
                height: 14.0,
              ),
              Obx(
                    () => DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    onChanged: (newValue) {
                      controller.conditionDropDown.value = newValue!;
                    },
                    value: controller.conditionDropDown.value,
                    items: controller.conditionItems.value
                        .map((items) {
                      return DropdownMenuItem(
                        value: items,
                        child: AppText(
                          text: items,
                          style: AppTextStyle.regular,
                          color: AppColor.blackColor,
                          textSize: 13,
                        ),
                      );
                    }).toList(),
                    buttonStyleData: ButtonStyleData(
                      height: 44,
                      width: Get.width,
                      padding: const EdgeInsets.only(
                          left: 14.0, right: 16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(23),
                        color: AppColor.TextColor,
                      ),
                      //elevation: 2,
                    ),
                    iconStyleData: const IconStyleData(
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                      ),
                      iconSize: 20,
                      iconEnabledColor: AppColor.blackColor,
                      iconDisabledColor: AppColor.blackColor,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(23),
                          color: AppColor.white,
                          border: Border.all(
                              color: AppColor.itemBorderColor)),
                      offset: const Offset(-2, 0),
                      scrollbarTheme: ScrollbarThemeData(
                        radius: const Radius.circular(40),
                        thickness:
                        MaterialStateProperty.all<double>(6),
                        thumbVisibility:
                        MaterialStateProperty.all<bool>(true),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                      padding:
                      EdgeInsets.only(left: 23, right: 24),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              const AppText(
                text: "Sell Option",
                color: AppColor.blackColor,
                textSize: 13.0,
                style: AppTextStyle.medium,
              ),
              const SizedBox(
                height: 14.0,
              ),
              Obx(
                    () => DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    onChanged: (newValue) {
                      controller.sellItemDropDown.value = newValue!;
                    },
                    value: controller.sellItemDropDown.value,
                    items: controller.sellItems.value
                        .map((items) {
                      return DropdownMenuItem(
                        value: items,
                        child: AppText(
                          text: items,
                          style: AppTextStyle.regular,
                          color: AppColor.blackColor,
                          textSize: 13,
                        ),
                      );
                    }).toList(),
                    buttonStyleData: ButtonStyleData(
                      height: 44,
                      width: Get.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(23),
                        color: AppColor.TextColor,
                      ),
                      //elevation: 2,
                    ),
                    iconStyleData: const IconStyleData(
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                      ),
                      iconSize: 20,
                      iconEnabledColor: AppColor.blackColor,
                      iconDisabledColor: AppColor.blackColor,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(23),
                          color: AppColor.white,
                          border: Border.all(
                              color: AppColor.itemBorderColor)),
                      offset: const Offset(-2, 0),
                      scrollbarTheme: ScrollbarThemeData(
                        radius: const Radius.circular(40),
                        thickness:
                        MaterialStateProperty.all<double>(6),
                        thumbVisibility:
                        MaterialStateProperty.all<bool>(true),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                      padding:
                      EdgeInsets.symmetric(horizontal: 10.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              const AppText(
                text: "Price",
                color: AppColor.blackColor,
                textSize: 13.0,
                style: AppTextStyle.medium,
              ),
              const SizedBox(
                height: 14.0,
              ),
              AppTextField(
                height: 46.0,
                title: "\$2000",
                hintStyle: const TextStyle(
                  color: AppColor.blackColor,
                ),
                //contentPadding: const EdgeInsets.only(top: 8.0,left: 13.0),
                margin: const EdgeInsets.only(right: 0.0),
                borderRadius: BorderRadius.circular(23),
                containerColor: AppColor.TextColor,
              ),
              const SizedBox(
                height: 16.0,
              ),
              const AppText(
                text: "Description",
                color: AppColor.blackColor,
                textSize: 13.0,
                style: AppTextStyle.medium,
              ),
              const SizedBox(
                height: 14.0,
              ),
              AppTextField(
                height: 46.0,
                title: "Write Here...",
                //contentPadding: const EdgeInsets.only(top: 8.0,left: 13.0),
                margin: const EdgeInsets.only(right: 0.0),
                borderRadius: BorderRadius.circular(23),
                containerColor: AppColor.TextColor,
                maxLines: 5,
              ),
              const SizedBox(
                height: 31.0,
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.subscriptionScreen);
                },
                child: CommonButton(
                  color: AppColor.TextColor,
                  height: 57,
                  radius: 23,
                  text: "Boost your post",
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
                  customDialog(context);
                },
                child: CommonButton(
                  color: AppColor.appcolor,
                  height: 57,
                  text: "Submit",
                  textStyle: const TextStyle(
                      color: Colors.white, fontSize: 16),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  /// DialogBox View
  customDialog(BuildContext context) {
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
                            lineHeight: 1.6,
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
                        Get.toNamed(Routes.productScreen);
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
