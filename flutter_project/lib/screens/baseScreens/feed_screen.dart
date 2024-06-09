import 'package:flutter/material.dart';
import 'package:flutter_project/controllers/jobControllers/get_all_jobs_controller.dart';
import 'package:flutter_project/models/jobs/getAllJobsModel/get_all_jobs_model.dart';
import 'package:flutter_project/utils/constants/colors.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text(
          "Shrami",
          style: TextStyle(
              fontSize: 24, color: mainColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(
              height: 50,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Text(
                "Categories",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: boldTextColor),
              ),
            ),
            const Divider(
              thickness: 1,
            ),
            // const SizedBox(
            //   height: 10,
            // ),
            Column(
              children: items.map((item) {
                return ListTile(
                  // leading: const Icon(Icons.contacts),
                  title: Text(
                    item,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 25, bottom: 10),
          child: Column(
            children: [
              Obx(() {
                if (getAllJobsController.isLoading.value == true) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return jobs.value == null
                      ? const Center(
                          child: Text(
                              'Error fetching jobs, something went wrong, please try again later.'),
                        )
                      : SizedBox(
                          height: MediaQuery.of(context).size.height - 160,
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return CustomPostcard(
                                profileImg: 'assets/images/profile_image.jpg',
                                userName: jobs.value!.jobs![index].userName,
                                workDescription:
                                    jobs.value!.jobs![index].workDescription,
                                image: jobs.value!.jobs![index].image,
                                title: jobs.value!.jobs![index].Title,
                                price: jobs.value!.jobs![index].price,
                              );
                            },
                            itemCount: jobs.value?.jobs?.length ?? 0,
                          ),
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
