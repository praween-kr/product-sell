import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/generated/assets.dart';
import 'package:oninto_flutter/routes/routes.dart';
import 'package:oninto_flutter/service/local/db_helper.dart';
import 'package:oninto_flutter/service/local/local_store_keys.dart';
import 'package:oninto_flutter/utills/app_print.dart';

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
      Get.offAllNamed(Routes.onboardingScreen);
    });
    super.initState();
  }

  navigate() {
    var userInfo = DbHelper.getMap(SharedPrefKeys.userInfo);
    AppPrint.all("User Info: ${userInfo.toString()}");
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
