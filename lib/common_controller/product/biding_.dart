import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/utils/app_timer.dart';

Future timerDialog(
    {required Function bidNow, required DateTime? endTime}) async {
  print("clicked---- ");
  return showDialog(
    barrierDismissible: true,
    useSafeArea: false,
    context: Get.context!,
    builder: (BuildContext context) {
      return Material(
        type: MaterialType.transparency,
        child: AppTimer(
          bidNow: bidNow,
          endTime: endTime,
        ),
      );
    },
  );
}
