import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oninto_flutter/common_controller/home/categories_controller.dart';
import 'package:oninto_flutter/common_controller/product/sellItem_controller.dart';
import 'package:oninto_flutter/common_widget/app_textfield.dart';
import 'package:oninto_flutter/common_widget/appbar.dart';
import 'package:oninto_flutter/common_widget/color_constant.dart';
import 'package:oninto_flutter/common_widget/common_button.dart';
import 'package:oninto_flutter/model/home/category_model.dart';
import 'package:oninto_flutter/service/apis.dart';
import 'package:oninto_flutter/utills/app_print.dart';
import 'package:oninto_flutter/utills/colors_file.dart';
import 'package:oninto_flutter/utills/helper/file_picker.dart';
import 'package:oninto_flutter/utills/image_view.dart';
import 'package:oninto_flutter/views/search_google_address.dart';

import '../../routes/routes.dart';
import '../../utills/common_appbar.dart';

class SellItemScreen extends StatelessWidget {
  SellItemScreen({super.key});
  final SellItemController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    AppPrint.all(
        "productIdForEdit.value: ${controller.productIdForEdit.value}");
    CategoriesController categoriesController;
    if (CategoriesController().initialized) {
      categoriesController = Get.find<CategoriesController>();
    } else {
      categoriesController = Get.put(CategoriesController());
    }
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
        Get.arguments == 'edit'
            ? const SizedBox.shrink()
            : Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Obx(
                  () => Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: tabButton(
                          title: "Physical Product",
                          selected: controller.tabController.value == 1,
                          onClick: () {
                            controller.tabController.value = 1;
                          },
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        flex: 1,
                        child: tabButton(
                          title: "Co-Owner",
                          selected: controller.tabController.value == 0,
                          onClick: () {
                            controller.tabController.value = 0;
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
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Obx(
                      () => imagePickWidget(
                        bigSize: true,
                        h: Get.height * 0.26,
                        w: double.infinity,
                        isNetwork: controller.isNetworkTypeImg.value,
                        url: controller.singleImage.value,
                        type: controller.singleImageType.value,
                        onClick: () {
                          _addMoreAttachments();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 14.0),
                  SizedBox(
                    height: 60,
                    child: Obx(
                      () => ListView.separated(
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 8),
                        itemCount: controller.multipleImages.length < 4
                            ? 4
                            : controller.multipleImages.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, position) {
                          bool network = false;
                          List<AttachmentModel> list =
                              controller.multipleImages;
                          String urlType = '';
                          String url = '';
                          if (list.length >= 4) {
                            url = list[position].type == '2'
                                ? list[position].thumb ?? ''
                                : list[position].path;
                            urlType = list[position].type;
                            network = list[position].isNetwork;
                          }

                          //
                          if (controller.multipleImages.length < 4) {
                            if (position < controller.multipleImages.length) {
                              url = list[position].type == '2'
                                  ? list[position].thumb ?? ''
                                  : list[position].path;
                              urlType = list[position].type;
                              network = list[position].isNetwork;
                            }
                          }
                          int length = controller.multipleImages.length < 4
                              ? 4
                              : controller.multipleImages.length;
                          return Padding(
                            padding: EdgeInsets.only(
                                left: position == 0 ? 20 : 0,
                                right: position == length - 1 ? 20 : 0),
                            child: imagePickWidget(
                                isNetwork: network,
                                radius: 8,
                                w: 65,
                                h: double.infinity,
                                iconSize: 20,
                                url: url,
                                onDoubleClick: () {
                                  controller.singleImage.value = url;
                                  controller.singleImageType.value = urlType;
                                  controller.isNetworkTypeImg.value = network;
                                },
                                onClick: () {
                                  _addAttachment(position);
                                },
                                type: urlType),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 19.0),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GestureDetector(
                      onTap: () {
                        _addMoreAttachments();
                      },
                      child: CommonButton(
                          color: AppColor.appcolor,
                          radius: 25,
                          margin: const EdgeInsets.only(right: 0),
                          height: 57,
                          text: "Add more",
                          textStyle: const TextStyle(
                              color: Colors.white, fontSize: 16)),
                    ),
                  ),
                  const SizedBox(height: 23.0),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: AppText(
                        text: "Add Title",
                        color: AppColor.blackColor,
                        textSize: 13.0,
                        style: AppTextStyle.medium),
                  ),
                  const SizedBox(height: 14),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: AppTextField(
                        controller: controller.title,
                        height: 46.0,
                        title: "Add",
                        margin: const EdgeInsets.only(right: 0.0),
                        borderRadius: BorderRadius.circular(23),
                        containerColor: AppColor.TextColor),
                  ),
                  const SizedBox(height: 16.0),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: AppText(
                        text: "Location",
                        color: AppColor.blackColor,
                        textSize: 13.0,
                        style: AppTextStyle.medium),
                  ),
                  const SizedBox(height: 14.0),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: AppTextField(
                      onClick: () => Get.to(
                        () => SearchGoogleAddress(onChanged: (location) {
                          controller.location.text = location.address ?? '';
                          controller.cordinates.value = LatLng(
                              location.cordinates?.location?.lat ?? 0.0,
                              location.cordinates?.location?.lng ?? 0.0);
                        }),
                      ),
                      readOnly: true,
                      controller: controller.location,
                      height: 46.0,
                      title: "Add",
                      margin: const EdgeInsets.only(right: 0.0),
                      borderRadius: BorderRadius.circular(23),
                      containerColor: AppColor.TextColor,
                      suffix: const Icon(Icons.my_location,
                          size: 18.0, color: AppColor.appcolor),
                    ),
                  ),
                  const SizedBox(height: 16.0),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Obx(
                      () => controller.tabController.value == 1
                          ? const SizedBox.shrink()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const AppText(
                                    text: "Shares",
                                    color: AppColor.blackColor,
                                    textSize: 13.0,
                                    style: AppTextStyle.medium),
                                const SizedBox(height: 14.0),
                                AppTextField(
                                  controller: controller.shares,
                                  height: 46.0,
                                  title: "50",
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
                                  controller: controller.basePrice,
                                  height: 46.0,
                                  title: "Enter Price",
                                  margin: const EdgeInsets.only(right: 0.0),
                                  borderRadius: BorderRadius.circular(23),
                                  containerColor: AppColor.TextColor,
                                ),
                                const SizedBox(height: 16.0),
                              ],
                            ),
                    ),
                  ),

