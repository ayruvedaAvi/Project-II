import 'package:flutter/material.dart';
import 'package:flutter_project/models/jobs/getAllJobsModel/get_all_jobs_model.dart';
import 'package:flutter_project/core/api/api_endpoint.dart';
import 'package:flutter_project/utils/constants/colors.dart';
import 'package:get/get.dart';

class GetAllJobsController extends GetxController {
  RxBool isLoading = true.obs;
  GetAllJobsModel? getAllJobsModel;
  Future<GetAllJobsModel?> getAllJobs() async {
    try {
      getAllJobsModel = await ApiEndpoints().getAllJobs();
      return getAllJobsModel;
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
      return null;
    } finally {
      isLoading.value = false;
    }
  }
}
