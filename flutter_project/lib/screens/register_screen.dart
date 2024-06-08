import 'package:flutter/material.dart';
import 'package:flutter_project/controllers/signup_controller.dart';
import 'package:flutter_project/screens/login_screen.dart';
import 'package:flutter_project/widgets/custom_text_form_field.dart';
import 'package:get/get.dart';
import 'dart:math';

// import 'package:flutter_project/screens/verifyOTP_screen.dart';

List<Color> cColors = [
  Colors.red,
  Colors.blue,
  Colors.green,
  Colors.yellow,
  Colors.purple,
  Colors.orange,
  Colors.pink,
  Colors.teal,
  Colors.brown,
  Colors.grey,
  Colors.cyan,
  Colors.lime,
  Colors.indigo,
  Colors.amber,
  Colors.deepOrange,
  Colors.lightBlue,
  Colors.lightGreen,
  Colors.deepPurple,
  Colors.blueGrey,
  Colors.black,
  Colors.white,
  Colors.redAccent,
  Colors.blueAccent,
  Colors.greenAccent,
  Colors.yellowAccent,
  Colors.purpleAccent,
  Colors.orangeAccent,
  Colors.pinkAccent,
  Colors.tealAccent,
  Colors.brown,
  Colors.grey,
  Colors.cyan,
  Colors.lime,
  Colors.indigo,
  Colors.amber,
  Colors.deepOrange,
  Colors.lightBlue,
  Colors.lightGreen,
  Colors.deepPurple,
  Colors.blueGrey,
  Colors.black,
];

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
    with TickerProviderStateMixin {
  bool isChecked = false;
  final _formkey = GlobalKey<FormState>();
  final signUpController = Get.put(SignupController());
  Random random = Random();

  final List<AnimationController> _controllers = [];
  final List<Animation<double>> _blinkAnimations = [];
  final List<Animation<Offset>> _moveAnimations = [];
  final List<double> _startTops = [];
  final List<double> _startLefts = [];
  final List<double> _endTops = [];
  final List<double> _endLefts = [];

  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 40; i++) {
      var controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 5000 + random.nextInt(2000)),
      );
      _controllers.add(controller);

      var blinkAnimation =
          Tween<double>(begin: 0.5, end: 1.0).animate(controller);
      _blinkAnimations.add(blinkAnimation);

      controller.forward();
      controller.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          Future.delayed(Duration(seconds: random.nextInt(10)), () {
            if (mounted) controller.forward();
          });
        }
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      final size = MediaQuery.of(context).size;
      for (int i = 0; i < 40; i++) {
        _startTops.add(random.nextDouble() * size.height);
        _startLefts.add(random.nextDouble() * size.width);
        _endTops.add(random.nextDouble() * size.height);
        _endLefts.add(random.nextDouble() * size.width);

        var moveAnimation = Tween<Offset>(
          begin: Offset(_startLefts[i], _startTops[i]),
          end: Offset(_endLefts[i], _endTops[i]),
        ).animate(CurvedAnimation(
          parent: _controllers[i],
          curve: Curves.easeInOut,
        ));
        _moveAnimations.add(moveAnimation);
      }
      _isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        for (int i = 0; i < 30; i++)
          AnimatedBuilder(
            animation: _controllers[i],
            builder: (context, child) {
              return Transform.translate(
                offset: _moveAnimations[i].value,
                child: Opacity(
                  opacity: _blinkAnimations[i].value,
                  child: Container(
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                      color: cColors[i % cColors.length],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              );
            },
          ),
        Opacity(
          opacity: 0.90,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 650,
                    width: 350,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 0,
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 0,
                          blurRadius: 10,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          const Text(
                            "Create your account",
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                              width: 250, child: Divider(thickness: 1.5)),
                          const SizedBox(height: 25.0),
                          //Form
                          Form(
                            key: _formkey,
                            child: Column(
                              children: [
                                Row(children: [
                                  Expanded(
                                    child: CustomTextFormField(
                                      keyType: TextInputType.name,
                                      controller:
                                          signUpController.firstNameController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter a valid name!';
                                        }
                                        return null;
                                      },
                                      labelText: "First Name",
                                      suffixIcon:
                                          const Icon(Icons.account_circle),
                                    ),
                                  ),
                                  const SizedBox(width: 16.0),
                                  Expanded(
                                    child: CustomTextFormField(
                                      keyType: TextInputType.name,
                                      controller:
                                          signUpController.lastnameController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter a valid name!';
                                        }
                                        return null;
                                      },
                                      labelText: "Last Name",
                                    ),
                                  )
                                ]),
                                CustomTextFormField(
                                  keyType: TextInputType.phone,
                                  controller:
                                      signUpController.mobileNumberController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a valid number!';
                                    }
                                    return null;
                                  },
                                  labelText: "Mobile Number",
                                  suffixIcon:
                                      const Icon(Icons.local_phone_rounded),
                                ),

                                CustomTextFormField(
                                  keyType: TextInputType.emailAddress,
                                  controller: signUpController.emailController,
                                  labelText: "Email",
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        !value.isEmail) {
                                      return 'Please enter a valid email!';
                                    }
                                    return null;
                                  },
                                  suffixIcon: const Icon(Icons.mail),
                                ),
                                CustomTextFormField(
                                  keyType: TextInputType.visiblePassword,
                                  controller:
                                      signUpController.passwordController,
                                  labelText: 'Password',
                                  // hintText: 'Enter your password',
                                  obscureText: true,
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value.length < 6) {
                                      return 'Please enter a valid password!';
                                    }
                                    return null;
                                  },
                                  // suffixIcon: const Icon(Icons.remove_red_eye),
                                ),
                                CustomTextFormField(
                                  validator: (p0) => p0 !=
                                          signUpController
                                              .passwordController.text
                                      ? "Password does not match"
                                      : null,
                                  keyType: TextInputType.visiblePassword,
                                  controller: signUpController
                                      .confirmPasswordController,
                                  labelText: "Confirm Password",
                                  // hintText: 'Confirm password',
                                  obscureText: true,
                                  // suffixIcon: const Icon(Icons.remove_red_eye),
                                ),

                                //Terms and condition Checkbox
                                Wrap(
                                  children: [
                                    SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: Checkbox(
                                          value: isChecked,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              isChecked = value!;
                                            });
                                          },
                                        )),
                                    const SizedBox(width: 12.0),
                                    const Text.rich(TextSpan(children: [
                                      TextSpan(
                                          text: "I agree to",
                                          style: TextStyle(
                                            color: Colors.black,
                                          )),
                                      TextSpan(
                                          text: " Privacy Policy ",
                                          style: TextStyle(
                                            color: Colors.blue,
                                          )),
                                      TextSpan(
                                          text: "and",
                                          style: TextStyle(
                                            color: Colors.black,
                                          )),
                                      TextSpan(
                                          text: " Terms of use.",
                                          style: TextStyle(
                                            color: Colors.blue,
                                          )),
                                    ]))
                                  ],
                                ),
                                const SizedBox(height: 22.0),
                                //Sign up button
                                Obx(
                                  () => SizedBox(
                                    width: double.infinity,
                                    height: 50,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                            255, 168, 105, 227),
                                      ),
                                      onPressed: () {
                                        if (_formkey.currentState!.validate()) {
                                          signUpController.signup();
                                        }
                                      },
                                      child: signUpController.isLoading.value
                                          ? const CircularProgressIndicator()
                                          : const Text(
                                              "Create Account",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 18.0),
                  const Text(
                    "Or",
                    style: TextStyle(fontSize: 18),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(fontSize: 18),
                    ),
                    TextButton(
                        onPressed: () {
                          Get.to(() => const LoginScreen());
                        },
                        child: const Text(
                          "Sign in",
                          style: TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ))
                  ]),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
