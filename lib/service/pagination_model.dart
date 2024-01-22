import 'package:flutter/material.dart';

class AppPaginationViews {
  static loading() => Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 18.0,
            width: 18.0,
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          ),
          SizedBox(width: 8),
          Text("loading..."),
        ],
      ));

  static noMore() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: const Text("No more data"),
      );
}
