import 'package:get/get.dart';

class InsightController extends GetxController{

  /// dropDown View
  RxString dropDownValue = 'Last 7 Days'.obs;

  // List of items in our dropdown menu
  RxList<String>insightItems = [
    'Last 7 Days',
    'Day 2',
    'Day 3',
  ].obs;


}