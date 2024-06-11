import 'package:flutter/material.dart';
import 'package:flutter_project/screens/authScreens/login_screen.dart';
import 'package:flutter_project/widgets/custom_text_form_field.dart';
import 'package:get/get.dart';
import 'package:flutter_project/controllers/signup_controller.dart';

class ForgetpassNewpassScreen extends StatefulWidget {
  const ForgetpassNewpassScreen({super.key});

  @override
  State<ForgetpassNewpassScreen> createState() =>
      _ForgetpassNewpassScreenState();
}

class _ForgetpassNewpassScreenState extends State<ForgetpassNewpassScreen> {
  final _formkey = GlobalKey<FormState>();
  final signUpController = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(children: [
          Stack(
            // fit: StackFit.expand,
            children: [
              ClipPath(
                clipper: BezierClipper2(),
                child: Container(
                  height: MediaQuery.of(context).size.height / 3,
                  width: double.infinity,
                  color: const Color.fromARGB(199, 177, 95, 255),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 7,
                left: MediaQuery.of(context).size.width / 3.5,
                // left: 30,
                child: const Text(
                  "Reset Password",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ],
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                children: [
                  const Text(
                    "Enter New Password",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 143, 69, 211)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Center(
                    child: Text(
                      "Enter the new password for your account.",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          keyType: TextInputType.visiblePassword,
                          controller: signUpController.passwordController,
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
                          validator: (p0) =>
                              p0 != signUpController.passwordController.text
                                  ? "Password does not match"
                                  : null,
                          keyType: TextInputType.visiblePassword,
                          controller:
                              signUpController.confirmPasswordController,
                          labelText: "Confirm Password",
                          // hintText: 'Confirm password',
                          obscureText: true,
                          // suffixIcon: const Icon(Icons.remove_red_eye),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              disabledBackgroundColor:
                                  const Color.fromARGB(255, 210, 180, 240),
                              backgroundColor:
                                  const Color.fromARGB(255, 168, 105, 227),
                            ),
                            onPressed: () {
                              // if (_formkey.currentState!.validate()) {
                              //   signUpController.signup();
                              // }
                              Get.to(() => const LoginScreen());
                            },
                            child: signUpController.isLoading.value
                                ? const CircularProgressIndicator()
                                : const Text(
                                    "Continue",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}

class BezierClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final width = size.width;
    final height = size.height;
    final heightOffset = height * 0.2;
    Path path = Path();
    path.lineTo(
      0, // x value
      height - heightOffset, // y value
    );
    path.quadraticBezierTo(
      width * 0.25, // x1 (Control Point)
      height, // y1 (Control Point)
      width * 0.5, // x2 (End Point)
      height - heightOffset, // y2 (End Point)
    );
    path.quadraticBezierTo(
      width * 0.75, // P1(x1)
      height - (heightOffset * 2), // P1(y1)
      width, // P2(x2)
      height - heightOffset, // P2(y2)
    );
    path.lineTo(width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
