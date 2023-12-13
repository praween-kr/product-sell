import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/generated/assets.dart';
import 'package:oninto_flutter/model/auth/user_info_model.dart';
import 'package:oninto_flutter/routes/routes.dart';
import 'package:oninto_flutter/service/local/db_helper.dart';
import 'package:oninto_flutter/service/local/local_store_keys.dart';
import 'package:oninto_flutter/utils/app_print.dart';

import 'common_controller/auth/auth_controller.dart';
import 'service/local/userInfo_global.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      navigate();
    });
    super.initState();
  }

  navigate() {
    var userInfo = DbHelper.getMap(SharedPrefKeys.userInfo);
    AppPrint.all("User Info: ${userInfo.toString()}");
    if (userInfo != null && userInfo['token'] != '') {
      UserStoredInfo().storeUserInfo(UserInfoModel.fromJson(userInfo));
      NavigateTo.home();
    } else {
      Get.offAllNamed(Routes.onboardingScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset(
          Assets.assetsSplash,
          fit: BoxFit.fill,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}
