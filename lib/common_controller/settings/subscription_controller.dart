import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubscriptionController extends GetxController {
  late PageController pageController;
  RxInt pagePosition = RxInt(0);
  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: pagePosition.value);
  }
}
