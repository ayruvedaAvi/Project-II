import 'package:flutter/material.dart';
import 'package:flutter_project/utils/api/api_endpoint.dart';
import 'package:get/get.dart';
import 'package:flutter_project/models/signup/signup_model.dart';
import 'package:flutter_project/screens/home_screen.dart';

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
        firstName: firstNameController.text,
        lastName: lastnameController.text,
        mobileNo: mobileNumberController.text,
        email: emailController.text,
        password: passwordController.text,
      );
      bool isSignup = false;
      //final isSignup = await ApiEndpoints().signup(signupModel);
      // if (isSignup) {
      //   Get.to(const HomeScreen());
      //   Get.snackbar(
      //     "Sucess",
      //     "You are now logged in.",
      //     backgroundColor: Colors.green,
      //     snackPosition: SnackPosition.TOP,
      //   );
      //   isLoading.value = false;
      // } else {
      //   Get.snackbar(
      //     "Error",
      //     "Invalid email or password",
      //     backgroundColor: Colors.red,
      //     snackPosition: SnackPosition.TOP,
      //   );
      //   isLoading.value = false;
      // }
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
