import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/service/api_requests.dart';
import 'package:oninto_flutter/service/local/userInfo_globle.dart';
import 'package:oninto_flutter/utills/app_toast_loader.dart';
import 'package:oninto_flutter/utills/regex.dart';

class EditProfileController extends GetxController {
  //
  TextEditingController firstName = TextEditingController(text: '');
  TextEditingController lastName = TextEditingController(text: '');
  TextEditingController email = TextEditingController(text: '');
  var countryCode = "93".obs;
  TextEditingController phone = TextEditingController(text: '');
  TextEditingController location = TextEditingController(text: '');

  initialData() {
    GlobleController gc = Get.find();
    firstName.text = gc.userInfo.value?.firstName ?? '';
    lastName.text = gc.userInfo.value?.lastName ?? '';
    email.text = gc.userInfo.value?.email ?? '';
    countryCode.value = gc.userInfo.value?.countryCode ?? '';
    phone.text = gc.userInfo.value?.phone ?? '';
    location.text = '';
  }

  //---- API Call ------
  updateProfile() async {
    if (validation()) {
      bool success = await ApiRequests.updateProfile(
          firstName: firstName.text.trim(),
          lastName: lastName.text.trim(),
          countryCode: countryCode.value,
          email: email.text.trim(),
          phone: phone.text.trim());
      if (success) {
        //
        Get.back();
      }
    }
  }

  /* Validation */
  validation() {
    if (firstName.text.trim() == '') {
      AppToast.show("Please enter first name");
      return false;
    } else if (firstName.text.trim().length <= 2) {
      AppToast.show("Please enter valid first name");
      return false;
    } else if (!AppRegex.nameReg.hasMatch(firstName.text.trim())) {
      AppToast.show("Please enter valid first name");
      return false;
    }
    if (email.text.trim() == '') {
      AppToast.show("Please enter email");
      return false;
    } else if (!AppRegex.emailReg.hasMatch(email.text.trim())) {
      AppToast.show("Please enter valid email");
      return false;
    }

    if (phone.text.trim() == '') {
      AppToast.show("Please enter phone number");
      return false;
    } else if (email.text.trim().length < 8) {
      AppToast.show("Please enter valid phone number");
      return false;
    } else if (!AppRegex.num0to9.hasMatch(phone.text.trim())) {
      AppToast.show("Please enter valid phone number");
      return false;
    }

    // if (location.text.trim() == '') {
    //   AppToast.show("Please add location");
    //   return false;
    // }

    return true;
  }
}
