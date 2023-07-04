import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class PasswordController extends GetxController{

  RxBool oldPassword = true.obs;
  final oldPasswordTextController = TextEditingController();

  RxBool newPassword = true.obs;
  final newPasswordTextController = TextEditingController();

  RxBool confirmNewPassword = true.obs;
  final confirmNewPasswordTextController = TextEditingController();
}