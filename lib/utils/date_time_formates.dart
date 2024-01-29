import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oninto_flutter/utils/app_print.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'color_constant.dart';

class AppDateTime {
  static getTimeAgo(String? dt) {
    if ((dt ?? '') == '') {
      return '';
    } else {
      var localData = DateFormat("yyyy-MM-ddTHH:mm:ss")
          .parse(dt!, true)
          .toLocal()
          .toString();
      return timeago.format(DateTime.parse(localData));
    }
  }

  static dynamic getDateTime(String? dt, {DateFormat? format}) {
    if ((dt ?? '') == '') {
      return null;
    } else {
      String temp = dt!;
      AppPrint.info("formating dt:: $temp");
      if (!dt.toString().contains('T')) {
        temp += 'T00:00:00';
      }
      var localData = DateFormat("yyyy-MM-ddTHH:mm:ss")
          .parse(temp, true)
          .toLocal()
          .toString();
      if (format != null) {
        return format.format(DateTime.parse(localData));
      } else {
        return DateTime.parse(localData);
      }
    }
  }

  static String time12hr({TimeOfDay? timeOfDay, String? timeString}) {
    if (timeOfDay != null) {
      final now = DateTime.now();
      DateTime dt = DateTime(
          now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);

      return DateFormat("hh:mm a").format(dt);
    }

    if (timeString != null) {
      TimeOfDay temp = TimeOfDay(
          hour: int.parse(timeString.split(":")[0]),
          minute: int.parse(timeString.split(":")[1]));

      final now = DateTime.now();
      DateTime dt =
          DateTime(now.year, now.month, now.day, temp.hour, temp.minute);

      return DateFormat("hh:mm a").format(dt);
    }
    return "";
  }

  static String time24hr({TimeOfDay? timeOfDay, String? timeString}) {
    if (timeOfDay != null) {
      final now = DateTime.now();
      DateTime dt = DateTime(
          now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);

      return DateFormat("HH:mm").format(dt);
    }
    if (timeString != null) {
      TimeOfDay temp = TimeOfDay(
          hour: int.parse(timeString.split(":")[0]),
          minute: int.parse(timeString.split(":")[1]));
      final now = DateTime.now();
      DateTime dt =
          DateTime(now.year, now.month, now.day, temp.hour, temp.minute);

      return DateFormat("HH:mm").format(dt);
    }

    return "";
  }

  static String defaultDateTime(DateTime dateTime) {
    return DateFormat("yyyy-MM-dd").format(dateTime);
  }

  // print(timeago.format(fifteenAgo, locale: 'en_short')); // 15m
  // print(timeago.format(fifteenAgo, locale: 'es')); // hace 15 minutos
}

class AppDateTimePicker {
  /// datePicker View
  static void pickDate({required Function(DateTime?) onChanged}) async {
    DateTime? pickedDate = await showDatePicker(
        builder: (context, Widget? child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: const ColorScheme.dark(
                onPrimary: AppColor.white,
                primary: AppColor.appColor,
                surface: AppColor.white,
                onSurface: AppColor.blackColor,
              ),
              dialogBackgroundColor: AppColor.white,
            ),
            child: child!,
          );
        },
        context: Get.context!,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2040));
    onChanged(pickedDate);
  }
}
