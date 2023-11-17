import 'dart:ui';

import 'package:flutter/material.dart';

class AppBlureWidget {
  static Widget child(
          {required Widget child,
          required Widget blureChild,
          double? height,
          double? width}) =>
      ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: SizedBox(
          height: height,
          width: width,
          child: Stack(
            fit: StackFit.expand,
            children: [
              blureChild,
              ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    color: Colors.grey.withOpacity(0.1),
                    alignment: Alignment.center,
                    child: child,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
