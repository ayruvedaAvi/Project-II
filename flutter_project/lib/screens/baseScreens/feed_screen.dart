import 'package:flutter/material.dart';
import 'package:flutter_project/controllers/jobControllers/get_all_jobs_controller.dart';
import 'package:flutter_project/models/jobs/getAllJobsModel/get_all_jobs_model.dart';
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
  Rxn<GetAllJobsModel> jobs = Rxn<GetAllJobsModel>();

  Future<void> getName() async {
    name.value = await UserSharedPreference.getStringDataFromStorage('name') ??
        'Error fetching name';
  }

  Future<void> getPosts() async {
    var fetchedJobs = await getAllJobsController.getAllJobs();
    if (fetchedJobs != null) {
      jobs.value = fetchedJobs;
    } else {
      debugPrint('No jobs fetched');
    }
  }

  @override
  void initState() {
    super.initState();
    getPosts();
    getName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Obx(() {
                if (getAllJobsController.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (jobs.value != null) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height - 160,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return CustomPostcard(
                          profileImg: 'assets/images/profile_image.jpg',
                          userName: jobs.value!.jobs![index].userName,
                          workDescription: jobs.value!.jobs![index].workDescription,
                          image: jobs.value!.jobs![index].image,
                          title: jobs.value!.jobs![index].Title,
                          price: jobs.value!.jobs![index].price,
                        );
                      },
                      itemCount: jobs.value?.jobs?.length ?? 0,
                    ),
                  );
                } else {
                  return const Center(
                    child: Text("Error fetching data! Please try again later."),
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
