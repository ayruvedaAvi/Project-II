import 'package:flutter/material.dart';
import 'package:flutter_project/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    );
    _animation = Tween<double>(begin: 1.0, end: 0.0).animate(_controller);
    _controller.forward();

    _controller.addStatusListener((status) { 
      if(status == AnimationStatus.completed){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const HomeScreen(),),);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Opacity(
          opacity: _animation.value,
          child: const Text("Lets get started muji haru"),
        ),
      ),
    );
  }
}
