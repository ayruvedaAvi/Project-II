import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/controllers/jobControllers/get_all_jobs_controller.dart';
import 'package:flutter_project/models/jobs/getAllJobsModel/get_all_jobs_model.dart';
import 'package:flutter_project/models/userdetails_datamodel.dart';
import 'package:flutter_project/utils/shared_preferences/shared_preference.dart';
import 'package:flutter_project/widgets/custom_postcard.dart';
import 'package:get/get.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  RxString name = ''.obs;
  GetAllJobsController getAllJobsController = Get.put(GetAllJobsController());
  GetAllJobsModel? jobs;

  Future<void> getName() async {
    name.value = await UserSharedPreference.getStringDataFromStorage('name') ??
        'Error fetching name';
  }

  Future<void> getPosts() async {
    var fetchedJobs = await getAllJobsController.getAllJobs();
    setState(() {
      jobs = fetchedJobs;
    });
    debugPrint(jobs?.jobs?[1].workDescription ?? 'No data');
  }

   @override
  void initState() {
    super.initState();
    getPosts().then((_) {
      debugPrint(jobs?.jobs?[1].workDescription ?? 'No data');
    });
    getName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: const Color.fromARGB(255, 24, 224, 198),
      //   title: const Text("Welcome to Saral!"),
      //   centerTitle: true,
      //   titleTextStyle:
      //       const TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
      // ),
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 25, bottom: 10),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 0,
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 0,
                      blurRadius: 10,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        "Shrami, We Connect!",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 143, 69, 211)),
                      ),
                      SizedBox(
                        width: 80,
                        height: 80,
                        child: Image.asset('assets/images/profile_image.jpg'),
                      )
                    ],
                  ),
                ),
              ),
              jobs != null?
                SizedBox(
                  height: MediaQuery.of(context).size.height - 160,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return CustomPostcard(
                        profileImg: 'assets/images/profile_image.jpg',
                        userName: jobs!.jobs![index].userName,
                        workDescription: jobs!.jobs![index].workDescription,
                        image: jobs!.jobs![index].image,
                      );
                    },
                    itemCount: jobs?.jobs?.length?? 0,
                  ),
                ) : const Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<UserDetailsDataModel>> readJsonData() async {
    final jsonData =
        await rootBundle.loadString('assets/jsonFile/userdetails.json');
    final list = jsonDecode(jsonData) as List<dynamic>;

    return list.map((e) => UserDetailsDataModel.fromJson(e)).toList();
  }
}
