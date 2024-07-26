import 'package:flutter/material.dart';
import 'package:flutter_project/widgets/custom_notifycard.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

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
      body: const SingleChildScrollView(
        child: Column(
          children: [
            CustomNotifycard(
              message: "Hello guys! Welcome to my youtube channel",
            ),
          ],
        ),
      ),
    );
  }
}
