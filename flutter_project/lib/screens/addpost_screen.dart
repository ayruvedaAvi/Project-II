// import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_project/utils/shared_preferences/shared_preference.dart';
import 'package:get/get.dart';

class AddpostScreen extends StatefulWidget {
  const AddpostScreen({super.key});

  @override
  State<AddpostScreen> createState() => _AddpostScreenState();
}

class _AddpostScreenState extends State<AddpostScreen> {
  RxString name = ''.obs;

  Future<void> getName() async {
    name.value = await UserSharedPreference.getStringDataFromStorage('name') ??
        'Error fetching name';
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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 24, right: 8, left: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                  const Text(
                    "Create New Post",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                      onPressed: () {
                        print("post button pressed!");
                      },
                      child: const Text(
                        "Post",
                        style: TextStyle(
                            color: Colors.purple,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              ),
              const Divider(
                color: Colors.black38,
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        backgroundImage:
                            AssetImage("assets/images/boy_image.jpg"),
                        radius: 25,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Obx(
                        () => Text(
                          name.value,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w300),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Card(
                    shadowColor: Color.fromRGBO(197, 197, 197, 0),
                    color: Colors.black12,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        maxLines: 4,
                        decoration: InputDecoration.collapsed(
                            hintStyle: TextStyle(color: Colors.black45),
                            hintText: "Anything about work?"),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 236, 254, 250),
                      ),
                      onPressed: () async {
                        FilePickerResult? result = await FilePicker.platform
                            .pickFiles(
                                allowMultiple: true,
                                type: FileType.custom,
                                allowedExtensions: ['jpg', 'png', 'mp4']);
                        if (result != null) {
                          //   List<File> files =
                          //       result.paths.map((path) => File(path!)).toList();
                          //   final file = result.files.first;
                          //   files = file!;
                          // } else {
                          print("User cancelled the picker");
                        }
                        print("Add images button added");
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Add images/video",
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.image,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
