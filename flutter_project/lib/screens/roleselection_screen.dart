import 'package:flutter/material.dart';
import 'package:flutter_project/screens/authScreens/register_screen.dart';
import 'package:flutter_project/utils/shared_preferences/shared_preference.dart';
import 'package:flutter_project/widgets/custom_card.dart';
import 'package:get/get.dart';

class RoleselectionScreen extends StatefulWidget {
  const RoleselectionScreen({super.key});

  @override
  State<RoleselectionScreen> createState() => _RoleselectionScreenState();
}

class _RoleselectionScreenState extends State<RoleselectionScreen> {
  final selectedRole = ''.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Shrami",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'freelance'.tr,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'onDemand'.tr,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Obx(() {
                          return GestureDetector(
                            onTap: () {
                              selectedRole.value = "workProvider";
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.45,
                              height: MediaQuery.of(context).size.height * 0.3,
                              color: selectedRole.value == "workProvider"
                                  ? Colors.grey
                                  : Colors.transparent,
                              child: CustomCard(
                                imagePath: "assets/images/find a service.png",
                                titleText: 'findWork'.tr,
                                descText: 'findWorkDesc'.tr,
                              ),
                            ),
                          );
                        }),
                        Obx(() {
                          return GestureDetector(
                            onTap: () {
                              selectedRole.value = "worker";
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.45,
                              height: MediaQuery.of(context).size.height * 0.3,
                              color: selectedRole.value == "worker"
                                  ? Colors.grey
                                  : Colors.transparent,
                              child: CustomCard(
                                imagePath:
                                    "assets/images/provide a service.png",
                                titleText: 'provideWork'.tr,
                                descText: 'provideWorkDesc'.tr,
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        onPressed: () async {
                          if (selectedRole.value.isNotEmpty) {
                            await UserSharedPreference.saveDataToStorage(
                                'role', selectedRole.value);
                            Get.to(() => const SignupScreen());
                          } else {
                            Get.snackbar(
                              "Error",
                              "Please select a role",
                              backgroundColor: Colors.red,
                              snackPosition: SnackPosition.TOP,
                            );
                          }
                        },
                        child: Text(
                          'signIn'.tr,
                          style: const TextStyle(
                              fontSize: 15, color: Colors.black),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
