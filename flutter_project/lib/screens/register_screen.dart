import 'package:flutter/material.dart';
import 'package:flutter_project/controllers/signup_controller.dart';
import 'package:flutter_project/screens/verifyotp_screen.dart';
import 'package:flutter_project/widgets/custom_text_form_field.dart';
import 'package:get/get.dart';
// import 'package:flutter_project/screens/verifyOTP_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController mobileNoController = TextEditingController();
  bool isChecked = false;
  final _formkey = GlobalKey<FormState>();
  final signUpController = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 24, 224, 198),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(children: [
                  const Text(
                    "Create your account",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  const SizedBox(height: 32.0),
                  //Form
                  Form(
                      key: _formkey,
                      child: Obx(() => Column(children: [
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
                                suffixIcon: const Icon(Icons.account_circle),
                              )),
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
                            const SizedBox(height: 32.0),
                            CustomTextFormField(
                              keyType: TextInputType.phone,
                              controller:
                                  signUpController.mobileNumberController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a valid name!';
                                }
                                return null;
                              },
                              labelText: "Mobile Number",
                              suffixIcon: const Icon(Icons.local_phone_rounded),
                            ),
                            const SizedBox(height: 32.0),
                            CustomTextFormField(
                              keyType: TextInputType.emailAddress,
                              controller: signUpController.emailController,
                              labelText: "Email",
                              suffixIcon: const Icon(Icons.mail),
                            ),
                            const SizedBox(height: 32.0),
                            CustomTextFormField(
                              keyType: TextInputType.visiblePassword,
                              controller: signUpController.passwordController,
                              labelText: "Enter Password",
                              suffixIcon: const Icon(Icons.remove_red_eye),
                            ),
                            const SizedBox(height: 32.0),
                            CustomTextFormField(
                              keyType: TextInputType.visiblePassword,
                              controller:
                                  signUpController.confirmPasswordController,
                              labelText: "Confirm Password",
                              suffixIcon: const Icon(Icons.remove_red_eye),
                            ),
                            //Terms and condition Checkbox
                            const SizedBox(height: 32.0),
                            Row(
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
                                const SizedBox(width: 16.0),
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
                            const SizedBox(height: 32.0),
                            //Sign up button
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 24, 224, 198),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => VerifyotpScreen(
                                              mobileNo: mobileNoController.text
                                                  .toString())));
                                  // print("$emailController");
                                },
                                child: const Text(
                                  "Create Account",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ]))),
                ]))));
  }
}
