import 'package:flutter/material.dart';
import 'package:flutter_project/widgets/custom_postcard.dart';
import 'package:get/get.dart';
import 'package:flutter_project/utils/shared_preferences/shared_preference.dart';
import 'package:flutter_project/models/jobs/getAllJobsModel/get_all_jobs_model.dart';
import 'package:flutter_project/controllers/jobControllers/get_all_jobs_controller.dart';

class CustomFeedscreen extends StatefulWidget {
  const CustomFeedscreen({super.key});

  @override
  State<CustomFeedscreen> createState() => _CustomFeedscreenState();
}

class _CustomFeedscreenState extends State<CustomFeedscreen> {
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
    return Obx(() {
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
                      workDescription: jobs.value!.jobs![index].workDescription,
                      image: jobs.value!.jobs![index].image,
                      title: jobs.value!.jobs![index].Title,
                      price: jobs.value!.jobs![index].price,
                    );
                  },
                  itemCount: jobs.value?.jobs?.length ?? 0,
                ),
              );
      }
    });
  }
}
