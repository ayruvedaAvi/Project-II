import 'package:flutter/material.dart';
import 'package:flutter_project/controllers/authControllers/login_controller.dart';
import 'package:flutter_project/screens/roleselection_screen.dart';
import 'package:flutter_project/utils/constants/colors.dart';
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
        backgroundColor: borderButtonColor,
        centerTitle: true,
        title: Text('settings'.tr),
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
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  'common'.tr,
                  style: const TextStyle(color: Colors.grey, fontSize: 21),
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
                      CustomSettingRow(
                        prefixIcon: Icons.language,
                        prefixText: "language".tr,
                        suffixIcon: Icons.arrow_forward_ios,
                        suffixTextBool: true,
                        suffixText: "english".tr,
                      ), //custom comment
                      Divider(
                        thickness: 1,
                        indent: 60,
                        color: Colors.grey[200],
                      ), //hehe
                      CustomSettingRow(
                        prefixIcon: Icons.language,
                        prefixText: "language".tr,
                        suffixIcon: Icons.arrow_forward_ios,
                        suffixTextBool: true,
                        suffixText: "english".tr,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  "account".tr,
                  style: const TextStyle(color: Colors.grey, fontSize: 21),
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
                      CustomSettingRow(
                        prefixIcon: Icons.phone,
                        prefixText: "phoneNo".tr,
                        suffixIcon: Icons.arrow_forward_ios,
                        // suffixTextBool: false,
                        // suffixText: "English",
                      ),
                      Divider(
                        thickness: 1,
                        indent: 60,
                        color: Colors.grey[200],
                      ),
                      CustomSettingRow(
                        prefixIcon: Icons.email,
                        prefixText: "email".tr,
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
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  "security".tr,
                  style: const TextStyle(color: Colors.grey, fontSize: 21),
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
                      CustomSettingRow(
                        prefixIcon: Icons.phonelink_lock,
                        prefixText: "lockAppBackG".tr,
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
                        child: CustomSettingRow(
                          prefixIcon: Icons.fingerprint,
                          prefixText: "useFingerprint".tr,
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
                      CustomSettingRow(
                        prefixIcon: Icons.lock,
                        prefixText: "changePassword".tr,
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
                          LoginController logout = Get.put(LoginController());
                          logout.logout();
                        },
                        child: CustomSettingRow(
                          prefixIcon: Icons.logout,
                          prefixText: "signOut".tr,
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
