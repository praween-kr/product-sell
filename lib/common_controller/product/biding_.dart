import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/utils/app_print.dart';
import 'package:oninto_flutter/utils/app_timer.dart';

Future timerDialog(
    {required Function bidNow,
    required DateTime startDateTime,
    required Function(TimerType) onChnage,
    required bool bidingStarted}) async {
  AppPrint.info("clicked---- ");
  return showDialog(
    barrierDismissible: true,
    useSafeArea: false,
    context: Get.context!,
    builder: (BuildContext context) {
      return Material(
        type: MaterialType.transparency,
        child: AppTimer(
          bidNow: bidNow,
          viewType: false,
          textSize: 14,
          // Timer status change listener
          onChanged: onChnage,
          // Biding timer duration
          duration: const Duration(minutes: 5),
          // No bid added yet then-> Start bid date time else-> last bid date time
          startDateTime: startDateTime,
          // At list one bid added then will be [bidingStarted: true] else [bidingStarted: false]
          bidingStarted: bidingStarted,
        ),
      );
    },
  );
}
