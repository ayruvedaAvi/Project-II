import 'package:flutter/material.dart';
// import 'package:flutter_project/screens/authScreens/login_screen.dart';
import 'package:flutter_project/screens/settings_screen.dart';
import 'package:flutter_project/screens/user_posted_job_screen.dart';
// import 'package:flutter_project/screens/authScreens/login_screen.dart';
import 'package:flutter_project/utils/shared_preferences/shared_preference.dart';
import 'package:flutter_project/widgets/custom_profiledetailscard.dart';
// import 'package:flutter_project/widgets/custom_sizedbox_button.dart';
import 'package:get/get.dart';

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
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            left: -90,
            top: 175,
            // right: 0,
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 162, 223, 244),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          Positioned(
            right: -70,
            top: -30,
            // right: 0,
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                // color: Color.fromARGB(255, 100, 189, 218),
                color: const Color.fromARGB(255, 162, 223, 244),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          Positioned(
            right: 80,
            top: 280,
            // right: 0,
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 162, 223, 244),
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
          Positioned(
            left: 20,
            top: 40,
            // right: 0,
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                // color: const Color.fromARGB(255, 162, 223, 244),
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  width: 5,
                  color: const Color.fromARGB(255, 162, 223, 244),
                ),
              ),
            ),
          ),
          Positioned(
            right: MediaQuery.of(context).size.width * 0.03,
            top: MediaQuery.of(context).size.height * 0.04,
            // right: 0,
            child: IconButton(
                onPressed: () {
                  Get.to(() => const SettingsScreen());
                },
                icon: const Icon(
                  Icons.settings,
                  color: Color.fromARGB(255, 58, 18, 89),
                  size: 35,
                )),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // const Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Icon(
                  //       Icons.arrow_back,
                  //       color: Colors.black,
                  //     ),
                  //     Icon(
                  //       Icons.sunny,
                  //       color: Colors.black,
                  //     ),
                  //   ],
                  // ),
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
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomProfiledetailscard(
                        onTap: () {},
                        name: "Pending Jobs",
                        contextIcon: Icons.pending_actions_outlined,
                        numCount: "25",
                      ),
                      CustomProfiledetailscard(
                        onTap: () {
                          Get.to(() => const UserPostedJobScreen());
                        },
                        name: "Active Jobs",
                        contextIcon: Icons.directions_run_rounded,
                        numCount: "15",
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomProfiledetailscard(
                        onTap: () {},
                        name: "Completed Jobs",
                        contextIcon: Icons.check_circle,
                        numCount: "10",
                      ),
                      CustomProfiledetailscard(
                        onTap: () {},
                        name: "Refer a friend",
                        contextIcon: Icons.offline_share,
                        numCount: "25",
                      )
                    ],
                  ),
                  // const SizedBox(
                  //   height: 15,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     CustomProfiledetailscard(
                  //       onTap: () {},
                  //       name: "Settings",
                  //       contextIcon: Icons.settings,
                  //       numCount: "All",
                  //     ),
                  //     CustomProfiledetailscard(
                  //       onTap: () {
                  //         UserSharedPreference.removeDataFromStorage('token');
                  //         Get.off(() => const LoginScreen());
                  //       },
                  //       name: "Logout",
                  //       contextIcon: Icons.logout_outlined,
                  //       numCount: "Bye!",
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
