import 'package:flutter/material.dart';
import 'package:flutter_project/controllers/jobControllers/getJobs/get_all_jobs_by_user.dart';
import 'package:flutter_project/models/jobs/getAllJobsModel/get_all_jobs_model.dart';
import 'package:flutter_project/utils/constants/colors.dart';
// import 'package:flutter_project/utils/shared_preferences/shared_preference.dart';
// import 'package:flutter_project/widgets/custom_postcard.dart';
import 'package:flutter_project/widgets/custom_test_postcard.dart';
import 'package:get/get.dart';

class UserPostedJobScreen extends StatefulWidget {
  final String postStatus;
  final String? detailsTopic;
  const UserPostedJobScreen(
      {super.key, required this.postStatus, this.detailsTopic});

  @override
  State<UserPostedJobScreen> createState() => _UserPostedJobScreenState();
}

class _UserPostedJobScreenState extends State<UserPostedJobScreen> {
  RxString name = ''.obs;
  GetAllJobsByUserController getAllJobsController =
      Get.put(GetAllJobsByUserController());
  Rxn<GetAllJobsModel> jobs = Rxn<GetAllJobsModel>();

  Future<void> getPosts() async {
    var fetchedJobs = await getAllJobsController.getAllJobs();
    if (fetchedJobs != null) {
      jobs.value = fetchedJobs;
    } else {
      debugPrint('No jobs fetched');
    }
  }

  void removeJob(String jobId) {
    setState(() {
      jobs.value!.jobs?.removeWhere((job) => job.id == jobId);
    });
  }

  Future<void> filterPosts(String jobStatus) async {
    var allJobs = await getAllJobsController.getAllJobs();
    debugPrint(allJobs?.count.toString() ?? 'No jobs found');
    if (allJobs != null) {
      jobs.value = allJobs;
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
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getPosts();
    filterPosts(widget.postStatus.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        shadowColor: Colors.grey,
        title: Text(widget.detailsTopic.toString()),
      ),
      // backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      backgroundColor: Colors.grey[200],

      // body: Center(
      //   child: ElevatedButton(
      //     onPressed: () {
      //       Get.back();
      //     },
      //     child: const Text('Go back!'),
      //   ),
      // ),
      body: Obx(() {
        if (getAllJobsController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (jobs.value == null) {
          return const Center(
            child: Text(
                'Error fetching jobs, something went wrong, please try again later.'),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.only(top: 0, bottom: 10),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return CustomTestPostcard(
                    profileImg: 'assets/images/profile_image.jpg',
                    // userName: jobs.value!.jobs![index].userName,
                    // workDescription: jobs.value!.jobs![index].workDescription,
                    // image: jobs.value!.jobs![index].image,
                    // title: jobs.value!.jobs![index].Title,
                    // price: jobs.value!.jobs![index].price,
                    // jobType: jobs.value!.jobs![index].jobType,
                    // createdAt: jobs.value!.jobs![index].createdAt,
                    jobModel: jobs.value!.jobs![index],
                    isActiveUser: true,
                  );
                },
                itemCount: jobs.value?.jobs?.length ?? 0,
              ),
            ),
          );
        }
      }),
    );
  }
}
