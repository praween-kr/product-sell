import 'package:flutter/material.dart';

class CommonModel {
  String image = "";
  String title = "";
  String description = "";
  Color? color;

  CommonModel(
      {required this.image,
      required this.title,
      required this.description,
      this.color});
}
