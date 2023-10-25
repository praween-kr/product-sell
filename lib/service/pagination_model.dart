import 'package:flutter/material.dart';

class AppPagination {
  int currentPage;
  int totalPage;
  int totalItems;
  int pageLimit;
  AppPagination(
      {this.currentPage = 1,
      this.totalPage = 1,
      this.totalItems = 0,
      this.pageLimit = 10});
}

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
