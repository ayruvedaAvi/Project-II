import 'package:flutter/material.dart';
import 'package:flutter_project/screens/home_screen.dart';

import 'package:get/get.dart';

class LoginController extends GetxController {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final isLoading = false.obs;

  Future<void> login() async {
    if (_formKey.currentState!.validate()) {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 2));
      isLoading.value = false;
      Get.put(const HomeScreen());
    }
  }

}