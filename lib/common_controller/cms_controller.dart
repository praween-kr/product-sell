import 'package:get/state_manager.dart';
import 'package:oninto_flutter/model/auth/cms_model.dart';
import 'package:oninto_flutter/service/api_requests.dart';

class CmsController extends GetxController {
  var loadingData = false.obs;
  var title = ''.obs;
  var cmsData = ''.obs;

  getcms(String type) async {
    await ApiRequests.getCMS(
      type: type,
      data: (CmsModel? data) {
        title.value = data?.title ?? '';
        cmsData.value = data?.content ?? '';
      },
      loading: (loading) {
        loadingData.value = loading;
      },
    );
  }
}

class CmsType {
  static String privacyPolicy = '3';
  static String help = '6';
  static String aboutUs = '1';
  static String termsAndConditions = '2';
}
