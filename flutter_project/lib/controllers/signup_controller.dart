import 'package:flutter/material.dart';
import 'package:flutter_project/screens/authScreens/verifyotp_screen.dart';
import 'package:flutter_project/core/api/api_endpoint.dart';
import 'package:get/get.dart';
import 'package:flutter_project/models/signup/signup_model.dart';

class SignupController extends GetxController {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  RxBool isLoading = false.obs;

  Future<void> signup() async {
    isLoading.value = true;
    try {
      final signupModel = SignupModel(
        name: firstNameController.text,
        lastName: lastnameController.text,
        phoneNumber:"+977 "+ mobileNumberController.text,
        email: emailController.text,
        password: passwordController.text,
      );
      bool isSignup = false;
      isSignup = await ApiEndpoints().signup(signupModel);
      if (isSignup) {
        Get.to(VerifyOtpScreen(
          mobileNo: mobileNumberController.text,
        ));
        Get.snackbar(
          "Sucess",
          "We've sent you an otp on your phone, please verify.",
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.TOP,
        );
        isLoading.value = false;
      } else {
        Get.snackbar(
          "Error",
          "Something went wrong. Please try again.",
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
