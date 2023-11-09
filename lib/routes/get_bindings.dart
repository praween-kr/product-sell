import 'package:get/get.dart';
import 'package:oninto_flutter/common_controller/auth/auth_controller.dart';
import 'package:oninto_flutter/common_controller/cms_controller.dart';
import 'package:oninto_flutter/common_controller/home/home_controller.dart';
import 'package:oninto_flutter/common_controller/product/my_product_controller.dart';
import 'package:oninto_flutter/common_controller/product/sellItem_controller.dart';
import 'package:oninto_flutter/common_controller/settings/address_controller.dart';
import 'package:oninto_flutter/common_controller/settings/edit_profile_controller.dart';
import 'package:oninto_flutter/common_controller/settings/settings_controller.dart';
import 'package:oninto_flutter/service/local/userInfo_globle.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
  }
}

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingsController());
  }
}

class GlobleControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(GlobleController(), permanent: true);
  }
}

class EditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditProfileController());
  }
}

class CmsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CmsController());
  }
}

class AddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddressController());
  }
}

class CategoriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CategoriesBinding());
  }
}

class SellItemBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SellItemController());
  }
}

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Homecontroller());
  }
}

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyProductController());
  }
}