                  /// Co-Cowner ---------------

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Obx(
                      () => controller.tabController.value == 0
                          ? const SizedBox.shrink()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const AppText(
                                  text: "Category",
                                  color: AppColor.blackColor,
                                  textSize: 13.0,
                                  style: AppTextStyle.medium,
                                ),
                                const SizedBox(height: 14.0),
                                DropdownButtonHideUnderline(
                                  child: DropdownButton2<CategoryModel>(
                                    onChanged: (newValue) {
                                      if (newValue?.id != null) {
                                        controller.selectedCategory.value =
                                            newValue!;

                                        categoriesController.getSubCategories(
                                            (newValue.id ?? '').toString());
                                        controller.selectedSubCategory.value =
                                            null;
                                      }
                                    },
                                    value: controller.selectedCategory.value,
                                    items: (categoriesController
                                                .categoriesList.isEmpty
                                            ? [CategoryModel()]
                                            : categoriesController
                                                .categoriesList)
                                        .map((items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: AppText(
                                          text: items.name ?? '',
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
                                          borderRadius:
                                              BorderRadius.circular(23),
                                          color: AppColor.white,
                                          border: Border.all(
                                              color: AppColor.itemBorderColor)),
                                      offset: const Offset(-2, 0),
                                      scrollbarTheme: ScrollbarThemeData(
                                        radius: const Radius.circular(40),
                                        thickness:
                                            MaterialStateProperty.all<double>(
                                                6),
                                        thumbVisibility:
                                            MaterialStateProperty.all<bool>(
                                                true),
                                      ),
                                    ),
                                    menuItemStyleData: const MenuItemStyleData(
                                      height: 40,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16.0),
                                const AppText(
                                  text: "Sub Category",
                                  color: AppColor.blackColor,
                                  textSize: 13.0,
                                  style: AppTextStyle.medium,
                                ),
                                const SizedBox(height: 14.0),
                                Obx(
                                  () => DropdownButtonHideUnderline(
                                    child: DropdownButton2<CategoryModel>(
                                      onChanged: (newValue) {
                                        if (newValue?.id != null) {
                                          controller.selectedSubCategory.value =
                                              newValue;
                                        }
                                      },
                                      value:
                                          controller.selectedSubCategory.value,
                                      items: (categoriesController
                                                  .subCategoriesList.isEmpty
                                              ? [CategoryModel()]
                                              : categoriesController
                                                  .subCategoriesList)
                                          .map((items) {
                                        return DropdownMenuItem(
                                          enabled: controller
                                                  .selectedCategory.value !=
                                              null,
                                          value: items,
                                          child: AppText(
                                              text: items.name ??
                                                  'No sub category',
                                              style: AppTextStyle.regular,
                                              color: items.name == null
                                                  ? AppColor.grey
                                                  : AppColor.blackColor,
                                              textSize: 13),
                                        );
                                      }).toList(),
                                      buttonStyleData: ButtonStyleData(
                                        height: 44,
                                        width: Get.width,
                                        padding: const EdgeInsets.only(
                                            left: 14.0, right: 16.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(23),
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
                                            borderRadius:
                                                BorderRadius.circular(23),
                                            color: AppColor.white,
                                            border: Border.all(
                                                color:
                                                    AppColor.itemBorderColor)),
                                        offset: const Offset(-2, 0),
                                        scrollbarTheme: ScrollbarThemeData(
                                          radius: const Radius.circular(40),
                                          thickness:
                                              MaterialStateProperty.all<double>(
                                                  6),
                                          thumbVisibility:
                                              MaterialStateProperty.all<bool>(
                                                  true),
                                        ),
                                      ),
                                      menuItemStyleData:
                                          const MenuItemStyleData(
                                        height: 40,
                                        padding: EdgeInsets.only(
                                            left: 23, right: 24),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16.0),
                                const AppText(
                                  text: "Color",
                                  color: AppColor.blackColor,
                                  textSize: 13.0,
                                  style: AppTextStyle.medium,
                                ),
                                const SizedBox(height: 14.0),
                                AppTextField(
                                  controller: controller.itemColor,
                                  height: 50,
                                  borderRadius: BorderRadius.circular(23),
                                  containerColor: AppColor.TextColor,
                                  title: "Enter Color",
                                  style: const TextStyle(
                                      color: AppColor.blackColor,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400),
                                  hintStyle: const TextStyle(
                                      color: AppColor.blackColor,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(height: 16.0),
                                const AppText(
                                    text: "Size",
                                    color: AppColor.blackColor,
                                    textSize: 13.0,
                                    style: AppTextStyle.medium),
                                const SizedBox(height: 14.0),
                                Obx(
                                  () => DropdownButtonHideUnderline(
                                    child: DropdownButton2<String>(
                                      onChanged: (newValue) {
                                        controller.itemSize.value = newValue!;
                                      },
                                      value: controller.itemSize.value,
                                      items: controller.sizeItems.value
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
                                          borderRadius:
                                              BorderRadius.circular(23),
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
                                            borderRadius:
                                                BorderRadius.circular(23),
                                            color: AppColor.white,
                                            border: Border.all(
                                                color:
                                                    AppColor.itemBorderColor)),
                                        offset: const Offset(-2, 0),
                                        scrollbarTheme: ScrollbarThemeData(
                                          radius: const Radius.circular(40),
                                          thickness:
                                              MaterialStateProperty.all<double>(
                                                  6),
                                          thumbVisibility:
                                              MaterialStateProperty.all<bool>(
                                                  true),
                                        ),
                                      ),
                                      menuItemStyleData:
                                          const MenuItemStyleData(
                                        height: 40,
                                        padding: EdgeInsets.only(
                                            left: 23, right: 24),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16.0),
                                const AppText(
                                  text: "Brand",
                                  color: AppColor.blackColor,
                                  textSize: 13.0,
                                  style: AppTextStyle.medium,
                                ),
                                const SizedBox(height: 14.0),
                                AppTextField(
                                  controller: controller.brand,
                                  height: 50,
                                  borderRadius: BorderRadius.circular(23),
                                  containerColor: AppColor.TextColor,
                                  title: "Enter Brand",
                                  style: const TextStyle(
                                      color: AppColor.blackColor,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400),
                                  hintStyle: const TextStyle(
                                      color: AppColor.blackColor,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(height: 16.0),
                                const AppText(
                                  text: "Condition",
                                  color: AppColor.blackColor,
                                  textSize: 13.0,
                                  style: AppTextStyle.medium,
                                ),
                                const SizedBox(height: 14.0),
                                Obx(
                                  () => DropdownButtonHideUnderline(
                                    child: DropdownButton2<String>(
                                      onChanged: (newValue) {
                                        controller.condition.value = newValue!;
                                      },
                                      value: controller.condition.value,
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
                                          borderRadius:
                                              BorderRadius.circular(23),
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
                                            borderRadius:
                                                BorderRadius.circular(23),
                                            color: AppColor.white,
                                            border: Border.all(
                                                color:
                                                    AppColor.itemBorderColor)),
                                        offset: const Offset(-2, 0),
                                        scrollbarTheme: ScrollbarThemeData(
                                          radius: const Radius.circular(40),
                                          thickness:
                                              MaterialStateProperty.all<double>(
                                                  6),
                                          thumbVisibility:
                                              MaterialStateProperty.all<bool>(
                                                  true),
                                        ),
                                      ),
                                      menuItemStyleData:
                                          const MenuItemStyleData(
                                        height: 40,
                                        padding: EdgeInsets.only(
                                            left: 23, right: 24),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16.0),
                                const AppText(
                                  text: "Sell Option",
                                  color: AppColor.blackColor,
                                  textSize: 13.0,
                                  style: AppTextStyle.medium,
                                ),
                                const SizedBox(height: 14.0),
                                Obx(
                                  () => DropdownButtonHideUnderline(
                                    child: DropdownButton2<String>(
                                      onChanged: (newValue) {
                                        controller.sellOption.value = newValue!;
                                      },
                                      value: controller.sellOption.value,
                                      items: controller.selloptionsList
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
                                          borderRadius:
                                              BorderRadius.circular(23),
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
                                            borderRadius:
                                                BorderRadius.circular(23),
                                            color: AppColor.white,
                                            border: Border.all(
                                                color:
                                                    AppColor.itemBorderColor)),
                                        offset: const Offset(-2, 0),
                                        scrollbarTheme: ScrollbarThemeData(
                                          radius: const Radius.circular(40),
                                          thickness:
                                              MaterialStateProperty.all<double>(
                                                  6),
                                          thumbVisibility:
                                              MaterialStateProperty.all<bool>(
                                                  true),
                                        ),
                                      ),
                                      menuItemStyleData:
                                          const MenuItemStyleData(
                                        height: 40,
                                        padding: EdgeInsets.only(
                                            left: 23, right: 24),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 14.0),
                                Obx(() => controller.sellOption.value ==
                                        'Auction'
                                    ? startEndDatesPicker(
                                        context,
                                        initialDate1:
                                            controller.startDate.value,
                                        initialDate2: controller.endDate.value,
                                        date1: (DateTime? selected) {
                                          controller.startDate.value = selected;
                                        },
                                        date2: (DateTime? selected) {
                                          controller.endDate.value = selected;
                                        },
                                      )
                                    : Container()),
                                const AppText(
                                    text: "Price",
                                    color: AppColor.blackColor,
                                    textSize: 13.0,
                                    style: AppTextStyle.medium),
                                const SizedBox(height: 14.0),
                                AppTextField(
                                  controller: controller.price,
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
                                const SizedBox(height: 16.0),
                              ],
                            ),
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: AppText(
                      text: "Description",
                      color: AppColor.blackColor,
                      textSize: 13.0,
                      style: AppTextStyle.medium,
                    ),
                  ),
                  const SizedBox(height: 14.0),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: AppColor.TextColor,
                        borderRadius: BorderRadius.all(Radius.circular(23)),
                      ),
                      child: TextFormField(
                        controller: controller.description,
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
                  ),
                  const SizedBox(height: 31.0),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GestureDetector(
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
                  ),
                  const SizedBox(height: 31.0),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GestureDetector(
                      onTap: () async {
                        if (Get.arguments == 'edit') {
                          await controller.editSellItem();
                        } else {
                          await controller.addSellItem();
                        }

                        // customDialog(context, () {
                        //   Get.toNamed(Routes.productScreen, arguments: 2);
                        // });
                      },
                      child: CommonButton(
                        color: AppColor.appcolor,
                        height: 57,
                        text: Get.arguments == 'edit' ? "Edit" : "Submit",
                        textStyle:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }

  ///--------
  _addAttachment(int position) {
    if (position < controller.multipleImages.length) {
      controller.selectedImageForUpdate.value = position;
    }
    AppPicker().image((path, type, thumb) {
      String typeKey = "0";
      if (type == AttachmentPicker.IMG) {
        typeKey = "0";
      } else if (type == AttachmentPicker.VIDEO) {
        typeKey = "2";
      } else {
        typeKey = "1";
      }
      if (path != null) {
        if (controller.selectedImageForUpdate.value == position) {
          if (controller.multipleImages[position].isNetwork) {
            controller.oldImagesIdList
                .add(controller.multipleImages[position].id.toString());
          }
          AppPrint.all(
              "controller.oldImagesIdList: ${controller.oldImagesIdList}");
          //
          controller.multipleImages.replaceRange(position, position + 1,
              [AttachmentModel(path: path, type: typeKey, thumb: thumb)]);
        } else {
          controller.multipleImages
              .add(AttachmentModel(path: path, type: typeKey, thumb: thumb));
        }
        controller.singleImage.value = typeKey == '2' ? thumb ?? '' : path;
        controller.singleImageType.value = typeKey;
        controller.multipleImages.refresh();
      }
    });
  }

  _addMoreAttachments() {
    AppPicker().image((path, type, thumb) {
      String typeKey = "0";
      if (type == AttachmentPicker.IMG) {
        typeKey = "0";
      } else if (type == AttachmentPicker.VIDEO) {
        typeKey = "2";
      } else {
        typeKey = "1";
      }
      if (path != null) {
        controller.multipleImages
            .add(AttachmentModel(path: path, type: typeKey, thumb: thumb));
        controller.multipleImages.refresh();
        controller.singleImage.value = typeKey == '2' ? thumb ?? '' : path;
        controller.singleImageType.value = typeKey;
      }
    });
  }

  ///--------

  Widget imagePickWidget({
    bool isNetwork = false,
    double? h,
    double? w,
    double? radius,
    double? iconSize,
    required Function onClick,
    Function? onDoubleClick,
    required String url,
    String type = '0',
    bool bigSize = false,
    Function? onLongClick,
  }) {
    return GestureDetector(
      onDoubleTap: onDoubleClick == null ? null : () => onDoubleClick(),
      onTap: () => onClick(),
      onLongPress: onLongClick == null ? null : () => onLongClick(),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 20)),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: w,
              height: h,
              decoration: BoxDecoration(
                color:
                    (type == '1' ? themeColor : Colors.grey).withOpacity(0.2),
                borderRadius: BorderRadius.circular(17.0),
              ),
              child: url == '' || type == '1'
                  ? null
                  : isNetwork
                      ? AppImage.view("${ImageBaseUrls.product}$url",
                          fit: BoxFit.cover)
                      : Image.file(File(url), fit: BoxFit.cover),
            ),
            url == ''
                ? const SizedBox.shrink()
                : Container(
                    color: Colors.white.withOpacity(0.3), width: w, height: h),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    type == '1'
                        ? Icons.file_copy
                        : type == '2'
                            ? Icons.play_circle
                            : Icons.camera_alt,
                    size: iconSize ?? Get.width * 0.12,
                    color:
                        AppColor.blackColor.withOpacity(url == '' ? 0.2 : 0.8),
                  ),
                  bigSize && type == '1'
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            url.split('/').last,
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                        )
                      : const SizedBox.shrink()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///Start and End Date View
  Widget startEndDatesPicker(BuildContext context,
      {required Function(DateTime?) date1,
      required Function(DateTime?) date2,
      required DateTime? initialDate1,
      required DateTime? initialDate2}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppText(
            text: "Start Date",
            color: AppColor.blackColor,
            textSize: 13.0,
            style: AppTextStyle.medium),
        const SizedBox(height: 16.0),
        AppTextField(
          readOnly: true,
          controller: TextEditingController(
            text:
                "${initialDate1?.day ?? 'DD'}-${initialDate1?.month ?? 'MM'}-${initialDate1?.year ?? 'YYYY'}",
          ),
          height: 46.0,
          title: "Start Date",
          style: TextStyle(color: initialDate1 == null ? AppColor.grey : null),
          hintStyle: const TextStyle(color: AppColor.blackColor, fontSize: 13),
          //contentPadding: const EdgeInsets.only(top: 8.0,left: 13.0),
          margin: const EdgeInsets.only(right: 0.0),
          borderRadius: BorderRadius.circular(23),
          containerColor: AppColor.TextColor,
          suffix: IconButton(
              onPressed: () =>
                  controller.pickDate(context, 0, onChanged: date1),
              icon: Icon(Icons.calendar_month_outlined,
                  size: 16, color: AppColor.blackColor.withOpacity(0.3))),
        ),
        const SizedBox(height: 14.0),
        const AppText(
            text: "End Date",
            color: AppColor.blackColor,
            textSize: 13.0,
            style: AppTextStyle.medium),
        const SizedBox(height: 16.0),
        AppTextField(
          controller: TextEditingController(
              text:
                  "${initialDate2?.day ?? 'DD'}-${initialDate2?.month ?? 'MM'}-${initialDate2?.year ?? 'YYYY'}"),
          readOnly: true,
          height: 46.0,
          title: "End Date",
          style: TextStyle(color: initialDate2 == null ? AppColor.grey : null),
          hintStyle: TextStyle(
              color: initialDate2?.day == null
                  ? AppColor.grey
                  : AppColor.blackColor,
              fontSize: 13),
          //contentPadding: const EdgeInsets.only(top: 8.0,left: 13.0),
          margin: const EdgeInsets.only(right: 0.0),
          borderRadius: BorderRadius.circular(23),
          containerColor: AppColor.TextColor,
          suffix: IconButton(
              onPressed: () =>
                  controller.pickDate(context, 2, onChanged: date2),
              icon: Icon(
                Icons.calendar_month_outlined,
                size: 16,
                color: AppColor.blackColor.withOpacity(0.3),
              )),
        ),
        const SizedBox(height: 14),
      ],
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
