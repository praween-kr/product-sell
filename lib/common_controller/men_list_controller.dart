import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:oninto_flutter/generated/assets.dart';
import 'package:oninto_flutter/model/home_model.dart';

class MenListController extends GetxController {
  RxList<HomeModel> categoryData = RxList([]);
  @override
  void onInit() {
    categoryData = RxList([
      HomeModel(
        image: Assets.assetsMenJean,
        Name: "Jeans",
      ),
      HomeModel(
        image: Assets.assetsShirt,
        Name: "Tshirts",
      ),
      HomeModel(
        image: Assets.assetsShirt,
        Name: "Shirts",
      ),
      HomeModel(
        image: Assets.assetsMenLower,
        Name: "Lowers",
      ),
      HomeModel(
        image: Assets.assetsShorts,
        Name: "Shorts",
      ),
    ]);
    super.onInit();
  }
}
