import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 24, 224, 198),
        title: const Text("Project-II"),
      ),
      backgroundColor: const Color.fromARGB(255, 62, 87, 99),
      body: const Center(
        child: Hero(
          tag: 'text',
          child: Text(
            "Lets start from here.",
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
        ),
      ),
    );
  }
}
