import 'package:flutter/material.dart';
import 'package:flutter_project/core/api/api_endpoint.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:image_picker/image_picker.dart';


class PostJobController extends GetxController {
  var title = TextEditingController();
  var workDescription = TextEditingController();
  var price = TextEditingController();
  var image = TextEditingController();
  RxBool isLoading = false.obs;
  XFile? imageFile;

  Future<void> postJob(imageFile) async {
    isLoading.value = true;
    bool isJobPosted = false;
    try {
      isJobPosted = await ApiEndpoints().postJob(title:title, workDescription: workDescription, price: price, imageFile: imageFile);
      if (isJobPosted) {
        Get.snackbar(
          "Success",
          "Job posted successfully",
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.TOP,
        );
        isLoading.value = false;
      } else {
        Get.snackbar(
          "Error",
          "Failed to post job",
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
