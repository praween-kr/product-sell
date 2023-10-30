import 'dart:developer';

import 'package:flutter/cupertino.dart';

class AppPrint {
  static info(String info) {
    debugPrint(info);
  }

  //
  static error(String text) {
    print('\x1B[31m$text\x1B[0m');
  }

  static all(String text) {
    log(text);
  }
}
