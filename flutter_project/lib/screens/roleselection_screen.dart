import 'package:flutter/material.dart';
import 'package:flutter_project/widgets/custom_card.dart';

class RoleselectionScreen extends StatefulWidget {
  const RoleselectionScreen({super.key});

  @override
  State<RoleselectionScreen> createState() => _RoleselectionScreenState();
}

class _RoleselectionScreenState extends State<RoleselectionScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 245, 245),
      body: Center(
          child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Join us as",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30,
            ),
            CustomCard(
              descText:
                  "As a work provider you can provide the short term works near to you.",
              buttonText: "A Work Provider",
            ),
            SizedBox(
              height: 20,
            ),
            CustomCard(
              descText:
                  "As a worker you can comfortably work for jobs that you are expert at and available near to you.",
              buttonText: "A Worker",
            ),
          ],
        ),
      )),
    );
  }
}
