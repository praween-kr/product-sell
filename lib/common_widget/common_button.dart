import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  String? text;
  double? height;
  double? width;
  double? imgHeight;
  double? radius;
  double? imgWidth;
  TextStyle? textStyle;
  String? image;
  FontWeight? fontWeight;
  double? fontSize;
  Color? color;
  Color? borderColor;
  double? borderWidth;
  EdgeInsetsGeometry? margin;
  EdgeInsetsGeometry? imagePadding;
  IconData? iconData;

  CommonButton(
      {super.key,
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
      this.imagePadding});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      margin: margin,
      height: height,
      width: width,
      decoration: BoxDecoration(
          boxShadow: [
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
