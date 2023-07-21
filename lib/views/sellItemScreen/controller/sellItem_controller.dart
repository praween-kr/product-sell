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
    screenPickerColor = Colors.blue;
    dialogPickerColor = Colors.red;
    dialogSelectColor = const Color(0xFFA239CA);
    isDark = false;
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

  /// colorPicker View
  late Color screenPickerColor; // Color for picker shown in Card on the screen.
  late Color dialogPickerColor; // Color for picker in dialog using onChanged
  late Color dialogSelectColor; // Color for picker using color select dialog.
  late bool isDark;
  // Define some custom colors for the custom picker segment.
  // The 'guide' color values are from
  // https://material.io/design/color/the-color-system.html#color-theme-creation
  static const Color guidePrimary = Color(0xFF6200EE);
  static const Color guidePrimaryVariant = Color(0xFF3700B3);
  static const Color guideSecondary = Color(0xFF03DAC6);
  static const Color guideSecondaryVariant = Color(0xFF018786);
  static const Color guideError = Color(0xFFB00020);
  static const Color guideErrorDark = Color(0xFFCF6679);
  static const Color blueBlues = Color(0xFF174378);

  // Make a custom ColorSwatch to name map from the above custom colors.
  final Map<ColorSwatch<Object>, String> colorsNameMap =
  <ColorSwatch<Object>, String>{
    ColorTools.createPrimarySwatch(guidePrimary): 'Guide Purple',
    ColorTools.createPrimarySwatch(guidePrimaryVariant): 'Guide Purple Variant',
    ColorTools.createAccentSwatch(guideSecondary): 'Guide Teal',
    ColorTools.createAccentSwatch(guideSecondaryVariant): 'Guide Teal Variant',
    ColorTools.createPrimarySwatch(guideError): 'Guide Error',
    ColorTools.createPrimarySwatch(guideErrorDark): 'Guide Error Dark',
    ColorTools.createPrimarySwatch(blueBlues): 'Blue blues',
  };
  Future<bool> colorPickerDialog(context) async {
    return ColorPicker(
      color: dialogPickerColor,
      onColorChanged: (Color color) =>
       () => dialogPickerColor = color,
      width: 40,
      height: 40,
      borderRadius: 4,
      spacing: 5,
      runSpacing: 5,
      wheelDiameter: 120,
      heading: Text(
        'Select color',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subheading: Text(
        'Select color shade',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      wheelSubheading: Text(
        'Selected color and its shades',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      showMaterialName: true,
      showColorName: true,
      showColorCode: true,
      copyPasteBehavior: const ColorPickerCopyPasteBehavior(
        longPressMenu: true,
      ),
      materialNameTextStyle: Theme.of(context).textTheme.bodySmall,
      colorNameTextStyle: Theme.of(context).textTheme.bodySmall,
      colorCodeTextStyle: Theme.of(context).textTheme.bodyMedium,
      colorCodePrefixStyle: Theme.of(context).textTheme.bodySmall,
      selectedPickerTypeColor: Theme.of(context).colorScheme.primary,
      pickersEnabled: const <ColorPickerType, bool>{
        ColorPickerType.both: true,
        ColorPickerType.primary: true,
        ColorPickerType.accent: true,
        ColorPickerType.bw: false,
        ColorPickerType.custom: true,
        ColorPickerType.wheel: true,
      },
      customColorSwatchesAndNames: colorsNameMap,
    ).showPickerDialog(
      context,
      actionsPadding: const EdgeInsets.all(16),
      constraints:
      const BoxConstraints(minHeight: 480, minWidth: 300, maxWidth: 320),
    );
  }

}