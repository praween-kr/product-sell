import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

typedef StringToVoidFunc = void Function(String);

class AppTextField extends StatelessWidget {
  String? name;
  int? maxLength;
  String? title;
  final TextStyle? labelStyle;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? style;
  final Color? suffixIconColor;
  TextEditingController? controller;
  bool? isObscure = false;
  bool? readOnly;
  TextInputType? textInputType = TextInputType.emailAddress;
  double? height;
  TextStyle? hintStyle;
  TextInputAction? keyBoardType;
  double? width;
  TextAlign? textAlign;
  final double? elevation;
  final Widget? suffix;
  final Widget? countryCodePiker;
  final Widget? prefix;
  StringToVoidFunc? onChanged;
  EdgeInsetsGeometry? contentPadding;
  int? maxLines;
  int? minLines;
  BorderRadiusGeometry? borderRadius;
  BoxBorder? border;
  final Color? containerColor;
  EdgeInsetsGeometry? margin;

  AppTextField(
      {Key? key,
      this.title,
      this.style,
      this.suffix,
      this.name,
      this.controller,
        this.hintStyle,
        this.labelStyle,
        this.textAlign,
      this.containerColor,
      this.elevation,
      this.inputFormatters,
      this.onChanged,
      this.isObscure,
      this.textInputType,
      this.height,
      this.width,
        this.minLines,
      this.maxLength,
      this.prefix,
      this.contentPadding,
      this.maxLines,
      this.borderRadius,
      this.border,
      this.suffixIconColor,
      this.readOnly,
      this.margin,
      this.countryCodePiker,
      this.keyBoardType})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 60,
      width: width ?? Get.width,
      margin: margin ?? const EdgeInsets.only(left: 0),
      decoration: BoxDecoration(
        color: containerColor ?? Colors.white,
        borderRadius:
            borderRadius ?? const BorderRadius.all(Radius.circular(10)),
        border: border,
      ),
      child: TextFormField(
        style: style ??
            const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500, fontSize: 15),
        onChanged: onChanged,
        controller: controller,
        inputFormatters: inputFormatters,
        maxLength: maxLength,
        maxLines: maxLines,
        minLines: minLines,
        textAlign: textAlign ?? TextAlign.start,
        readOnly: readOnly ?? false,
        textInputAction: keyBoardType ?? TextInputAction.done,
        obscureText: isObscure ?? false,
        keyboardType: textInputType ?? TextInputType.emailAddress,
        decoration: InputDecoration(
          counterText: "",
          hintText: title,
          suffixIcon: suffix,
          prefixIcon: prefix,
          suffixIconColor: suffixIconColor,
          contentPadding: contentPadding ?? const EdgeInsets.only(left: 20, top: 20),
          hintStyle: hintStyle ??TextStyle(color: Colors.black.withOpacity(0.4)),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
