import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:oninto_flutter/generated/assets.dart';

class AppToast {
  static show(String msg, {Color? bgColor}) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.black.withOpacity(0.8),
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }
}

class AppLoader {
  static show() {
    Get.dialog(
      barrierDismissible: false,
      Center(
        child: Wrap(
          children: [
            Center(
              child: Material(
                color: Colors.transparent,
                child: Stack(
                  children: [
                    Lottie.asset(Assets.lottieLoader, width: 120),
                    Positioned(
                      bottom: 10,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: 120,
                          alignment: Alignment.bottomCenter,
                          child: const Text(
                            "Please wait...",
                            style: TextStyle(
                                color: Color.fromARGB(255, 76, 46, 3),
                                fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      barrierColor: Colors.black45,
    );
  }

  static hide() {
    if (Get.isDialogOpen!) {
      Get.back();
    }
  }

  static Widget showWidget() {
    return const Center(
      child: Wrap(
        children: [
          Center(
            child: Material(
              color: Colors.transparent,
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 8),
                  Text(
                    "Please wait...",
                    style: TextStyle(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
