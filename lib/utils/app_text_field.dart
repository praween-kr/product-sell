import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

typedef StringToVoidFunc = void Function(String);

class AppTextField extends StatelessWidget {
  final String? name;
  final int? maxLength;
  final String? title;
  final TextStyle? labelStyle;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? style;
  final Color? suffixIconColor;
  final TextEditingController? controller;
  final bool? isObscure;
  final bool? readOnly;
  final TextInputType? textInputType ;
  final double? height;
  final TextStyle? hintStyle;
  final TextInputAction? keyBoardType;
  final double? width;
  final TextAlign? textAlign;
  final double? elevation;
  final Widget? suffix;
  final Widget? countryCodePiker;
  final Widget? prefix;
  final StringToVoidFunc? onChanged;
  final EdgeInsetsGeometry? contentPadding;
  final int? maxLines;
  final int? minLines;
  final BorderRadiusGeometry? borderRadius;
  final BoxBorder? border;
  final Color? containerColor;
  final EdgeInsetsGeometry? margin;
  final FocusNode? focusNode;
  final Function? onClick;
  final Function(String)? onFieldSubmitted;

  const AppTextField(
      {super.key,
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
      this.keyBoardType,
      this.focusNode,
      this.onClick,
      this.onFieldSubmitted});
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
      child: Center(
        child: TextFormField(
          onFieldSubmitted: onFieldSubmitted,
          onTap: onClick == null ? null : () => onClick!(),
          style: style ??
              const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
          onChanged: onChanged,
          focusNode: focusNode,
          controller: controller,
          inputFormatters: inputFormatters,
          maxLength: maxLength,
          maxLines: maxLines ?? 1,
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
            contentPadding:
                contentPadding ?? const EdgeInsets.only(left: 20, top: 20),
            hintStyle:
                hintStyle ?? TextStyle(color: Colors.black.withOpacity(0.4)),
            border: const OutlineInputBorder(borderSide: BorderSide.none),
          ),
        ),
      ),
    );
  }
}
