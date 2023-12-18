import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

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
      var localData = DateFormat("yyyy-MM-ddTHH:mm:ss")
          .parse(dt!, true)
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
    if (timeOfDay == null) return "";
    final now = DateTime.now();
    DateTime dt = DateTime(
        now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);

    return DateFormat("hh:mm a").format(dt);
  }

  static String time24hr({TimeOfDay? timeOfDay, String? timeString}) {
    if (timeOfDay == null) return "";
    final now = DateTime.now();
    DateTime dt = DateTime(
        now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);

    return DateFormat("HH:mm").format(dt);
  }

  // print(timeago.format(fifteenAgo, locale: 'en_short')); // 15m
  // print(timeago.format(fifteenAgo, locale: 'es')); // hace 15 minutos
}
