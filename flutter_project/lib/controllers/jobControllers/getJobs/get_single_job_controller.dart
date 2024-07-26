import 'package:flutter/material.dart';
import 'package:flutter_project/core/api/api_endpoint.dart';
import 'package:flutter_project/models/jobs/jobDetailsModel/job_details_model.dart';
import 'package:flutter_project/utils/constants/colors.dart';
import 'package:get/get.dart';

class GetSingleJobController extends GetxController {
  RxBool isLoading = false.obs;
  JobDetailsModel? jobDetailsModel;
  Future<JobDetailsModel?> getSingleJob(String jobId) async {
    isLoading.value = true;
    try {
      jobDetailsModel = await ApiEndpoints().getSingleJob(jobId);
    } catch (e) {
      Get.showSnackbar(
        GetSnackBar(
          title: "Error ",
          message: e.toString(),
          duration: const Duration(seconds: 4),
          borderRadius: 10.0,
          snackPosition: SnackPosition.TOP,
          borderWidth: 5,
          borderColor: mainColor,
          backgroundColor: Colors.red,
        ),
      );
      return null;
    } finally {
      isLoading.value = false;
    }
    return jobDetailsModel;
  }
}
