import 'package:flutter/material.dart';
import 'package:flutter_project/utils/shared_preferences/shared_preference.dart';
import 'package:get/get.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {

  RxString name = ''.obs;

  Future<void> getName() async{
    name.value = await UserSharedPreference.getStringDataFromStorage('name') ?? 'Error fetching name';
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 24, 224, 198),
        title: const Text("Welcome to Saral!"),
        centerTitle: true,
        titleTextStyle:
            const TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Hello,",
                          style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w300,
                              color: Colors.black),
                        ),
                        Obx( () =>
                           Text(name.value,
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 188, 2, 185),
                              )),
                        ),
                      ]),
                  SizedBox(
                    width: 70,
                    height: 70,
                    child: Image.asset('assets/images/profile_image.jpg'),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
