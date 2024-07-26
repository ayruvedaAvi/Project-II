import 'package:flutter/material.dart';
import 'package:flutter_project/controllers/notificationController/notification_controller.dart';
import 'package:flutter_project/widgets/custom_notifycard.dart';
import 'package:get/get.dart';

import '../../models/notifications/notification_model.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {

  NotificationController notificationController = Get.put(NotificationController());
  Rxn<List<NotificationModel>> notifications = Rxn<List<NotificationModel>>();

  void getNotifications(){
    notificationController.getUserNotification().then((value) {
      if(value != null){
        notifications.value = value;
      }
    });
  }

  @override
  void initState() {
    getNotifications();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // shadowColor: Colors.grey,
        // elevation: 5,
        title: const Text(
          "Notifications",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: Icon(
              Icons.notifications_active,
              color: Colors.black,
            ),
          )
        ],
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Obx(() {
        if (notificationController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (notifications.value == null || notifications.value!.isEmpty) {
          return const Center(child: Text("No notifications available."));
        }
        return ListView.builder(
          itemCount: notifications.value!.length,
          itemBuilder: (context, index) {
            final notification = notifications.value![index];
            return CustomNotifycard(message: notification.body);
          },
        );
      }),
    );
  }
}
