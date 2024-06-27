import 'package:flutter/material.dart';
import 'package:flutter_project/core/api/api_endpoint.dart';
import 'package:flutter_project/screens/authScreens/login_screen.dart';
import 'package:get/get.dart';

import '../../screens/authScreens/forgotpass_otp_screen.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final newPasswordController = TextEditingController();
  RxBool isLoading = false.obs;

  Future<void> verifyEmail() async {
    isLoading.value = true;
    try {
      final isEmailVerified =
          await ApiEndpoints().verifyEmail(emailController.text);
      if (isEmailVerified) {
        Get.to(() => const ForgotpassOtpScreen());
        Get.snackbar(
          "Sucess",
          "Enter otp sent to your email to reset password.",
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.TOP,
        );
        isLoading.value = false;
      } else {
        Get.snackbar(
          "Error",
          "Invalid email.",
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

  Future<void> changePassword() async {
    isLoading.value = true;
    try {
      final isPasswordChanged = await ApiEndpoints().changePassword(
        passwordController.text,
        newPasswordController.text,
      );
      if (isPasswordChanged) {
        Get.snackbar(
          "Success",
          "Password changed successfully",
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.TOP,
        );
        isLoading.value = false;
        Get.to(() => const LoginScreen());
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
}
