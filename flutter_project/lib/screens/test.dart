import 'package:flutter/material.dart';
import 'package:flutter_project/controllers/login_controller.dart';
import 'package:flutter_project/screens/register_screen.dart';
import 'package:flutter_project/widgets/custom_text_form_field.dart';

import 'package:get/get.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  final _formKey = GlobalKey<FormState>();
  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Theme.of(context).colorScheme.primary,
        backgroundColor: Colors.white,
        body: Center(
          child: SizedBox(
            height: 450,
            width: 350,
            child: Card(
              elevation: 12,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(right: 15, left: 15),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 25,
                        color: Color.fromARGB(255, 58, 18, 89),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 70, child: Divider(thickness: 1.5)),
                    Form(
                      key: _formKey,
                      child: Obx(
                        () => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 50),
                            SizedBox(
                              height: 50,
                              child: CustomTextFormField(
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
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              height: 50,
                              child: CustomTextFormField(
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
                                      const Color.fromARGB(255, 168, 105, 227),
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
                              height: 30,
                            ),
                            SizedBox(
                              height: 50,
                              width: double.infinity,
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  shape: const StadiumBorder(),
                                  side: const BorderSide(
                                      width: 2,
                                      color:
                                          Color.fromARGB(255, 168, 105, 227)),
                                  foregroundColor:
                                      const Color.fromARGB(255, 168, 105, 227),
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
          ),
        ),
      ),
    );
  }
}
