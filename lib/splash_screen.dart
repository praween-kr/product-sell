import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/routes/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 5), () {
      Get.offAllNamed(Routes.loginScreen);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        // child: Image.asset(Assets.assetsRent-fpLogoImage,scale: 5,
        // ),
      ),
    );
  }
}
