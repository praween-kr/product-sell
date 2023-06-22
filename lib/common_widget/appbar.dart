import 'package:flutter/material.dart';

class CommonAppbar extends StatelessWidget {
  String? title;
  Color? color;
  BorderRadiusGeometry? borderRadius;
  BoxBorder? border;
  final Color? containerColor;

  CommonAppbar(
      {this.title,
      this.color,
      this.containerColor,
      this.border,
      this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      centerTitle: true,
      leading: Container(),
    ));
  }
}
