import 'package:flutter/material.dart';
import 'package:flutter_project/widgets/custom_sizedbox_button.dart';
// import 'package:get/get.dart';

class UserprofileScreen extends StatefulWidget {
  const UserprofileScreen({super.key});

  @override
  State<UserprofileScreen> createState() => _UserprofileScreenState();
}

class _UserprofileScreenState extends State<UserprofileScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.only(top: 40, left: 15, right: 15),
              child: Column(
                children: [
                  Row(
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
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/images/boy_image.jpg'),
                    radius: 60,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Harry Potter",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Icon(
                        Icons.verified,
                        color: Colors.deepPurple,
                        size: 20,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Text(
                    "9876543210",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomSizedboxButton(
                    prefixIcon: Icons.history,
                    labelText: "Work History",
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomSizedboxButton(
                    prefixIcon: Icons.privacy_tip_outlined,
                    labelText: "Privacy & Security",
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomSizedboxButton(
                    prefixIcon: Icons.person_pin,
                    labelText: "Invite a Friend",
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomSizedboxButton(
                    prefixIcon: Icons.settings,
                    labelText: "Setting",
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomSizedboxButton(
                    prefixIcon: Icons.help_outline,
                    labelText: "Help & Support",
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomSizedboxButton(
                    prefixIcon: Icons.logout_outlined,
                    labelText: "Logout",
                  ),
                ],
              )),
        ));
  }
}
