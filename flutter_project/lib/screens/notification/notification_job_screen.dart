import 'package:flutter/material.dart';
import 'package:flutter_project/controllers/jobActionControllers/job_action_controller.dart';
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
  final GetSingleJobController getSingleJobController = Get.put(GetSingleJobController());
  final Rxn<JobDetailsModel> job = Rxn<JobDetailsModel>();

  @override
  void initState() {
    super.initState();
    fetchJobDetails();
  }

  Future<void> fetchJobDetails() async {
    try {
      var fetchedJob = await getSingleJobController.getSingleJob(widget.jobId);
      if (fetchedJob != null) {
        job.value = fetchedJob;
      } else {
        Get.snackbar("Error", "Failed to fetch job details");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred while fetching job details");
    }
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
        return _buildJobDetails();
      }),
    );
  }

  Widget _buildJobDetails() {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            _buildUserInfo(),
            _buildJobTypeAndLocation(),
            const SizedBox(height: 15),
            _buildJobTitle(),
            const SizedBox(height: 10),
            _buildWorkDescription(),
            const SizedBox(height: 10),
            _buildJobImage(),
            const SizedBox(height: 10),
            _buildJobPrice(),
            const SizedBox(height: 5),
            Divider(thickness: 2, color: Colors.grey[350]),
            const SizedBox(height: 5),
            _buildApplicantsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfo() {
    return ListTile(
      leading: const CircleAvatar(
        backgroundImage: AssetImage('assets/images/profile_image.jpg'),
        radius: 20,
      ),
      title: Text(
        job.value?.userName ?? "N/A",
        style: const TextStyle(color: Colors.black),
      ),
      subtitle: Text(
        job.value?.createdAt ?? "N/A",
        style: const TextStyle(color: Colors.black45),
      ),
    );
  }

  Widget _buildJobTypeAndLocation() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          decoration: BoxDecoration(
            border: Border.all(color: getJobTypeColor(job.value?.jobType)),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: Text(
            "# ${job.value?.jobType ?? 'N/A'}",
            style: TextStyle(color: getJobTypeColor(job.value?.jobType)),
          ),
        ),
        const SizedBox(width: 20),
        Row(
          children: [
            Icon(Icons.location_on, color: getJobTypeColor(job.value?.jobType)),
            Text(
              "Balkumari, Lalitpur",
              style: TextStyle(color: getJobTypeColor(job.value?.jobType)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildJobTitle() {
    return Text(
      job.value?.Title ?? "N/A",
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildWorkDescription() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        job.value?.workDescription ?? "N/A",
        textAlign: TextAlign.left,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildJobImage() {
    return SizedBox(
      width: double.infinity,
      height: 300,
      child: Image.network(
        job.value?.image ?? "",
        fit: BoxFit.fitHeight,
        errorBuilder: (context, error, stackTrace) {
          return Center(
            child: Text("corruptImage".tr),
          );
        },
      ),
    );
  }

  Widget _buildJobPrice() {
    return Text(
      "Rs ${job.value?.price ?? 'N/A'}",
      style: const TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildApplicantsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Applicant",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: job.value?.applications?.length ?? 0,
          itemBuilder: (context, index) {
            return _buildApplicantItem(index);
          },
        ),
      ],
    );
  }

  Widget _buildApplicantItem(int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 5))
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ListTile(
              leading: const CircleAvatar(
                backgroundImage: AssetImage('assets/images/profile_image.jpg'),
                radius: 20,
              ),
              title: Text(
                job.value?.applications?[index].workerName ?? "N/A",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
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
              onPressed: () {
                JobActionController jobAction = Get.put(JobActionController());
                jobAction.acceptJob(job.value?.id, job.value?.applications?[index].workerId);
              },
              child: const Text(
                "Accept",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}