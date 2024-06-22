import 'package:flutter/material.dart';
import 'package:flutter_project/controllers/jobControllers/getJobs/get_all_jobs_by_filter_controller.dart';
import 'package:flutter_project/controllers/jobControllers/getJobs/get_all_jobs_controller.dart';
import 'package:flutter_project/models/jobs/getAllJobsModel/get_all_jobs_model.dart';
import 'package:flutter_project/utils/constants/colors.dart';
// import 'package:flutter_project/utils/shared_preferences/shared_preference.dart';
// import 'package:flutter_project/widgets/custom_postcard.dart';
import 'package:flutter_project/widgets/custom_test_postcard.dart';
import 'package:get/get.dart';

class UserPostedJobScreen extends StatefulWidget {
  final String? postStatus;
  final bool? isActiveUser;
  final String? detailsTopic;
  const UserPostedJobScreen(
      {super.key, this.postStatus, this.isActiveUser = false, this.detailsTopic});

  @override
  State<UserPostedJobScreen> createState() => _UserPostedJobScreenState();
}

class _UserPostedJobScreenState extends State<UserPostedJobScreen> {
  RxString name = ''.obs;
  GetAllJobsController getAllJobsController = Get.put(GetAllJobsController());
  GetAllJobsByFilterController getAllJobsByFilterController =
      Get.put(GetAllJobsByFilterController());
  Rxn<GetAllJobsModel> jobs = Rxn<GetAllJobsModel>();

  Future<void> getPosts() async {
    var fetchedJobs = await getAllJobsController.getAllJobs();
    if (fetchedJobs != null) {
      jobs.value = fetchedJobs;
    } else {
      debugPrint('No jobs fetched');
    }
  }

  Future<void> filterPosts(String jobStatus) async {
    var filteredJobs =
        await getAllJobsByFilterController.getAllJobsByFilter(jobStatus);
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
      backgroundColor: Colors.white,

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
                    userName: jobs.value!.jobs![index].userName,
                    workDescription: jobs.value!.jobs![index].workDescription,
                    image: jobs.value!.jobs![index].image,
                    title: jobs.value!.jobs![index].Title,
                    price: jobs.value!.jobs![index].price,
                    jobType: jobs.value!.jobs![index].jobType,
                    createdAt: jobs.value!.jobs![index].createdAt,
                    // isActiveUser: widget.isActiveUser,
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