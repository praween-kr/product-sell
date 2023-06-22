import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

typedef StringToVoidFunc = void Function(String);

class AppTextField extends StatelessWidget {
  String? name;
  int? maxLength;
  String? title;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? style;
  final Color? suffixIconColor;
  TextEditingController? controller;
  bool? isObscure = false;
  bool? readOnly;
  TextInputType? textInputType = TextInputType.emailAddress;
  double? height;
  TextInputAction? textInputAction;
  double? width;
  final double? elevation;
  final Widget? suffix;
  final Widget? prefix;
  StringToVoidFunc? onChanged;
  EdgeInsetsGeometry? contentPadding;
  int? maxLines;
  BorderRadiusGeometry? borderRadius;
  BoxBorder? border;
  final Color? containerColor;

  AppTextField(
      {Key? key,
      this.title,
      this.style,
      this.suffix,
      this.name,
      this.controller,
      this.containerColor,
      this.elevation,
      this.inputFormatters,
      this.onChanged,
      this.isObscure,
      this.textInputType,
      this.height,
      this.width,
      this.maxLength,
      this.prefix,
      this.textInputAction,
      this.contentPadding,
      this.maxLines,
      this.borderRadius,
      this.border,
      this.suffixIconColor,
      this.readOnly})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 60,
      width: width ?? Get.width,
      decoration: BoxDecoration(
        color: containerColor ?? Colors.white,
        borderRadius: borderRadius ?? BorderRadius.all(Radius.circular(10)),
        border: border,
      ),
      child: TextFormField(
        style: style ??
            TextStyle(
                color: Colors.white.withOpacity(0.4),
                fontWeight: FontWeight.w500,
                fontSize: 13),
        onChanged: onChanged,
        controller: controller,
        inputFormatters: inputFormatters,
        maxLength: maxLength,
        maxLines: maxLines,
        readOnly: readOnly ?? false,
        textInputAction: textInputAction ?? TextInputAction.done,
        obscureText: isObscure ?? false,
        keyboardType: textInputType ?? TextInputType.emailAddress,
        decoration: InputDecoration(
          counterText: "",
          hintText: title,
          suffixIcon: suffix,
          prefixIcon: prefix,
          suffixIconColor: suffixIconColor,
          contentPadding: contentPadding ?? EdgeInsets.only(left: 20, top: 20),
          hintStyle: TextStyle(color: Colors.black.withOpacity(0.4)),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
