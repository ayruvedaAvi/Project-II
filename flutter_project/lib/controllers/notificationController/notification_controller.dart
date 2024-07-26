import 'package:flutter_project/core/api/api_endpoint.dart';
import 'package:flutter_project/models/notifications/notification_model.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  RxBool isLoading = false.obs;

  Future<List<NotificationModel>?> getUserNotification() async {
    isLoading.value = true;

    List<NotificationModel>? notifications;

    notifications = await ApiEndpoints().getUserNotification();
    try {
      notifications = await ApiEndpoints().getUserNotification();
    } catch (e) {
      Get.snackbar("Error", e.toString());
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
    return notifications;
  }
}
