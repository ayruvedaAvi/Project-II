import 'package:flutter/material.dart';
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
        body: Center(
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
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomProfiledetailscard(
                      name: "Pending Jobs",
                      contextIcon: Icons.pending_actions_outlined,
                      numCount: "25",
                    ),
                    CustomProfiledetailscard(
                      name: "Active Jobs",
                      contextIcon: Icons.directions_run_rounded,
                      numCount: "15",
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomProfiledetailscard(
                      name: "Completed Jobs",
                      contextIcon: Icons.check_circle_outline,
                      numCount: "10",
                    ),
                    CustomProfiledetailscard(
                      name: "Refer a friend",
                      contextIcon: Icons.pending_actions_outlined,
                      numCount: "25",
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomProfiledetailscard(
                      name: "Pending Jobs",
                      contextIcon: Icons.pending_actions_outlined,
                      numCount: "25",
                    ),
                    CustomProfiledetailscard(
                      name: "Logout",
                      contextIcon: Icons.logout_outlined,
                      numCount: "Bye!",
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ));
  }
}
