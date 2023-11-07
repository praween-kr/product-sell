import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oninto_flutter/model/home/category_model.dart';
import 'package:oninto_flutter/service/api_requests.dart';
import 'package:oninto_flutter/utills/app_toast_loader.dart';
import 'package:oninto_flutter/utills/helper/camera_helper.dart';

import '../../common_widget/color_constant.dart';

class SellItemController extends GetxController {
  var tabController = 0.obs;

  /// dropDown View
  RxString dropDownValue = 'Man'.obs;
  // List of items in our dropdown menu
  RxList<String> categoryItems = [
    'Man',
    'Category 2',
    'Category 3',
  ].obs;
  RxString dropDownValue2 = 'Tshirt'.obs;
  // List of items in our dropdown menu
  RxList<String> subItems = [
    'Tshirt',
    'Sub cat 2',
    'Sub cat 3',
  ].obs;
  RxString dropDownValue3 = 'Red'.obs;
  // List of items in our dropdown menu
  RxList<String> colorItems = [
    'Red',
    'Color 2',
    'Color 3',
  ].obs;
  // RxString sizeDropValue = 'Small'.obs;
  // List of items in our dropdown menu
  RxList<String> sizeItems =
      ['Small', 'Medium', 'Large', 'Extra Large', 'Extra Extra Large'].obs;
  RxString dropDownValue5 = 'Tommy'.obs;
  // List of items in our dropdown menu
  RxList<String> brandItems = [
    'Tommy',
    'Brand 2',
    'Brand 3',
  ].obs;
  // RxString dropDownValue6 = 'Excellent'.obs;
  // List of items in our dropdown menu
  RxList<String> conditionItems = [
    'Excellent',
    'Condition 2',
    'Condition 3',
  ].obs;

  /// selectedItem view
  RxBool selectedItemValue = false.obs;

  /// camera View
  late CameraHelper cameraHelper;
  RxString imagePath = "".obs;

  void reset() {
    imagePath.value = "";
  }

  /// datePicker View
  // TextEditingController startDateController = TextEditingController();
  // TextEditingController endDateController = TextEditingController();
  void pickDate(BuildContext context, int value,
      {required Function(DateTime?) onChanged}) async {
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
    onChanged(pickedDate);
    // if (pickedDate != null) {
    //   // print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
    //   // String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
    //   // print(formattedDate);
    //   // if (value == 0) {
    //   //   startDateController.text =
    //   //       formattedDate; //set output date to TextField value
    //   // } else {
    //   //   endDateController.text = formattedDate;
    //   // }
    // } else {}
  }

  /// ----------- FORM AND API ------------------------------ ///
  var categoriesList = <CategoryModel>[].obs;
  var subCategoriesList = <CategoryModel>[].obs;

  ///
  var singleImage = ''.obs;
  var singleImageType = ''.obs;
  var multipleImages = <AttachmentModel>[].obs;
  var selectedImageForUpdate = (-1).obs;
  var title = TextEditingController(text: '');
  var location = TextEditingController(text: '');
  var cordinates = Rx<LatLng?>(null);
  var description = TextEditingController(text: '');
  // physical product
  var shares = TextEditingController(text: '');
  var basePrice = TextEditingController(text: '');
  // co-owner
  var selectedCategory = Rx<CategoryModel?>(null);
  var selectedSubCategory = Rx<CategoryModel?>(null);
  var itemSize = 'Medium'.obs;
  var itemColor = TextEditingController(text: '');
  var brand = TextEditingController(text: '');
  var condition = 'Excellent'.obs;
  var sellOption = 'Auction'.obs;
  var startDate = Rx<DateTime?>(null);
  var endDate = Rx<DateTime?>(null);
  var price = TextEditingController(text: '');

  var selloptionsList = ["Auction", 'Fix Price'];

  // Api call
  addSellItem() async {
    if (fieldsValidations()) {
      bool success = false;
      if (tabController.value == 1) {
        success = await _addPhysicalProduct();
      } else {
        success = await _addCoOwnerProduct();
      }
      if (success) {
        Get.back();
        clearFields();
      }
    }
  }

