import 'package:flutter/material.dart';

class SinglepostScreen extends StatefulWidget {
  final String? profileImg;
  final String? userName;
  final String? workDescription;
  final String? image;
  final String? title;
  final double? price;
  const SinglepostScreen(
      {super.key,
      this.workDescription,
      this.image,
      this.profileImg,
      this.userName,
      this.title,
      this.price});

  @override
  State<SinglepostScreen> createState() => _SinglepostScreenState();
}

class _SinglepostScreenState extends State<SinglepostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Container(
            decoration: BoxDecoration(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
