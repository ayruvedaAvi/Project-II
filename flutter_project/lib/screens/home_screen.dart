import 'package:flutter/material.dart';
import 'package:flutter_project/screens/login_screen.dart';
import 'package:flutter_project/utils/api/api_endpoint.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var x = 10;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 24, 224, 198),
        title: const Text("Project-II"),
      ),
      backgroundColor: const Color.fromARGB(255, 62, 87, 99),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Center(
            child: Hero(
              tag: 'text',
              child: Text(
                "Lets start from here.",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(onPressed: () async {
            bool isLogout = await ApiEndpoints().logOut();
            if (isLogout){
              Get.off(() => const LoginScreen());
            }
          }, child: const Text("Log out", style: TextStyle(fontSize: 20),)),

        ],
      ),
    );
  }
}
