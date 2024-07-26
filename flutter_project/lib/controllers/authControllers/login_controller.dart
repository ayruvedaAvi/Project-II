import 'package:flutter/material.dart';
import 'package:flutter_project/screens/authScreens/login_screen.dart';
import 'package:flutter_project/screens/baseScreens/base_screen.dart';
import 'package:flutter_project/core/api/api_endpoint.dart';
import 'package:flutter_project/utils/shared_preferences/shared_preference.dart';
import 'package:get/get.dart';

import 'package:flutter_project/models/login/login_model.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  RxBool isLoading = false.obs;

  Future<void> login() async {
    isLoading.value = true;
    try {
      final fcmToken =
          await UserSharedPreference.getStringDataFromStorage('fcmToken');
      final loginModel = LoginModel(
        email: emailController.text,
        password: passwordController.text,
      );
      bool isLogin = await ApiEndpoints().login(loginModel);
      if (isLogin) {
        isLogin = await ApiEndpoints().storeFcmToken(fcmToken);
      }
      if (isLogin) {
        Get.to(() => const BaseScreen(
              initialIndex: 0,
            ));
        Get.snackbar(
          "Sucess",
          "You are now logged in.",
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.TOP,
        );
        isLoading.value = false;
      } else {
        Get.snackbar(
          "Error",
          "Invalid email or password",
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.TOP,
        );
        isLoading.value = false;
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.TOP,
      );
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    isLoading.value = true;
    try {
      bool isLogout = await ApiEndpoints().logout();
      if (!isLogout) {
        Get.snackbar(
          "Error",
          "Failed to logout, try again later.",
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.TOP,
        );
      }
      Get.offAll(() => const LoginScreen());
      Get.snackbar(
        "Sucess",
        "You are now logged out.",
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.TOP,
      );
      isLoading.value = false;
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.TOP,
      );
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }
}
