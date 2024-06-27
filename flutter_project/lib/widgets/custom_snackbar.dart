import 'package:flutter/material.dart';
// import 'package:flutter_project/utils/constants/colors.dart';
import 'package:get/get.dart';

class CustomSnackbar extends StatelessWidget {
  final String title;
  final String body;
  final String type;
  const CustomSnackbar(
      {super.key, required this.body, required this.title, required this.type});

  @override
  Widget build(BuildContext context) {
    return GetSnackBar(
      title: title,
      message: body,
      duration: const Duration(seconds: 4),
      borderRadius: 10.0,
      snackPosition: SnackPosition.TOP,
      borderWidth: 5,
      // borderColor: mainColor,
      backgroundColor: Colors.red,
    );
  }
}
