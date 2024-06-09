import 'package:flutter/material.dart';
import 'package:flutter_project/screens/baseScreens/base_screen.dart';
import 'package:flutter_project/core/api/api_endpoint.dart';
import 'package:get/get.dart';

import 'package:flutter_project/models/login/login_model.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  RxBool isLoading = false.obs;

  Future<void> login() async {
    isLoading.value = true;
    try {
      final loginModel = LoginModel(
        email: emailController.text,
        password: passwordController.text,
      );
      final isLogin = await ApiEndpoints().login(loginModel);
      if (isLogin) {
        Get.to(() => const BaseScreen(initalIndex: 0,));
        Get.snackbar(
          "Sucess",
          "You are now logged in.",
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.TOP,
        );
        isLoading.value = false;
      }else{
        Get.snackbar(
          "Error",
          "Invalid email or password",
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.TOP,
        );
        isLoading.value = false;}
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.TOP,
      );
      isLoading.value = false;
    }
    finally {
      isLoading.value = false;
    }
  }
}
