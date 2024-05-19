
import 'package:flutter/material.dart';

import 'package:flutter_project/controllers/login_controller.dart';
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
        backgroundColor: Theme.of(context).colorScheme.secondary,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(height: 10),
              Text(
                'Login',
                style: TextStyle(
                  fontSize: 25,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Opacity(
                        opacity: 0.8,
                        child: Image.asset('assets/images/logo.png', height: 600, width: 700),
                      ),
                      Opacity(
                        opacity: 0.5,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
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
                                        Theme.of(context).colorScheme.primary,
                                    backgroundColor:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                                  onPressed: () {
                                    loginController.login();
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
