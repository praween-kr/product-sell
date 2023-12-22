import 'package:get/get.dart';
import 'package:oninto_flutter/utils/app_type_status.dart';

class EditItemScreenController extends GetxController {
  /// dropDown View
  RxString categoryDropDown = 'Man'.obs;
  // List of items in our dropdown menu
  RxList<String> categoryItems = [
    'Man',
    'Category 2',
    'Category 3',
  ].obs;
  RxString subCategoryDropDown = 'Tshirt'.obs;
  // List of items in our dropdown menu
  RxList<String> subItems = [
    'Tshirt',
    'Sub cat 2',
    'Sub cat 3',
  ].obs;
  RxString colorDropDown = 'Red'.obs;
  // List of items in our dropdown menu
  RxList<String> colorItems = [
    'Red',
    'Color 2',
    'Color 3',
  ].obs;
  RxString sizeDropDown = 'Small'.obs;
  // List of items in our dropdown menu
  RxList<String> sizeItems =
      ['Small', 'Medium', 'Large', 'Extra Large', 'Extra Extra Large'].obs;
  RxString brandDropDown = 'Tommy'.obs;
  // List of items in our dropdown menu
  RxList<String> brandItems = [
    'Tommy',
    'Brand 2',
    'Brand 3',
  ].obs;
  RxString conditionDropDown = 'Excellent'.obs;
  // List of items in our dropdown menu
  RxList<String> conditionItems = [
    'Excellent',
    'Condition 2',
    'Condition 3',
  ].obs;
  RxString sellItemDropDown = 'Bid'.obs;
  // List of items in our dropdown menu
  RxList<String> sellItems =
      ['Bid', ProductType.biding, ProductType.fixedPrice].obs;
}
