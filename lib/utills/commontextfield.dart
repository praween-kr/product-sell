import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonTextfield extends StatelessWidget {
  double? height;
  double? width;

  String? hintText;
  CommonTextfield({
    Key? key,
    this.height,
    this.width,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
          top: 5,
          bottom: 5,
          left: 20,
          right: 20),
      width: width ?? Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 1),
            color: Colors.grey,
            spreadRadius: 0,
            blurRadius: 2,
          ),
        ],
      ),
      child: TextFormField(
        decoration: InputDecoration(prefixIcon: const Icon(
          Icons.mail_outline_outlined,
          color: Colors.black,size:25,),
            border: InputBorder.none,
            hintText: hintText ?? "",
            hintStyle: const TextStyle(color: Colors.grey),
            contentPadding:
            const EdgeInsets.only(left: 20, bottom: 15, top: 15)),
      ),
    );
  }
}



class CommonTextfield2 extends StatelessWidget {
  double? height;
  double? width;

  String? hintText;
  CommonTextfield2({
    Key? key,
    this.height,
    this.width,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
          top: 5,
          bottom: 5,
          left: 20,
          right: 20),
      width: width ?? Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 1),
            color: Colors.grey,
            spreadRadius: 0,
            blurRadius: 2,
          ),
        ],
      ),
      child: TextFormField(obscureText: true,
        decoration: InputDecoration(prefixIcon: const Icon(
          Icons.lock_open_rounded,
          color: Colors.black,size:25,),
            suffixIcon: const Icon(Icons.remove_red_eye),
            border: InputBorder.none,
            hintText: hintText ?? "",
            hintStyle: const TextStyle(color: Colors.grey),
            contentPadding:
            const EdgeInsets.only(left: 20, bottom: 15, top: 15)),
      ),
    );
  }
}

