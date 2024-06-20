import 'package:flutter/material.dart';
import 'package:flutter_project/screens/baseScreens/base_screen.dart';
import 'package:flutter_project/core/api/api_endpoint.dart';
import 'package:get/get.dart';

class VerifyOtpController extends GetxController {
  final o1 = TextEditingController();
  final o2 = TextEditingController();
  final o3 = TextEditingController();
  final o4 = TextEditingController();
  final o5 = TextEditingController();
  final o6 = TextEditingController();
  final otpFormKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;

  void verifyOtp() {
    isLoading.value = true;
    if (otpFormKey.currentState!.validate()) {
      // Verify OTP
      ApiEndpoints().verifyOtp(
        o1.text + o2.text + o3.text + o4.text + o5.text + o6.text, false
      ).then((isVerified) {
        if (isVerified) {
          Get.snackbar(
            "Success",
            "OTP verified successfully",
            backgroundColor: Colors.green,
            snackPosition: SnackPosition.TOP,
          );
          isLoading.value = false;
          Get.off(() => const BaseScreen(initalIndex: 0));
        } else {
          Get.snackbar(
            "Error",
            "Invalid OTP",
            backgroundColor: Colors.red,
            snackPosition: SnackPosition.TOP,
          );
          isLoading.value = false;
        }
      }).catchError((e) {
        Get.snackbar(
          "Error",
          e.toString(),
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.TOP,
        );
        isLoading.value = false;
      });
    }
  }
  void verifyOtpForgotPass() {
    isLoading.value = true;
    if (otpFormKey.currentState!.validate()) {
      // Verify OTP
      ApiEndpoints().verifyOtp(
        o1.text + o2.text + o3.text + o4.text + o5.text + o6.text, true
      ).then((isVerified) {
        if (isVerified) {
          Get.snackbar(
            "Success",
            "OTP verified successfully",
            backgroundColor: Colors.green,
            snackPosition: SnackPosition.TOP,
          );
          isLoading.value = false;
          Get.off(() => const BaseScreen(initalIndex: 0));
        } else {
          Get.snackbar(
            "Error",
            "Invalid OTP",
            backgroundColor: Colors.red,
            snackPosition: SnackPosition.TOP,
          );
          isLoading.value = false;
        }
      }).catchError((e) {
        Get.snackbar(
          "Error",
          e.toString(),
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.TOP,
        );
        isLoading.value = false;
      });
    }
  }
}