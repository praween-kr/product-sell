import 'dart:io';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:oninto_flutter/utills/helper/camera_helper.dart';
import '../../../common_widget/color_constant.dart';

class SellItemController extends GetxController implements CameraOnCompleteListener  {

  var tabController = 0.obs;

  /// dropDown View
  RxString dropDownValue = 'Man'.obs;
  // List of items in our dropdown menu
  RxList<String>categoryItems = [
    'Man',
    'Category 2',
    'Category 3',
  ].obs;
  RxString dropDownValue2 = 'Tshirt'.obs;
  // List of items in our dropdown menu
  RxList<String>subItems = [
    'Tshirt',
    'Sub cat 2',
    'Sub cat 3',
  ].obs;
  RxString dropDownValue3 = 'Red'.obs;
  // List of items in our dropdown menu
  RxList<String>colorItems = [
    'Red',
    'Color 2',
    'Color 3',
  ].obs;
  RxString sizeDropValue = 'Small'.obs;
  // List of items in our dropdown menu
  RxList<String>sizeItems = [
    'Small',
    'Medium',
    'Large',
    'Extra Large',
    'Extra Extra Large'
  ].obs;
  RxString dropDownValue5 = 'Tommy'.obs;
  // List of items in our dropdown menu
  RxList<String>brandItems = [
    'Tommy',
    'Brand 2',
    'Brand 3',
  ].obs;
  RxString dropDownValue6 = 'Excellent'.obs;
  // List of items in our dropdown menu
  RxList<String>conditionItems = [
    'Excellent',
    'Condition 2',
    'Condition 3',
  ].obs;
  // RxString dropDownValue7= "".obs;
  // // List of items in our dropdown menu
  // RxList<String>sellItems = [
  //   'Auction',
  //   'Fix Price',
  // ].obs;

  /// selectedItem view
  RxBool selectedItemValue = false.obs;

  /// camera View
  late CameraHelper cameraHelper;
  RxString imagePath = "".obs;

  @override
  void onInit() {
    cameraHelper = CameraHelper(this);
    super.onInit();
  }

  @override
  void onSuccessFile(File file, String fileType) {
    imagePath.value = file.path;
  }
  void reset() {
    imagePath.value = "";
  }


  /// datePicker View
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  void pickDate(BuildContext context, int value) async {
    DateTime? pickedDate = await showDatePicker(
        builder: (context, Widget? child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: const ColorScheme.dark(
                onPrimary: AppColor.white,
                primary: AppColor.appcolor,
                surface: AppColor.white,
                onSurface: AppColor.blackColor,
              ),
              dialogBackgroundColor: AppColor.white,
            ),
            child: child!,
          );
        },
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2040));

    if (pickedDate != null) {
      print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
      String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
      print(
          formattedDate);
      if (value == 0) {
        startDateController.text = formattedDate; //set output date to TextField value
      }
      else {
        endDateController.text = formattedDate;
      }
    } else {

    }
  }
}