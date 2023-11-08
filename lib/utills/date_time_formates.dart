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

  // print(timeago.format(fifteenAgo, locale: 'en_short')); // 15m
  // print(timeago.format(fifteenAgo, locale: 'es')); // hace 15 minutos
}
