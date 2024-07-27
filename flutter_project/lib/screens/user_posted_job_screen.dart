import 'package:flutter/material.dart';
import 'package:flutter_project/controllers/jobControllers/getJobs/get_all_jobs_by_user.dart';
import 'package:flutter_project/models/jobs/getAllJobsModel/get_all_jobs_model.dart';
import 'package:flutter_project/models/jobs/jobDetailsModel/job_details_model.dart';
import 'package:flutter_project/utils/constants/colors.dart';
import 'package:flutter_project/widgets/custom_test_postcard.dart';
import 'package:get/get.dart';

class UserPostedJobScreen extends StatefulWidget {
  final String postStatus;
  final String? detailsTopic;
  final bool fromPending;

  const UserPostedJobScreen({
    Key? key,
    required this.postStatus,
    this.detailsTopic,
    required this.fromPending,
  }) : super(key: key);

  @override
  State<UserPostedJobScreen> createState() => _UserPostedJobScreenState();
}

class _UserPostedJobScreenState extends State<UserPostedJobScreen> {
  final GetAllJobsByUserController _getAllJobsController = Get.put(GetAllJobsByUserController());
  final Rxn<GetAllJobsModel> _jobs = Rxn<GetAllJobsModel>();

  @override
  void initState() {
    super.initState();
    _fetchAndFilterJobs();
  }

  Future<void> _fetchAndFilterJobs() async {
    try {
      var allJobs = await _getAllJobsController.getAllJobs();
      if (allJobs != null) {
        var filteredJobs = _filterJobs(allJobs);
        _jobs.value = GetAllJobsModel(
          jobs: filteredJobs,
          count: filteredJobs.length,
        );
      } else {
        _showErrorSnackbar('No jobs found');
      }
    } catch (e) {
      _showErrorSnackbar('Error fetching jobs: $e');
    }
  }

  List<JobDetailsModel> _filterJobs(GetAllJobsModel allJobs) {
    switch (widget.detailsTopic?.toLowerCase()) {
      case 'active':
        return allJobs.jobs?.where((job) => job.status == 'active').toList() ?? [];
      case 'pending':
        return allJobs.jobs?.where((job) => job.status == 'pending').toList() ?? [];
      case 'completed':
        return allJobs.jobs?.where((job) => job.status == 'completed').toList() ?? [];
      default:
        return allJobs.jobs ?? [];
    }
  }

  void _showErrorSnackbar(String message) {
    Get.showSnackbar(
      GetSnackBar(
        title: "Error",
        message: message,
        duration: const Duration(seconds: 4),
        borderRadius: 10.0,
        snackPosition: SnackPosition.TOP,
        borderWidth: 5,
        borderColor: mainColor,
        backgroundColor: Colors.red,
      ),
    );
  }

  void _removeJob(String jobId) {
    setState(() {
      _jobs.value?.jobs?.removeWhere((job) => job.id == jobId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: borderButtonColor,
        shadowColor: Colors.grey,
        title: Text(widget.detailsTopic ?? ''),
      ),
      backgroundColor: Colors.grey[200],
      body: Obx(() {
        if (_getAllJobsController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (_jobs.value == null || _jobs.value!.jobs == null) {
          return const Center(
            child: Text('No jobs found. Please try again later.'),
          );
        } else {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 10),
            itemCount: _jobs.value!.jobs!.length,
            itemBuilder: (context, index) {
              return CustomTestPostcard(
                fromPending: widget.fromPending,
                profileImg: 'assets/images/profile_image.jpg',
                jobModel: _jobs.value!.jobs![index],
                isActiveUser: true,
                onDelete: _removeJob,
              );
            },
          );
        }
      }),
    );
  }
}