import 'package:flutter/material.dart';
import 'package:flutter_project/controllers/signup_controller.dart';
import 'package:flutter_project/screens/authScreens/forgetpass_newpass_screen.dart';
import 'package:flutter_project/utils/constants/colors.dart';
import 'package:get/get.dart';
import 'package:flutter_project/controllers/verify_otp_controller.dart';
import 'package:flutter/services.dart';

class ForgotpassOtpScreen extends StatefulWidget {
  const ForgotpassOtpScreen({super.key});

  @override
  State<ForgotpassOtpScreen> createState() => _ForgotpassOtpScreenState();
}

class _ForgotpassOtpScreenState extends State<ForgotpassOtpScreen> {
  VerifyOtpController verifyOtpController = VerifyOtpController();

  // final _formkey = GlobalKey<FormState>();
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
                left: MediaQuery.of(context).size.width / 4.5,
                // left: 30,
                child: const Text(
                  "Number Verification",
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
                    "Get Your Code",
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
                      "Please enter the 6 digit code that is send to you provided mobile number.",
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
                      key: verifyOtpController.otpFormKey,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 50,
                            width: 50,
                            child: TextFormField(
                              controller: verifyOtpController.o1,
                              onChanged: (value) {
                                if (value.length == 1) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                hintText: '0',
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    )),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    )),
                              ),
                              style: const TextStyle(color: Colors.black),
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            width: 50,
                            child: TextFormField(
                              controller: verifyOtpController.o2,
                              onChanged: (value) {
                                if (value.length == 1) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    )),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    )),
                                hintText: "0",
                              ),
                              style: const TextStyle(color: Colors.black),
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            width: 50,
                            child: TextFormField(
                              controller: verifyOtpController.o3,
                              onChanged: (value) {
                                if (value.length == 1) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    )),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    )),
                                hintText: "0",
                              ),
                              style: const TextStyle(color: Colors.black),
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            width: 50,
                            child: TextFormField(
                              controller: verifyOtpController.o4,
                              onChanged: (value) {
                                if (value.length == 1) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    )),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    )),
                                hintText: "0",
                              ),
                              style: const TextStyle(color: Colors.black),
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            width: 50,
                            child: TextFormField(
                              controller: verifyOtpController.o5,
                              onChanged: (value) {
                                if (value.length == 1) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    )),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    )),
                                hintText: "0",
                              ),
                              style: const TextStyle(color: Colors.black),
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            width: 50,
                            child: TextFormField(
                              controller: verifyOtpController.o6,
                              onChanged: (value) {
                                if (value.length == 1) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    )),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    )),
                                hintText: "0",
                              ),
                              style: const TextStyle(color: Colors.black),
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                            ),
                          ),
                        ],
                      )),
                  const SizedBox(height: 32.0),
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
                        // verifyOtpController.verifyOtp();
                        Get.to(() => const ForgetpassNewpassScreen());
                      },
                      child: verifyOtpController.isLoading.value
                          ? const CircularProgressIndicator()
                          : const Text(
                              "Verify and Proceed",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                    ),
                  ),
                  const SizedBox(height: 32.0),
                  const Text(
                    "Didn't you receive any code?",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                  const SizedBox(height: 25.0),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Resend New Code",
                        style: TextStyle(
                            color: mainColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ))
                ],
              ),
            ),
          ),
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
