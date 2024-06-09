import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_project/controllers/jobControllers/post_job_controller.dart';
import 'package:flutter_project/screens/baseScreens/base_screen.dart';
import 'package:flutter_project/utils/shared_preferences/shared_preference.dart';
import 'package:flutter_project/widgets/custom_text_form_field.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
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
    super.initState();
    getName();
  }

  final items = [
    'Technical',
    'Household',
    'Repair',
    'Construction',
    'Cleaning',
    'Gardening',
    'Cooking',
    'Shifting Service',
    'Others',
  ];
  List<String> selectedItem = [];
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
                  Text(
                    "createNewJobPost".tr,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _postJobController.postJob(_image);
                      }
                    },
                    child: Text(
                      "post".tr,
                      style: const TextStyle(
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
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: items.map((item) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: FilterChip(
                              label: Text(item),
                              labelStyle: const TextStyle(color: Colors.white),
                              selected: selectedItem.contains(item),
                              selectedColor: Colors.grey,
                              backgroundColor: Colors.deepPurple[400],
                              // shape: const CircleBorder(),
                              onSelected: (bool selected) {
                                setState(() {
                                  if (selected) {
                                    selectedItem.add(item);
                                  } else {
                                    selectedItem.remove(item);
                                  }
                                });
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomTextFormField(
                      keyType: TextInputType.text,
                      controller: _postJobController.title,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a Job title';
                        }
                        return null;
                      },
                      labelText: 'title'.tr,
                      suffixIcon: const Icon(Icons.work),
                    ),

                    CustomTextFormField(
                      keyType: TextInputType.text,
                      controller: _postJobController.workDescription,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a Job Description';
                        }
                        return null;
                      },
                      labelText: 'description'.tr,
                      suffixIcon: const Icon(Icons.description),
                      descField: true,
                    ),

                    CustomTextFormField(
                      keyType: TextInputType.number,
                      controller: _postJobController.price,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a Price';
                        }
                        return null;
                      },
                      labelText: 'price'.tr,
                      suffixIcon: const Icon(Icons.attach_money),
                    ),
                    // const SizedBox(
                    //   height: 15,
                    // ),

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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "gallery".tr,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Icon(
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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "camera".tr,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Icon(
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
                          if (_formKey.currentState!.validate()) {
                            _postJobController.postJob(_image);
                            Get.off(() => const BaseScreen(
                                  initalIndex: 0,
                                ));
                          }
                        },
                        child: Text(
                          "post".tr,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.updateLocale(const Locale('ne', 'NP'));
                      },
                      child: const Text("Change language to Nepali"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                      onPressed: () {
                        Get.updateLocale(const Locale('en', 'US'));
                      },
                      child: const Text("Change language to English"),
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
