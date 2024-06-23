import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditJobController extends GetxController {
  RxBool isLoading = true.obs;
  Future<void> editJob() async {
    try {
      // Add your API endpoint here
    } catch (e) {
      Get.showSnackbar(
        GetSnackBar(
          title: "Error",
          message: e.toString(),
          duration: const Duration(seconds: 4),
          borderRadius: 10.0,
          snackPosition: SnackPosition.TOP,
          borderWidth: 5,
          borderColor: Colors.red,
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      isLoading.value = false;
    }
  }
}