import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_project/controllers/job_controller.dart/post_job_controller.dart';
// import 'package:flutter/widgets.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:flutter_project/utils/shared_preferences/shared_preference.dart';
import 'package:flutter_project/widgets/custom_text_form_field.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddpostScreen extends StatefulWidget {
  const AddpostScreen({super.key});

  @override
  State<AddpostScreen> createState() => _AddpostScreenState();
}

class _AddpostScreenState extends State<AddpostScreen> {
  final _formKey = GlobalKey<FormState>();

  final PostJobController _postJobController = Get.put(PostJobController());
  RxString name = ''.obs;
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

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
          padding: const EdgeInsets.only(top: 24, right: 10, left: 10),
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
                      debugPrint("Post button clicked");
                      if (_formKey.currentState!.validate()) {
                        _postJobController.postJob();
                      }
                    },
                    child: const Text(
                      "Post",
                      style: TextStyle(
                          color: Colors.purple,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              const Divider(
                color: Colors.black38,
              ),
              Form(
                key: _formKey,
                child: Column(
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
                      height: 15,
                    ),
                    SizedBox(
                      height: 50,
                      child: CustomTextFormField(
                        keyType: TextInputType.text,
                        controller: _postJobController.title,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a Job title';
                          }
                          return null;
                        },
                        labelText: 'Job title',
                        suffixIcon: const Icon(Icons.work),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 50,
                      child: CustomTextFormField(
                        keyType: TextInputType.text,
                        controller: _postJobController.workDescription,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a Job Description';
                          }
                          return null;
                        },
                        labelText: 'Job description',
                        suffixIcon: const Icon(Icons.description),
                      ),
                    ),
                    // Card(
                    //   shadowColor: const Color.fromRGBO(197, 197, 197, 0),
                    //   color: const Color.fromARGB(255, 233, 218, 250),
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: TextFormField(
                    //       validator: (value) {
                    //         if (value == null || value.isEmpty) {
                    //           return "title field is required";
                    //         }
                    //         return null;
                    //       },
                    //       controller: _postJobController.workDescription,
                    //       maxLines: 4,
                    //       decoration: const InputDecoration.collapsed(
                    //           hintStyle: TextStyle(color: Colors.black45),
                    //           hintText: "Anything about work?"),
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 50,
                      child: CustomTextFormField(
                        keyType: TextInputType.number,
                        controller: _postJobController.price,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a Price';
                          }
                          return null;
                        },
                        labelText: 'Price',
                        suffixIcon: const Icon(Icons.attach_money),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    _image == null
                        ? const SizedBox()
                        : SizedBox(
                            width: double.infinity,
                            height: 200,
                            child: _image == null
                                ? const Text('No image selected.')
                                : Image.file(
                                    File(_image!.path),
                                    fit: BoxFit.fitHeight,
                                  ),
                          ),
                    const SizedBox(
                      height: 15,
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor:
                                    const Color.fromARGB(255, 168, 105, 227),
                              ),
                              onPressed: getImage,
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Gallery",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.image_outlined,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor:
                                    const Color.fromARGB(255, 168, 105, 227),
                              ),
                              onPressed: getImageFromCamera,
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Camera",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.camera_alt_outlined,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          shape: const StadiumBorder(),
                          side: const BorderSide(
                            width: 2,
                            color: Color.fromARGB(255, 168, 105, 227),
                          ),
                          foregroundColor:
                              const Color.fromARGB(255, 168, 105, 227),
                        ),
                        onPressed: () {
                          debugPrint("Post button clicked");
                          if (_formKey.currentState!.validate()) {
                            _postJobController.postJob();
                          }
                        },
                        child: const Text(
                          "Post",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future getImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  Future getImageFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }
}
