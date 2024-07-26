import 'package:flutter/material.dart';
import 'package:flutter_project/controllers/jobControllers/getJobs/get_all_jobs_by_filter_controller.dart';
import 'package:flutter_project/controllers/jobControllers/getJobs/get_all_jobs_controller.dart';
import 'package:flutter_project/models/jobs/getAllJobsModel/get_all_jobs_model.dart';
import 'package:flutter_project/utils/constants/colors.dart';
import 'package:flutter_project/utils/shared_preferences/shared_preference.dart';
import 'package:flutter_project/widgets/custom_test_postcard.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  RxString name = ''.obs;
  GetAllJobsController getAllJobsController = Get.put(GetAllJobsController());
  GetAllJobsByFilterController getAllJobsByFilterController =
      Get.put(GetAllJobsByFilterController());
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

  Future<void> filterPosts(String category) async {
    var filteredJobs =
        await getAllJobsByFilterController.getAllJobsByFilter(category);
    debugPrint(filteredJobs?.count.toString() ?? 'No jobs found');
    if (filteredJobs != null) {
      jobs.value = filteredJobs;
    } else {
      Get.showSnackbar(
        const GetSnackBar(
          title: "Error",
          message: 'No jobs found',
          duration: Duration(seconds: 4),
          borderRadius: 10.0,
          snackPosition: SnackPosition.TOP,
          borderWidth: 5,
          borderColor: mainColor,
          backgroundColor: Colors.red,
        ),
        // const CustomSnackbar(body: "No jobs found", title: "Error", type: "Error"),
      );
    }
  }

  final categories = [
    'Technical',
    'Household',
    'Repair',
    'Construction',
    'Cleaning',
    'Gardening',
    'Cooking',
    'Shifting Service',
    'Location',
    'Others'
  ];
  final workerCategories = ['Highly Rated', 'Top Performer', 'Most Loved'];

  @override
  void initState() {
    super.initState();
    getPosts();
    getName();
  }

//jashgysag
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 5.0,
        // shadowColor: Colors.grey,
        backgroundColor: borderButtonColor,
        foregroundColor: Colors.white,
        title: Text("SHRAMI",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.bonaNova().fontFamily,
            )),
        centerTitle: true,
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(height: 50),
            const Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Row(
                children: [
                  Text(
                    "Welcome to Shrami",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: boldTextColor,
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(
                    Icons.man_2_outlined,
                    color: boldTextColor,
                  ),
                ],
              ),
            ),
            ExpansionTile(
              leading: const Icon(Icons.category_outlined, color: Colors.black),
              title: const Text(
                "Categories",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              childrenPadding: const EdgeInsets.only(left: 40),
              children: categories.map((item) {
                return ListTile(
                  title: Text(
                    item,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                  onTap: () async {
                    Navigator.pop(context);
                    debugPrint('Filtering by $item');
                    await filterPosts(item);
                  },
                );
              }).toList(),
            ),
            ExpansionTile(
              leading: const Icon(Icons.work_rounded, color: Colors.black),
              title: const Text(
                "Workers",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              childrenPadding: const EdgeInsets.only(left: 40),
              children: workerCategories.map((item) {
                return ListTile(
                  title: Text(
                    item,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
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
      body:
          Obx(() {
        if (getAllJobsController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (jobs.value == null) {
          return Center(
            child: Text('errorFetchFeedScreen'.tr),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.only(top: 0, bottom: 0),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height - 166,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          CustomTestPostcard(
                            fromPending: false,
                            profileImg: 'assets/images/profile_image.jpg',
                            jobModel: jobs.value!.jobs![index],
                            onDelete: (S) {},
                          ),
                        ],
                      );
                    },
                    itemCount: jobs.value?.jobs?.length ?? 0,
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
