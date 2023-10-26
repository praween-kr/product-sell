import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/routes/routes.dart';
import 'package:oninto_flutter/service/api_requests.dart';
import 'package:oninto_flutter/service/local/db_helper.dart';
import 'package:oninto_flutter/service/local/local_store_keys.dart';
import 'package:oninto_flutter/utills/app_print.dart';
import 'package:oninto_flutter/utills/app_toast_loader.dart';
import 'package:oninto_flutter/utills/regex.dart';

class AuthController extends GetxController {
  /// -------- Sign In --------///
  // other
  var passVisible = true.obs;
  var rememberMe = false.obs;
  //
  TextEditingController inputPhoneEmail = TextEditingController(text: '');
  var countryCode = "93".obs;
  var usernameIsPhoneType = false.obs;
  TextEditingController inputPassword = TextEditingController(text: '');
  //
  var agree = false.obs;
  TextEditingController firstName = TextEditingController(text: '');
  TextEditingController lastName = TextEditingController(text: '');
  TextEditingController email = TextEditingController(text: '');
  TextEditingController phone = TextEditingController(text: '');
  TextEditingController location = TextEditingController(text: '');

  /// -------- Api Call ----------
  signin() async {
    if (signInputValid()) {
      bool success = await ApiRequests.signin(
          phoneEmail: inputPhoneEmail.text.trim(),
          password: inputPassword.text.trim());
      if (success) {
        if (rememberMe.value) {
          DbHelper.saveMap(key: SharedPrefKeys.authcredentialRemember, data: {
            'username': inputPhoneEmail.text.trim(),
            'password': inputPassword.text.trim()
          });
        }
        clearSignIn();
        AppPrint.info("Signin successfully!");
        //  Get.offAllNamed(Routes.bottomScreen);
      } else {
        AppPrint.error("Signin failed!");
      }
    }
  }

  signup() async {
    if (signUpInputValid()) {
      bool success = await ApiRequests.signup(
          firstName: firstName.text.trim(),
          lastName: lastName.text.trim(),
          countryCode: countryCode.value,
          email: email.text.trim(),
          phone: phone.text.trim());
      if (success) {
        clearSignUp();
        AppPrint.info("Signup successfully!");
        Get.toNamed(Routes.verificationScreen);
        //  Get.offAllNamed(Routes.bottomScreen);
      } else {
        AppPrint.error("Signup failed!");
      }
    }
  }

  /// -------- Clear Input Fields -------
  clearSignIn() {
    inputPhoneEmail.clear();
    inputPassword.clear();
    countryCode.value = "93";
    rememberMe.value = false;
    passVisible.value = true;
  }

  clearSignUp() {
    firstName.clear();
    lastName.clear();
    email.clear();
    phone.clear();
    countryCode.value = "93";
    location.clear();
    agree.value = false;
  }

  /// -------- Validations ---------
  /* Sign In */
  signInputValid() {
    if (inputPhoneEmail.text.trim() == '') {
      AppToast.show("Please enter username(phone or email)");
      return false;
    }
    if (inputPassword.text.trim() == '') {
      AppToast.show("Please enter password");
      return false;
    }
    return true;
  }

  /* Sign Up */
  signUpInputValid() {
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

    if (location.text.trim() == '') {
      AppToast.show("Please add location");
      return false;
    }
    if (!agree.value) {
      AppToast.show("Please agree with our privacy policy");
      return false;
    }
    return true;
  }
}