  clearFields() {
    singleImage.value = '';
    multipleImages.value = [];
    title.clear();
    location.clear();
    cordinates.value = null;
    description.clear();
    //Physical
    shares.clear();
    basePrice.clear();
    //Co-owner
    selectedCategory.value = null;
    selectedSubCategory.value = null;
    itemSize.value = 'Medium';
    itemColor.clear();
    brand.clear();
    condition.value = 'Excellent';
    sellOption.value = 'Auction';
    selectedCategory.value = null;
    selectedSubCategory.value = null;
    price.clear();
  }

  bool fieldsValidations() {
    // if (singleImage.value == '') {
    //   AppToast.show("Please add item image");
    //   return false;
    // }
    if (multipleImages.isEmpty) {
      AppToast.show("Please add images");
      return false;
    }
    if (title.text.trim() == '') {
      AppToast.show("Please enter title");
      return false;
    }
    if (location.text.trim() == '') {
      AppToast.show("Please add location");
      return false;
    }
    // physical product
    if (tabController.value == 0 && shares.text.trim() == '') {
      AppToast.show("Please enter shares");
      return false;
    }
    if (tabController.value == 0 && basePrice.text.trim() == '') {
      AppToast.show("Please enter base price");
      return false;
    }
    // co-owner
    if (tabController.value == 1 && selectedCategory.value == null) {
      AppToast.show("Please select category");
      return false;
    }
    if (tabController.value == 1 && selectedSubCategory.value == null) {
      AppToast.show("Please select sub category");
      return false;
    }
    if (tabController.value == 1 && itemColor.text.trim() == '') {
      AppToast.show("Please enter color");
      return false;
    }
    if (tabController.value == 1 && itemSize.value.trim() == '') {
      AppToast.show("Please enter size");
      return false;
    }
    if (tabController.value == 1 && brand.text.trim() == '') {
      AppToast.show("Please enter brand");
      return false;
    }
    if (tabController.value == 1 && condition.value.trim() == '') {
      AppToast.show("Please select condition");
      return false;
    }
    if (tabController.value == 1 && sellOption.value.trim() == '') {
      AppToast.show("Please select sell option");
      return false;
    }
    if (tabController.value == 1 && price.text.trim() == '') {
      AppToast.show("Please enter price");
      return false;
    }

    //---
    if (description.text.trim() == '') {
      AppToast.show("Please enter description");
      return false;
    }

    return true;
  }

  /// APi
  _addPhysicalProduct() async {
    List<String> imgs = [];
    List<String> videos = [];
    for (var element in multipleImages) {
      if (element.type == '2') {
        videos.add(element.path);
      } else {
        imgs.add(element.path);
      }
    }
    return await ApiRequests.addPhysicalProduct(
        images: imgs,
        videos: videos,
        title: title.text.trim(),
        location: location.text.trim(),
        cordinates: cordinates.value ?? const LatLng(0.0, 0.0),
        category: (selectedCategory.value?.id ?? '').toString(),
        subcategory: (selectedSubCategory.value?.id ?? '').toString(),
        color: itemColor.text.trim(),
        size: itemSize.value.trim(),
        brand: brand.text.trim(),
        condition: condition.value.trim(),
        selloption: sellOption.value.trim(),
        price: price.text.trim(),
        description: description.text.trim());
  }

  _addCoOwnerProduct() async {
    List<String> imgs = [];
    List<String> videos = [];
    for (var element in multipleImages) {
      if (element.type == '2') {
        videos.add(element.path);
      } else {
        imgs.add(element.path);
      }
    }
    return await ApiRequests.addCoOwnerProduct(
        images: imgs,
        videos: videos,
        title: title.text.trim(),
        location: location.text.trim(),
        cordinates: cordinates.value ?? const LatLng(0.0, 0.0),
        basePrice: basePrice.text.trim(),
        description: description.text.trim(),
        shares: int.parse(shares.text.trim() == '' ? '0' : shares.text.trim()));
  }
}

class AttachmentModel {
  final String path;
  String? thumb;
  final String type; // 0-image, 1-file, 2-video

  AttachmentModel({required this.path, required this.type, this.thumb});
}
