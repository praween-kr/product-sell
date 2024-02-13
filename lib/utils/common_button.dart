import 'package:flutter/material.dart';

import 'app_text.dart';
import 'color_constant.dart';

class CommonButton extends StatelessWidget {
  final String? text;
  final Widget? child;
  final double? height;
  final double? width;
  final double? imgHeight;
  final double? radius;
  final double? imgWidth;
  final TextStyle? textStyle;
  final String? image;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? color;
  final Color? borderColor;
  final double? borderWidth;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? imagePadding;
  final EdgeInsetsGeometry? padding;
  final IconData? iconData;

  const CommonButton(
      {super.key,
      this.child,
      this.text,
      this.height,
      this.width,
      this.imgHeight,
      this.imgWidth,
      this.radius,
      this.textStyle,
      this.fontWeight,
      this.fontSize,
      this.image,
      this.color,
      this.margin,
      this.borderColor,
      this.borderWidth,
      this.iconData,
      this.imagePadding,
      this.padding});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      margin: margin,
      height: height ?? 50,
      width: width,
      decoration: BoxDecoration(
          boxShadow: const [
            //BoxShadow(color: const Color(0xffFDA2C5), blurRadius: 15)
          ],
          color: color ?? Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(radius ?? 25)),
          border: Border.all(
              color: borderColor ?? Colors.transparent,
              width: borderWidth ?? 0.8)),
      child: Row(
        mainAxisAlignment: image != null
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.center,
        children: [
          //   const  IconiconData??Icon(Icons.arrow_forward) ,
          image != null
              ? Padding(
                  padding: imagePadding ?? const EdgeInsets.only(left: 15),
                  child: Image.asset(
                      height: imgHeight,
                      width: imgWidth,
                      color: Colors.white,
                      image ?? ""),
                )
              : Container(),
          child ??
              Text(
                text ?? "",
                style: textStyle,
              ),
          image != null
              ? SizedBox(
                  height: imgHeight,
                  width: imgWidth,
                )
              : Container(),
        ],
      ),
    );
  }
}

class AppButton {
  static Widget tabText(
      {required String title, required Function onClick, bool active = false}) {
    return GestureDetector(
      onTap: () => onClick(),
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            AppText(
              text: title,
              textSize: 14,
              color: active ? AppColor.appColor : AppColor.grey,
            ),
            const SizedBox(height: 3),
            Container(
              width: 100,
              height: 2,
              color: active ? AppColor.appColor : Colors.transparent,
            )
          ],
        ),
      ),
    );
  }

  static Widget text(
      {required String title, required Function onClick, bool active = true}) {
    return GestureDetector(
      onTap: () => onClick(),
      child: Container(
        color: Colors.transparent,
        child: AppText(
          text: title,
          textSize: 14,
          color: active ? AppColor.appColor : AppColor.grey,
          underline: true,
          underlineColor: AppColor.appColor,
        ),
      ),
    );
  }
}
