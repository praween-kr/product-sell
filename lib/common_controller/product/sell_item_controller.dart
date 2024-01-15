import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oninto_flutter/model/home/category_model.dart';
import 'package:oninto_flutter/model/product/product_details_model.dart';
import 'package:oninto_flutter/service/api_requests.dart';
import 'package:oninto_flutter/utils/app_toast_loader.dart';
import 'package:oninto_flutter/utils/app_type_status.dart';

class SellItemController extends GetxController {
  var tabController = 1.obs;

  // List of items in our dropdown menu
  RxList<String> sizeItems = ['Select Size'].obs;
  RxString dropDownValue5 = 'Tommy'.obs;
  // List of items in our dropdown menu

  // List of items in our dropdown menu
  RxList<String> conditionItems = [
    'Excellent',
    'Condition 2',
    'Condition 3',
  ].obs;

  /// ----------- FORM AND API ------------------------------ ///

  var categoriesList = <CategoryModel>[].obs;
  var subCategoriesList = <CategoryModel>[].obs;

  ///
  var singleImage = ''.obs;
  var singleImageType = ''.obs;
  var isNetworkTypeImg = false.obs;
  var multipleImages = <AttachmentModel>[].obs;
  var selectedImageForUpdate = (-1).obs;
  var title = TextEditingController(text: '');
  var location = TextEditingController(text: '');
  var cordinates = Rx<LatLng?>(null);
  var description = TextEditingController(text: '');
  // physical product
  var shares = TextEditingController(text: '');
  var basePrice = TextEditingController(text: '');
  var bidTime = TextEditingController(text: '');
  // co-owner
  var selectedCategory = Rx<CategoryModel?>(null);
  var selectedSubCategory = Rx<CategoryModel?>(null);
  var itemSize = 'Select Size'.obs;
  var itemColor = TextEditingController(text: '');
  var brand = TextEditingController(text: '');
  var condition = 'Excellent'.obs;
  var sellOption = ProductType.biding.obs;
  var bidDate = Rx<DateTime?>(null);
  var startDate = Rx<DateTime?>(null);
  var endDate = Rx<DateTime?>(null);
  var price = TextEditingController(text: '');
  var startBidingTime = Rx<TimeOfDay?>(null);

  var productSizeList = <String>[].obs;

  var selloptionsList = [ProductType.biding, ProductType.fixedPrice];

  var oldImagesIdList = <String>[].obs;

  ///

  // var multipleImagesURL = <AttachmentModel>[].obs;

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

  editSellItem() async {
    bool success = false;
    if (tabController.value == 1) {
      success = await _editPhysicalProduct();
    } else {
      // success = await _addCoOwnerProduct();
    }
    if (success) {
      Get.back();
      clearFields();
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
    itemSize.value = 'Select Size';
    itemColor.clear();
    brand.clear();
    condition.value = 'Excellent';
    sellOption.value = ProductType.biding;
    selectedCategory.value = null;
    selectedSubCategory.value = null;
    price.clear();
  }

  initialData(ProductDetails? product) {
    // multipleImages.value = [];
    productIdForEdit.value = (product?.id ?? '').toString();

    multipleImages.value = (product?.productImages ?? [])
        .map((e) => AttachmentModel(
            path: e.image ?? '',
            type: e.thumbnail == null ? '0' : '2',
            thumb: e.thumbnail,
            isNetwork: true,
            id: e.id))
        .toList();
    //
    title.text = product?.name ?? '';
    location.text = product?.location ?? '';
    cordinates.value = LatLng(double.parse(product?.latitude ?? "0.0"),
        double.parse(product?.longitude ?? "0.0"));
    description.text = product?.description ?? '';
    //Physical
    shares.text = (product?.share ?? 0).toString();
    basePrice.text = product?.price ?? '';
    //Co-owner
    for (var element in categoriesList) {
      if (element.id == product?.category?.id) {
        selectedCategory.value = element;
        break;
      }
    }
    // selectedSubCategory.value = product?.category?.subCategory;
    itemSize.value = 'Select Size';
    itemColor.text = product?.color ?? '';
    brand.text = product?.brand ?? '';
    condition.value = 'Excellent';
    sellOption.value = product?.sellOption ?? ProductType.biding;
    price.text = product?.price ?? '';
  }

  bool fieldsValidations() {
    // if (singleImage.value == '') {
    //   AppToast.show("Please add item image");
    //   return false;
    // }
    bool noImagesAdded = false;
    for (var img in multipleImages) {
      if (!img.isNetwork) {
        noImagesAdded = true;
        break;
      }
    }
    if (!noImagesAdded) {
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
    if (tabController.value == 1 && itemSize.value.trim() == 'Select Size') {
      AppToast.show("Please select size");
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
        description: description.text.trim(),
        startBidingTime: startBidingTime.value,
        startDate: startDate.value,
        endDate: endDate.value);
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

  ///
  var productIdForEdit = ''.obs;
  _editPhysicalProduct() async {
    List<String> imgs = [];
    List<String> videos = [];
    for (var element in multipleImages) {
      if (!element.isNetwork) {
        if (element.type == '2') {
          videos.add(element.path);
        } else {
          imgs.add(element.path);
        }
      }
    }
    return await ApiRequests.editPhysicalProduct(
        id: productIdForEdit.value,
        images: imgs,
        oldImagesId: oldImagesIdList,
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
        description: description.text.trim(),
        startBidingTime: startBidingTime.value,
        startDate: startDate.value,
        endDate: endDate.value);
  }
  //
}

class AttachmentModel {
  final String path;
  String? thumb;
  final String type; // 0-image, 1-file, 2-video
  bool isNetwork;
  int? id;

  AttachmentModel(
      {required this.path,
      required this.type,
      this.thumb,
      this.isNetwork = false,
      this.id});
}
