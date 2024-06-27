import 'package:flutter_project/core/api/api_endpoint.dart';
import 'package:get/get.dart';

class DeleteJobController extends GetxController {
  RxBool isLoading = false.obs;

  Future<void> deleteJob(String jobId) async {
    isLoading.value = true;
    try {
      var isJobDeleted = await ApiEndpoints().deleteJob(jobId: jobId);
      if (isJobDeleted) {
        Get.snackbar('Success', 'Job deleted successfully');
        isLoading.value = false;
      } else {
        Get.snackbar('Error', 'Failed to delete job');
        isLoading.value = false;
      }
    } catch (e) {
      Get.snackbar('Failed', e.toString());
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }
}
