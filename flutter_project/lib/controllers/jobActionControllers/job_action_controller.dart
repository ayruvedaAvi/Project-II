
import 'package:flutter/material.dart';
import 'package:flutter_project/core/api/api_endpoint.dart';
import 'package:get/get.dart';

import '../../utils/constants/colors.dart';

class JobActionController extends GetxController {

  RxBool isLoading = false.obs;

  void apply(jobId) async {
    isLoading.value = true;
    bool applied = false;
    try {
      applied = await ApiEndpoints().applyJob(jobId);
    } catch (e) {
      Get.showSnackbar(
        GetSnackBar(
          title: "Error",
          message: e.toString(),
          duration: const Duration(seconds: 4),
          borderRadius: 10.0,
          snackPosition: SnackPosition.TOP,
          borderWidth: 5,
          borderColor: mainColor,
          backgroundColor: Colors.red,
        ),
      );
      isLoading.value = false;
    }
    if (applied) {
      Get.showSnackbar(
        const GetSnackBar(
          title: "Success",
          message: 'Applied successfully',
          duration: Duration(seconds: 4),
          borderRadius: 10.0,
          snackPosition: SnackPosition.TOP,
          borderWidth: 5,
          borderColor: mainColor,
          backgroundColor: Colors.green,
        ),
      );
      isLoading.value = false;
    } else {
      Get.showSnackbar(
        const GetSnackBar(
          title: "Error",
          message: 'Error applying job',
          duration: Duration(seconds: 4),
          borderRadius: 10.0,
          snackPosition: SnackPosition.TOP,
          borderWidth: 5,
          borderColor: mainColor,
          backgroundColor: Colors.red,
        ),
      );
      isLoading.value = false;
    }
  }

  void acceptJob(jobId, workerId) async {

    isLoading.value = true;
    bool accepted = false;
    try {
      accepted = await ApiEndpoints().acceptJob(jobId, workerId);
    } catch (e) {
      Get.showSnackbar(
        GetSnackBar(
          title: "Error",
          message: e.toString(),
          duration: const Duration(seconds: 4),
          borderRadius: 10.0,
          snackPosition: SnackPosition.TOP,
          borderWidth: 5,
          borderColor: mainColor,
          backgroundColor: Colors.red,
        ),
      );
      isLoading.value = false;
    }
    if (accepted) {
      Get.showSnackbar(
        const GetSnackBar(
          title: "Success",
          message: 'Job accepted successfully',
          duration: Duration(seconds: 4),
          borderRadius: 10.0,
          snackPosition: SnackPosition.TOP,
          borderWidth: 5,
          borderColor: mainColor,
          backgroundColor: Colors.green,
        ),
      );
      isLoading.value = false;
    } else {
      Get.showSnackbar(
        const GetSnackBar(
          title: "Error",
          message: 'Error accepting job',
          duration: Duration(seconds: 4),
          borderRadius: 10.0,
          snackPosition: SnackPosition.TOP,
          borderWidth: 5,
          borderColor: mainColor,
          backgroundColor: Colors.red,
        ),
      );
      isLoading.value = false;
    }

  }
}
