
import 'package:flutter/material.dart';
import 'package:flutter_project/models/job/job_model.dart';
import 'package:flutter_project/utils/api/api_endpoint.dart';
import 'package:get/get.dart';

class PostJobController extends GetxController {
  var title = TextEditingController();
  var workDescription = TextEditingController();
  var price = TextEditingController();
  var image = TextEditingController();
  RxBool isLoading = false.obs;

  Future<void> postJob() async {
    isLoading.value = true;
    bool isJobPosted = false;
    try {
      final jobModel = JobModel(
        Title: "static title",
        Work_Description: workDescription.text,
        price: 200000,
        image: "https://res.cloudinary.com/debjnxbys/image/upload/v1716720647/file-upload/file_sohtyi.jpg",
      );
      isJobPosted = await ApiEndpoints().postJob(jobModel);
      if(isJobPosted){
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