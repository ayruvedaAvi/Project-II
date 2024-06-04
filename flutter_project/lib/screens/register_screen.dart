import 'package:flutter/material.dart';
import 'package:flutter_project/controllers/signup_controller.dart';
import 'package:flutter_project/screens/login_screen.dart';
import 'package:flutter_project/widgets/custom_text_form_field.dart';
import 'package:get/get.dart';
// import 'package:flutter_project/screens/verifyOTP_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
          child: Column(
            children: [
              const Text(
                "Create your account",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
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
                        controller: signUpController.firstNameController,
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
                          controller: signUpController.lastnameController,
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
                    const SizedBox(height: 22.0),
                    CustomTextFormField(
                      keyType: TextInputType.phone,
                      controller: signUpController.mobileNumberController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid number!';
                        }
                        return null;
                      },
                      labelText: "Mobile Number",
                      suffixIcon: const Icon(Icons.local_phone_rounded),
                    ),
                    const SizedBox(height: 22.0),
                    CustomTextFormField(
                      keyType: TextInputType.emailAddress,
                      controller: signUpController.emailController,
                      labelText: "Email",
                      validator: (value) {
                        if (value == null || value.isEmpty || !value.isEmail) {
                          return 'Please enter a valid email!';
                        }
                        return null;
                      },
                      suffixIcon: const Icon(Icons.mail),
                    ),
                    const SizedBox(height: 22.0),
                    CustomTextFormField(
                      keyType: TextInputType.visiblePassword,
                      controller: signUpController.passwordController,
                      labelText: 'Password',
                      hintText: 'Enter your password',
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
                    const SizedBox(height: 22.0),
                    CustomTextFormField(
                      validator: (p0) =>
                          p0 != signUpController.passwordController.text
                              ? "Password does not match"
                              : null,
                      keyType: TextInputType.visiblePassword,
                      controller: signUpController.confirmPasswordController,
                      labelText: "Confirm Password",
                      hintText: 'Confirm password',
                      obscureText: true,
                      // suffixIcon: const Icon(Icons.remove_red_eye),
                    ),
                    //Terms and condition Checkbox
                    const SizedBox(height: 22.0),
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
                            backgroundColor:
                                const Color.fromARGB(255, 24, 224, 198),
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
                    const SizedBox(height: 22.0),
                    const Text(
                      "Or",
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 15.0),
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
            ],
          ),
        ),
      ),
    );
  }
}
