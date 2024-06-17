import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserPostedJobScreen extends StatelessWidget {
  const UserPostedJobScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Posted Job Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}