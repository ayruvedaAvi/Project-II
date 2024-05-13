import 'package:flutter/material.dart';
import 'package:flutter_project/screens/splash_screen.dart';

class MyApp extends StatelessWidget{
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Project-II"),
        ),
        body: const SplashScreen(),
      ),
    );
  }
}