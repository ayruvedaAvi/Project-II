import 'package:flutter/material.dart';
import 'package:flutter_project/utils/constants/colors.dart';
import 'package:flutter_project/widgets/custom_notifycard.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // shadowColor: Colors.grey,
        // elevation: 5,
        automaticallyImplyLeading: false,
        backgroundColor: borderButtonColor,
        foregroundColor: Colors.white,
        title: const Text(
          "Notifications",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: Icon(
              Icons.notifications_active,
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: const SingleChildScrollView(
        child: Column(
          children: [
            CustomNotifycard(
              message: "Hello guys! Welcome to my youtube channel",
            ),
            CustomNotifycard(
              message: "Hello guys! Welcome to my discord channel",
            ),
            CustomNotifycard(
              message: "Hello guys! Welcome to my facebook channel",
            ),
            CustomNotifycard(
              message: "Hello guys! Welcome to my instagram channel",
            ),
            CustomNotifycard(
              message: "Hello guys! Welcome to my twitter channel",
            ),
            CustomNotifycard(
              message: "Hello guys! Welcome to my youtube channel",
            ),
            CustomNotifycard(
              message: "Hello guys! Welcome to my discord channel",
            ),
            CustomNotifycard(
              message: "Hello guys! Welcome to my facebook channel",
            ),
            CustomNotifycard(
              message: "Hello guys! Welcome to my instagram channel",
            ),
            CustomNotifycard(
              message: "Hello guys! Welcome to my twitter channel",
            ),
            CustomNotifycard(
              message: "Hello guys! Welcome to my youtube channel",
            ),
            CustomNotifycard(
              message: "Hello guys! Welcome to my discord channel",
            ),
            CustomNotifycard(
              message: "Hello guys! Welcome to my facebook channel",
            ),
            CustomNotifycard(
              message: "Hello guys! Welcome to my instagram channel",
            ),
            CustomNotifycard(
              message: "Hello guys! Welcome to my twitter channel",
            ),
            CustomNotifycard(
              message: "Hello guys! Welcome to my youtube channel",
            ),
            CustomNotifycard(
              message: "Hello guys! Welcome to my discord channel",
            ),
            CustomNotifycard(
              message: "Hello guys! Welcome to my facebook channel",
            ),
            CustomNotifycard(
              message: "Hello guys! Welcome to my instagram channel",
            ),
            CustomNotifycard(
              message: "Hello guys! Welcome to my twitter channel",
            ),
          ],
        ),
      ),
    );
  }
}
