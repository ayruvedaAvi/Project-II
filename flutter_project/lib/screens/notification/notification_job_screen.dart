import 'package:flutter/material.dart';
import 'package:flutter_project/utils/constants/colors.dart';

class NotificationJobScreen extends StatelessWidget {
  const NotificationJobScreen({
    super.key,
    required this.jobId,
  });

  final String jobId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        foregroundColor: Colors.white,
        title: const Text(
          "Job Details",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Text("Job ID: $jobId"),
      ),
    );
  }
}
