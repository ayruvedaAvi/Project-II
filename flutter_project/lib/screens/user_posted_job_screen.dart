import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserPostedJobScreen extends StatelessWidget {
  const UserPostedJobScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        shadowColor: Colors.grey,
        title: const Text('User Posted Job Screen'),
      ),
      backgroundColor: Colors.white,
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
