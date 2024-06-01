import 'package:flutter/material.dart';
import 'package:flutter_project/screens/login_screen.dart';
import 'package:flutter_project/utils/shared_preferences/shared_preference.dart';
import 'package:flutter_project/widgets/custom_sizedbox_button.dart';
import 'package:get/get.dart';
// import 'package:get/get.dart';

class UserprofileScreen extends StatefulWidget {
  const UserprofileScreen({super.key});

  @override
  State<UserprofileScreen> createState() => _UserprofileScreenState();
}

class _UserprofileScreenState extends State<UserprofileScreen> {
  RxString name = ''.obs;

  Future<void> getName() async {
    name.value = await UserSharedPreference.getStringDataFromStorage('name') ??
        'Error fetching name';
  }

  @override
  void initState() {
    super.initState();
    getName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.only(top: 40, left: 15, right: 15),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                      Icon(
                        Icons.sunny,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/boy_image.jpg'),
                    radius: 60,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(
                        () => Text(
                          name.value,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      const Icon(
                        Icons.verified,
                        color: Colors.deepPurple,
                        size: 20,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  const Text(
                    "9876543210",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomSizedboxButton(
                    prefixIcon: Icons.history,
                    labelText: "Work History",
                    onTap: () {},
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomSizedboxButton(
                    prefixIcon: Icons.privacy_tip_outlined,
                    labelText: "Privacy & Security",
                    onTap: () {},
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomSizedboxButton(
                    prefixIcon: Icons.person_pin,
                    labelText: "Invite a Friend",
                    onTap: () {},
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomSizedboxButton(
                    prefixIcon: Icons.settings,
                    labelText: "Setting",
                    onTap: () {},
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomSizedboxButton(
                    prefixIcon: Icons.help_outline,
                    labelText: "Help & Support",
                    onTap: () {},
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomSizedboxButton(
                    prefixIcon: Icons.logout_outlined,
                    labelText: "Logout",
                    onTap: () {
                        UserSharedPreference.removeDataFromStorage('token');
                        Get.off(() => const LoginScreen());
                    },
                  ),
                ],
              )),
        ));
  }
}
