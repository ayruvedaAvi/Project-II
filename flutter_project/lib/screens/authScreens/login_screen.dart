import 'package:flutter/material.dart';
import 'package:flutter_project/controllers/authControllers/login_controller.dart';
import 'package:flutter_project/screens/authScreens/forgotpass_first_screen.dart';
import 'package:flutter_project/screens/authScreens/register_screen.dart';
import 'package:flutter_project/widgets/custom_text_form_field.dart';

import 'package:get/get.dart';
// import 'dart:math';
//sabai kura thikxa
// List<Color> cColors = [
//   Colors.red,
//   Colors.blue,
//   Colors.green,
//   Colors.yellow,
//   Colors.purple,
//   Colors.orange,
//   Colors.pink,
//   Colors.teal,
//   Colors.brown,
//   Colors.grey,
//   Colors.cyan,
//   Colors.lime,
//   Colors.indigo,
//   Colors.amber,
//   Colors.deepOrange,
//   Colors.lightBlue,
//   Colors.lightGreen,
//   Colors.deepPurple,
//   Colors.blueGrey,
//   Colors.black,
//   Colors.white,
//   Colors.redAccent,
//   Colors.blueAccent,
//   Colors.greenAccent,
//   Colors.yellowAccent,
//   Colors.purpleAccent,
//   Colors.orangeAccent,
//   Colors.pinkAccent,
//   Colors.tealAccent,
//   Colors.brown,
//   Colors.grey,
//   Colors.cyan,
//   Colors.lime,
//   Colors.indigo,
//   Colors.amber,
//   Colors.deepOrange,
//   Colors.lightBlue,
//   Colors.lightGreen,
//   Colors.deepPurple,
//   Colors.blueGrey,
//   Colors.black,
// ];

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final loginController = Get.put(LoginController());
  // bool signUpLoading = false;
  bool rememberCondition = false;
  bool isChecked = false;
  // Random random = Random();

  // final List<AnimationController> _controllers = [];
  // final List<Animation<double>> _blinkAnimations = [];
  // final List<Animation<Offset>> _moveAnimations = [];
  // final List<double> _startTops = [];
  // final List<double> _startLefts = [];
  // final List<double> _endTops = [];
  // final List<double> _endLefts = [];

  // bool _isInitialized = false;

  @override
  void initState() {
    // loginController.isLoading = <RxBool>false;
    super.initState();
    // signUpLoading = false;
    // for (int i = 0; i < 40; i++) {
    //   var controller = AnimationController(
    //     vsync: this,
    //     duration: Duration(milliseconds: 5000 + random.nextInt(2000)),
    //   );
    //   _controllers.add(controller);

    //   var blinkAnimation =
    //       Tween<double>(begin: 0.5, end: 1.0).animate(controller);
    //   _blinkAnimations.add(blinkAnimation);

    //   controller.forward();
    //   controller.addStatusListener((status) {
    //     if (status == AnimationStatus.completed) {
    //       controller.reverse();
    //     } else if (status == AnimationStatus.dismissed) {
    //       Future.delayed(Duration(seconds: random.nextInt(10)), () {
    //         if (mounted) controller.forward();
    //       });
    //     }
    //   });
    // }
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   if (!_isInitialized) {
  //     final size = MediaQuery.of(context).size;
  //     for (int i = 0; i < 40; i++) {
  //       _startTops.add(random.nextDouble() * size.height);
  //       _startLefts.add(random.nextDouble() * size.width);
  //       _endTops.add(random.nextDouble() * size.height);
  //       _endLefts.add(random.nextDouble() * size.width);

  //       var moveAnimation = Tween<Offset>(
  //         begin: Offset(_startLefts[i], _startTops[i]),
  //         end: Offset(_endLefts[i], _endTops[i]),
  //       ).animate(CurvedAnimation(
  //         parent: _controllers[i],
  //         curve: Curves.easeInOut,
  //       ));
  //       _moveAnimations.add(moveAnimation);
  //     }
  //     _isInitialized = true;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  // for (int i = 0; i < 40; i++)
                  //   AnimatedBuilder(
                  //     animation: _controllers[i],
                  //     builder: (context, child) {
                  //       return Transform.translate(
                  //         offset: _moveAnimations[i].value,
                  //         child: Opacity(
                  //           opacity: _blinkAnimations[i].value,
                  //           child: Container(
                  //             height: 15,
                  //             width: 15,
                  //             decoration: BoxDecoration(
                  //               color: cColors[i % cColors.length],
                  //               borderRadius: BorderRadius.circular(10),
                  //             ),
                  //           ),
                  //         ),
                  //       );
                  //     },
                  //   ),
                  ClipPath(
                    clipper: BezierClipper2(),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 3.5,
                      width: double.infinity,
                      color: const Color.fromARGB(199, 177, 95, 255),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height / 9,
                    left: MediaQuery.of(context).size.width / 3.5,
                    // left: 30,
                    child: Text(
                      'welcomeMsg'.tr,
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
              // Opacity(
              //   opacity: 0.95,
              //   child:
              Center(
                // child: SingleChildScrollView(
                // child: Container(
                //   height: 490,
                //   width: 350,
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(15),
                //     boxShadow: [
                //       BoxShadow(
                //         color: Colors.black.withOpacity(0.1),
                //         spreadRadius: 0,
                //         blurRadius: 6,
                //         offset: const Offset(0, 2),
                //       ),
                //       BoxShadow(
                //         color: Colors.black.withOpacity(0.2),
                //         spreadRadius: 0,
                //         blurRadius: 10,
                //         offset: const Offset(0, 6),
                //       ),
                //     ],
                //   ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 40, left: 40),
                  child: Column(
                    children: [
                      // const SizedBox(height: 10),
                      // const Text(
                      //   'Login',
                      //   style: TextStyle(
                      //     fontSize: 25,
                      //     color: Colors.black,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      // const SizedBox(
                      //     width: 70, child: Divider(thickness: 1.5)),
                      Form(
                        key: _formKey,
                        child: Obx(
                          () => Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 50),
                              CustomTextFormField(
                                keyType: TextInputType.emailAddress,
                                controller: loginController.emailController,
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      !value.isEmail) {
                                    return 'invalidMailMsg'.tr;
                                  }
                                  return null;
                                },
                                labelText: 'Email',
                                hintText: 'Enter your email',
                                suffixIcon: const Icon(Icons.person_2_outlined),
                              ),
                              CustomTextFormField(
                                keyType: TextInputType.visiblePassword,
                                controller: loginController.passwordController,
                                obscureText: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'emptyPassword'.tr;
                                  } else {
                                    if (value.length < 6) {
                                      return 'lowPassword'.tr;
                                    }
                                  }
                                  return null;
                                },
                                labelText: 'Password',
                                hintText: 'Enter your password',
                              ),
                              Align(
                                alignment: AlignmentDirectional.centerStart,
                                child: Wrap(
                                  children: [
                                    SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: Checkbox(
                                          checkColor: Colors.white,
                                          activeColor: Colors.purple,
                                          value: isChecked,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              isChecked = value!;
                                              rememberCondition = value;
                                            });
                                          },
                                        )),
                                    const SizedBox(width: 12.0),
                                    Text(
                                      'rememberMe'.tr,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 22.0),
                              SizedBox(
                                height: 50,
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    disabledBackgroundColor:
                                        const Color.fromARGB(
                                            255, 210, 180, 240),
                                    backgroundColor: const Color.fromARGB(
                                        255, 168, 105, 227),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      loginController.login();
                                      loginController.isLoading.value = true;
                                    } else {
                                      loginController.isLoading.value = false;
                                    }
                                  },
                                  child: loginController.isLoading.value
                                      ? const CircularProgressIndicator()
                                      : Text(
                                          'signIn'.tr,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.to(() => const ForgotpassFirstScreen());
                                },
                                child: Text(
                                  'forgetPass'.tr,
                                  style: const TextStyle(
                                      color:
                                          Color.fromARGB(255, 168, 105, 227)),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 50,
                                width: double.infinity,
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    shape: const StadiumBorder(),
                                    side: const BorderSide(
                                      width: 2,
                                      color: Color.fromARGB(255, 168, 105, 227),
                                    ),
                                    foregroundColor: const Color.fromARGB(
                                        255, 168, 105, 227),
                                  ),
                                  onPressed: () {
                                    Get.to(() => const SignupScreen());
                                    setState(() {
                                      // signUpLoading = true;
                                    });
                                  },
                                  child: Text(
                                    'newRegister'.tr,
                                    style: const TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // @override
  // void dispose() {
  //   for (var controller in _controllers) {
  //     controller.dispose();
  //   }
  //   super.dispose();
  // }
}
