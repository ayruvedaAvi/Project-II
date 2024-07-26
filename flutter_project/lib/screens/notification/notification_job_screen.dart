import 'package:flutter/material.dart';
import 'package:flutter_project/controllers/jobControllers/getJobs/get_single_job_controller.dart';
import 'package:flutter_project/models/jobs/jobDetailsModel/job_details_model.dart';
import 'package:flutter_project/utils/constants/colors.dart';
import 'package:get/get.dart';

import '../../core/helpers/functions.dart';

class NotificationJobScreen extends StatefulWidget {
  const NotificationJobScreen({
    super.key,
    required this.jobId,
  });

  final String jobId;

  @override
  State<NotificationJobScreen> createState() => _NotificationJobScreenState();
}

class _NotificationJobScreenState extends State<NotificationJobScreen> {

  GetSingleJobController getSingleJobController = Get.put(GetSingleJobController());

  Rxn<JobDetailsModel> job = Rxn<JobDetailsModel>();

  fetchJobDetails() async {
    var fetchedJob = await getSingleJobController.getSingleJob(widget.jobId);
    if (fetchedJob != null) {
      job.value = fetchedJob;
    } else {
      Get.snackbar("Error", "Failed to fetch job details");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchJobDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        foregroundColor: Colors.white,
        title: const Text(
          "Job Details",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Obx(() {
        if (job.value == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                ListTile(
                  leading: const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/profile_image.jpg'),
                    radius: 20,
                  ),
                  title: Text(
                    job.value!.userName!,
                    style: const TextStyle(color: Colors.black),
                  ),
                  subtitle: Text(
                    job.value!.createdAt!,
                    style: const TextStyle(color: Colors.black45),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      decoration: BoxDecoration(
                        border: Border.all(color: getJobTypeColor(job.value!.jobType!)),
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Text(
                        "# ${job.value!.jobType!}",
                        style: TextStyle(color: getJobTypeColor(job.value!.jobType!)),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Row(
                      children: [
                        Icon(Icons.location_on, color: getJobTypeColor(job.value!.jobType!)),
                        Text(
                          "Balkumari, Lalitpur",
                          style: TextStyle(color: getJobTypeColor(job.value!.jobType!)),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Text(
                  job.value!.Title!,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text(
                    job.value!.workDescription!,
                    textAlign: TextAlign.left,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 300,
                  child: Image.network(
                    job.value!.image!,
                    fit: BoxFit.fitHeight,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Text("corruptImage".tr),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Rs ${job.value!.price!}",
                  style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Divider(thickness: 2, color: Colors.grey[350]),
                const SizedBox(height: 5),
                Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Applicants",
                        style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 5))],
                      ),
                      child: Row(
                        children: [
                          const Expanded(
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: AssetImage('assets/images/profile_image.jpg'),
                                radius: 20,
                              ),
                              title: Text(
                                "John Doe",
                                style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                shape: const StadiumBorder(),
                                side: const BorderSide(width: 2, color: borderButtonColor),
                                foregroundColor: borderButtonColor,
                              ),
                              onPressed: () {},
                              child: const Text(
                                "Accept",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
