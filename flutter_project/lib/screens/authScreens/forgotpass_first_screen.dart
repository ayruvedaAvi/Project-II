import 'package:flutter/material.dart';
import 'package:flutter_project/widgets/custom_text_form_field.dart';
import 'package:get/get.dart';

import '../../controllers/authControllers/forgot_password_controller.dart';

class ForgotpassFirstScreen extends StatefulWidget {
  const ForgotpassFirstScreen({super.key});

  @override
  State<ForgotpassFirstScreen> createState() => _ForgotpassFirstScreenState();
}

class _ForgotpassFirstScreenState extends State<ForgotpassFirstScreen> {
  final _formkey = GlobalKey<FormState>();
  final forgotPasswordController = Get.put(ForgotPasswordController());

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
                  "Forgot Password",
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
                    "Enter your email",
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
                      "Enter the email address associated with your account to change password.",
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
                          keyType: TextInputType.emailAddress,
                          controller: forgotPasswordController.emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty || !value.isEmail) {
                              return 'Please enter a valid email address!';
                            }
                            return null;
                          },
                          labelText: "Email",
                          suffixIcon: const Icon(Icons.email_outlined),
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
                              if (_formkey.currentState!.validate()) {
                                forgotPasswordController.verifyEmail();
                              }
                            },
                            child: forgotPasswordController.isLoading.value
                                ? const CircularProgressIndicator()
                                : const Text(
                                    "Recover Password",
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
