import 'package:flutter/material.dart';

import 'package:flutter_project/controllers/login_controller.dart';
import 'package:flutter_project/screens/register_screen.dart';
import 'package:flutter_project/widgets/custom_text_form_field.dart';

import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Theme.of(context).colorScheme.primary,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(height: 10),
              const Text(
                'Login',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned.fill(
                        top: -220,
                        child: Opacity(
                          opacity: 0.8,
                          child: Image.asset('assets/images/logo.png',
                              height: 600, width: 00),
                        ),
                      ),
                      Opacity(
                        opacity: 0.5,
                        child: Container(
                          decoration: BoxDecoration(
                            // color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 500,
                          width: 300,
                        ),
                      ),
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
                                    return 'Please enter a valid email address';
                                  }
                                  return null;
                                },
                                labelText: 'Email',
                                hintText: 'Enter your email',
                                suffixIcon: const Icon(Icons.person_2_outlined),
                              ),
                              const SizedBox(height: 20),
                              CustomTextFormField(
                                keyType: TextInputType.visiblePassword,
                                controller: loginController.passwordController,
                                obscureText: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a password';
                                  } else {
                                    if (value.length < 6) {
                                      return 'Password must be at least 6 characters long';
                                    }
                                  }
                                  return null;
                                },
                                labelText: 'Password',
                                hintText: 'Enter your password',
                              ),
                              const SizedBox(height: 30),
                              SizedBox(
                                height: 50,
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor:
                                        // Theme.of(context).colorScheme.primary,
                                        Colors.white,
                                    backgroundColor:
                                        // Theme.of(context).colorScheme.onPrimary,
                                        const Color.fromARGB(
                                            255, 168, 105, 227),
                                  ),
                                  onPressed: () {
                                    loginController.isLoading.value = true;
                                    if (_formKey.currentState!.validate()) {
                                      loginController.login();
                                    }
                                    return;
                                  },
                                  child: loginController.isLoading.value
                                      ? const CircularProgressIndicator()
                                      : const Text(
                                          'Login',
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              SizedBox(
                                height: 50,
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    // side: BorderSide(
                                    //   width: 2.0,
                                    //   color: Theme.of(context)
                                    //       .colorScheme
                                    //       .onPrimary,
                                    // ),
                                    foregroundColor:
                                        // Theme.of(context).colorScheme.primary,
                                        Colors.white,
                                    backgroundColor:
                                        // Theme.of(context).colorScheme.onPrimary,
                                        const Color.fromARGB(
                                            255, 168, 105, 227),
                                  ),
                                  onPressed: () {
                                    Get.to(() => const SignupScreen());
                                  },
                                  child: loginController.isLoading.value
                                      ? const CircularProgressIndicator()
                                      : const Text(
                                          'New? Register here!',
                                          style: TextStyle(
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
}
