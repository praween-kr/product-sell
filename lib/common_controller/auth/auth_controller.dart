import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oninto_flutter/Socket/app_socket.dart';
import 'package:oninto_flutter/routes/routes.dart';
import 'package:oninto_flutter/service/api_requests.dart';
import 'package:oninto_flutter/service/local/db_helper.dart';
import 'package:oninto_flutter/service/local/local_store_keys.dart';
import 'package:oninto_flutter/service/local/user_info_global.dart';
import 'package:oninto_flutter/utils/app_print.dart';
import 'package:oninto_flutter/utils/app_toast_loader.dart';
import 'package:oninto_flutter/utils/regex.dart';

class AuthController extends GetxController {
  /// -------- Sign In --------///
  // other
  var passVisible = true.obs;
  var rememberMe = false.obs;
  //
  TextEditingController inputPhoneEmail = TextEditingController(text: '');
  var countryCode = "93".obs;
  var pickedProfileImage = "".obs;
  var usernameIsPhoneType = false.obs;
  TextEditingController inputPassword = TextEditingController(text: '');
  //
  var agree = false.obs;
  TextEditingController firstName = TextEditingController(text: '');
  TextEditingController lastName = TextEditingController(text: '');
  TextEditingController email = TextEditingController(text: '');
  TextEditingController phone = TextEditingController(text: '');
  TextEditingController location = TextEditingController(text: '');
  var cordinates = Rx<LatLng?>(null);
  TextEditingController password = TextEditingController(text: '');
  TextEditingController confirmPassword = TextEditingController(text: '');
  var passwordVisible = true.obs;
  var confirmPasswordVisible = true.obs;

  //
  var otp = ''.obs;
  var verifyEmail = ''.obs;

  /// -------- Api Call ----------
  signin() async {
    if (signInputValid()) {
      String username = inputPhoneEmail.text.trim();
      if (usernameIsPhoneType.value) {
        username = "${countryCode.value} $username";
      }
      bool success = await ApiRequests.signin(
          phoneEmail: username, password: inputPassword.text.trim());
      if (success) {
        if (rememberMe.value) {
          DbHelper.saveMap(key: SharedPrefKeys.authcredentialRemember, data: {
            'username': username,
            'password': inputPassword.text.trim(),
            'remember': true,
          });
        } else {
          DbHelper.deleteData(SharedPrefKeys.authcredentialRemember);
        }
        clearSignIn();

        AppPrint.info("Signin successfully!");
        //---Navigation---
        if (UserStoredInfo().userInfo?.isOtpVerify == 1) {
          NavigateTo.home();
        } else {
          verifyEmail.value = UserStoredInfo().userInfo?.email ?? '';
          AppToast.show("Please enter static otp 1111");
          Get.toNamed(Routes.verificationScreen);
        }
      } else {
        AppPrint.error("Signin failed!");
      }
    }
  }

  signup() async {
    if (signUpInputValid()) {
      bool success = await ApiRequests.signup(
          profileImage: pickedProfileImage.value.trim(),
          firstName: firstName.text.trim(),
          lastName: lastName.text.trim(),
          countryCode: countryCode.value,
          email: email.text.trim(),
          phone: phone.text.trim(),
          location: location.text.trim(),
          cordinates: cordinates.value,
          password: password.text.trim(),
          confirmPassword: confirmPassword.text.trim());
      if (success) {
        clearSignUp();
        AppPrint.info("Signup successfully!");
        verifyEmail.value = UserStoredInfo().userInfo?.email ?? '';
        AppToast.show("Please enter static otp 1111");
        Get.toNamed(Routes.verificationScreen);
      } else {
        AppPrint.error("Signup failed!");
      }
    }
  }

  verity() async {
    if (otp.value.length < 4) {
      AppToast.show("Please enter otp");
    } else {
      bool success = await ApiRequests.verifyWithOtp(
          email: verifyEmail.value.trim(), otp: otp.value);
      if (success) {
        AppPrint.info("Verify successfully!");
        NavigateTo.home();
      } else {
        AppPrint.error("Verification failed!");
      }
    }
  }

  resendOtp() async {
    bool success = await ApiRequests.resendOtp(email: verifyEmail.value.trim());
    if (success) {
      AppPrint.info("Otp sent successfully!");
    } else {
      AppPrint.error("Otp sent failed!");
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
    cordinates.value = null;
    password.clear();
    confirmPassword.clear();
  }

  /// -------- Validations ---------
  /* Sign In */
  signInputValid() {
    if (inputPhoneEmail.text.trim() == '') {
      AppToast.show("Please enter email or phone number");
      return false;
    }
    if (usernameIsPhoneType.value && inputPhoneEmail.text.trim().length < 8) {
      AppToast.show("Please enter correct phone number");
      return false;
    }
    if (!usernameIsPhoneType.value &&
        !AppRegex.emailReg.hasMatch(inputPhoneEmail.text.trim())) {
      AppToast.show("Please enter correct email");
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
    } else if (phone.text.trim().length < 8) {
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
    if (password.text.trim() == '') {
      AppToast.show("Please enter password");
      return false;
    }
    if (confirmPassword.text.trim() == '') {
      AppToast.show("Please enter confirm password");
      return false;
    }
    if (password.text.trim() != confirmPassword.text.trim()) {
      AppToast.show("Password and confirm password does not match");
      return false;
    }
    if (!agree.value) {
      AppToast.show("Please agree with our privacy policy");
      return false;
    }
    return true;
  }

  @override
  void onInit() {
    super.onInit();
    storeRemeberCredential();
  }

  /// Remember login credential
  storeRemeberCredential() {
    var loginCredential =
        DbHelper.getMap(SharedPrefKeys.authcredentialRemember);
    AppPrint.info("loginCredential: $loginCredential");
    if (loginCredential != null) {
      inputPhoneEmail.text = loginCredential['username'] ?? '';
      //
      if (inputPhoneEmail.text.contains(' ')) {
        countryCode.value = inputPhoneEmail.text.split(' ').first;
        inputPhoneEmail.text = inputPhoneEmail.text.split(' ').last;
        usernameIsPhoneType.value =
            AppRegex.num0to9Only.hasMatch(inputPhoneEmail.text);
      }
      inputPassword.text = loginCredential['password'] ?? '';
      rememberMe.value = loginCredential['remember'] ?? false;
    }
  }
}

///----------------------Navigation---------------
class NavigateTo {
  static home() {
    AppSocket().init();
    Get.offAllNamed(Routes.bottomScreen);
  }

  static login() {
    Get.offAllNamed(Routes.loginScreen);
  }
}
