import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordController extends GetxController{

  RxBool oldPassword = true.obs;
  final oldPasswordTextController = TextEditingController();

  RxBool newPassWord = true.obs;
   final newPasswordTextController = TextEditingController();

  RxBool confirmNewPass = true.obs;
  final confirmNewPassTextController = TextEditingController();
}