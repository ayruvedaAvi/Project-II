import 'package:flutter/material.dart';
import 'package:flutter_project/screens/baseScreens/base_screen.dart';
import 'package:flutter_project/screens/onBoardingScreen/onboarding_screen.dart';
import 'package:flutter_project/utils/shared_preferences/shared_preference.dart';
// import 'package:flutter_project/widgets/custom_profiledetailscard.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const route = 'notification-screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  String? token;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();

    _controller.addStatusListener(
      (status) async {
        if (status == AnimationStatus.completed) {
          // check if the token has expired or not
          RxBool hasExpired = false.obs;
          String? userToken =
              await UserSharedPreference.getStringDataFromStorage('token');
          if (userToken != null) {
            hasExpired.value = JwtDecoder.isExpired(userToken);
            if (!hasExpired.value) {
              token = userToken;
            } else {
              token = null;
            }
          }
          if (token != null) {
            Get.off(() => const BaseScreen(
                  initalIndex: 0,
                ));
          } else {
            Get.off(() => const OnBordingScreen());
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Opacity(
                opacity: _animation.value,
                child: Hero(
                  tag: 'text',
                  child: Image.asset('assets/images/logo.png'),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
