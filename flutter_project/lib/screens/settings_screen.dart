import 'package:flutter/material.dart';
import 'package:flutter_project/screens/authScreens/login_screen.dart';
import 'package:flutter_project/screens/roleselection_screen.dart';
import 'package:flutter_project/utils/shared_preferences/shared_preference.dart';
import 'package:flutter_project/widgets/custom_setting_row.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
      appBar: AppBar(
        elevation: 5.0,
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text("Settings"),
        shadowColor: Colors.grey,
      ),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  "Common",
                  style: TextStyle(color: Colors.grey, fontSize: 21),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                // width: MediaQuery.of(context).size.width*0.8,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      const CustomSettingRow(
                        prefixIcon: Icons.language,
                        prefixText: "Language",
                        suffixIcon: Icons.arrow_forward_ios,
                        suffixTextBool: true,
                        suffixText: "English",
                      ),
                      Divider(
                        thickness: 1,
                        indent: 60,
                        color: Colors.grey[200],
                      ),
                      const CustomSettingRow(
                        prefixIcon: Icons.language,
                        prefixText: "Language",
                        suffixIcon: Icons.arrow_forward_ios,
                        suffixTextBool: true,
                        suffixText: "English",
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  "Account",
                  style: TextStyle(color: Colors.grey, fontSize: 21),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                // width: MediaQuery.of(context).size.width*0.8,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      const CustomSettingRow(
                        prefixIcon: Icons.phone,
                        prefixText: "Phone Number",
                        suffixIcon: Icons.arrow_forward_ios,
                        // suffixTextBool: false,
                        // suffixText: "English",
                      ),
                      Divider(
                        thickness: 1,
                        indent: 60,
                        color: Colors.grey[200],
                      ),
                      const CustomSettingRow(
                        prefixIcon: Icons.email,
                        prefixText: "Email",
                        suffixIcon: Icons.arrow_forward_ios,
                        // suffixTextBool: true,
                        // suffixText: "English",
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  "Security",
                  style: TextStyle(color: Colors.grey, fontSize: 21),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                // width: MediaQuery.of(context).size.width*0.8,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      const CustomSettingRow(
                        prefixIcon: Icons.phonelink_lock,
                        prefixText: "Lock app in background",
                        suffixIcon: Icons.arrow_forward_ios,
                        // suffixTextBool: false,
                        // suffixText: "English",
                      ),
                      Divider(
                        thickness: 1,
                        indent: 60,
                        color: Colors.grey[200],
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(() => const RoleselectionScreen());
                        },
                        child: const CustomSettingRow(
                          prefixIcon: Icons.fingerprint,
                          prefixText: "Use fingerprint",
                          suffixIcon: Icons.arrow_forward_ios,
                          // suffixTextBool: true,
                          // suffixText: "English",
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        indent: 60,
                        color: Colors.grey[200],
                      ),
                      const CustomSettingRow(
                        prefixIcon: Icons.lock,
                        prefixText: "Change password",
                        suffixIcon: Icons.arrow_forward_ios,
                        // suffixTextBool: true,
                        // suffixText: "English",
                      ),
                      Divider(
                        thickness: 1,
                        indent: 60,
                        color: Colors.grey[200],
                      ),
                      CustomSettingRow(
                        prefixIcon: Icons.location_on,
                        prefixText: "Check location (test)",
                        suffixIcon: Icons.location_on_outlined,
                        // suffixTextBool: true,
                        // suffixText: "English",
                        onTap: () async {
                          Location location = Location();

                          bool serviceEnabled;
                          PermissionStatus permissionGranted;
                          LocationData locationData;

                          serviceEnabled = await location.serviceEnabled();
                          if (!serviceEnabled) {
                            serviceEnabled = await location.requestService();
                            if (!serviceEnabled) {
                              return;
                            }
                          }

                          permissionGranted = await location.hasPermission();
                          if (permissionGranted == PermissionStatus.denied) {
                            permissionGranted =
                                await location.requestPermission();
                            if (permissionGranted != PermissionStatus.granted) {
                              return;
                            }
                          }

                          locationData = await location.getLocation();
                          debugPrint("Location: ");
                          debugPrint(locationData.toString());
                        },
                      ),
                      Divider(
                        thickness: 1,
                        indent: 60,
                        color: Colors.grey[200],
                      ),
                      InkWell(
                        onTap: () {
                          UserSharedPreference.removeDataFromStorage('token');
                          Get.offAll(() => const LoginScreen());
                        },
                        child: const CustomSettingRow(
                          prefixIcon: Icons.logout,
                          prefixText: "Sign out",
                          suffixIcon: Icons.arrow_forward_ios,
                          // suffixTextBool: true,
                          // suffixText: "English",
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
