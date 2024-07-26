import 'package:flutter/material.dart';
import 'package:flutter_project/controllers/jobActionControllers/job_action_controller.dart';
import 'package:flutter_project/models/jobs/jobDetailsModel/job_details_model.dart';
import 'package:flutter_project/screens/singlepost_screen.dart';
import 'package:flutter_project/utils/constants/colors.dart';
import 'package:flutter_project/utils/shared_preferences/shared_preference.dart';
import 'package:flutter_project/widgets/custom_activeuser_bottomsheet.dart';
import 'package:flutter_project/widgets/custom_otheruser_bottomsheet.dart';
import 'package:get/get.dart';

class CustomTestPostcard extends StatelessWidget {
  final String? profileImg;
  final JobDetailsModel jobModel;
  final bool isActiveUser;
  final Function(String) onDelete;
  final bool fromPending;

  CustomTestPostcard({
    Key? key,
    this.profileImg,
    required this.jobModel,
    this.isActiveUser = false,
    required this.onDelete,
    required this.fromPending,
  }) : super(key: key);

  final JobActionController job = Get.put(JobActionController());

  String get timeDifference {
    if (jobModel.createdAt == null) return '';
    final createdAtDateTime = DateTime.parse(jobModel.createdAt!);
    final now = DateTime.now();
    final difference = now.difference(createdAtDateTime);

    if (difference.inDays > 0) return '${difference.inDays} days ago';
    if (difference.inHours > 0) return '${difference.inHours} hours ago';
    if (difference.inMinutes > 0) return '${difference.inMinutes} minutes ago';
    return 'Just now';
  }

  Color getJobTypeColor(String? jobType) {
    const Map<String, Color> jobTypeColors = {
      'Technical': Colors.red,
      'Household': Colors.blue,
      'Repair': Colors.green,
      'Construction': Colors.teal,
      'Cleaning': Colors.purple,
      'Gardening': Colors.orange,
      'Cooking': Colors.indigo,
      'Shifting Service': Colors.brown,
      'Others': Colors.pink,
    };
    return jobTypeColors[jobType] ?? Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildUserInfo(),
          _buildJobDetails(),
          const SizedBox(height: 20),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildUserInfo() {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(profileImg ?? ''),
        radius: 25,
      ),
      title: Text(jobModel.userName ?? '', style: const TextStyle(color: Colors.black)),
      subtitle: Text(timeDifference, style: const TextStyle(color: Colors.black45)),
      trailing: isActiveUser
          ? CustomActiveuserBottomsheet(onDelete: onDelete, jobId: jobModel.id.toString())
          : const CustomOtheruserBottomsheet(),
    );
  }

  Widget _buildJobDetails() {
    return InkWell(
      onTap: () => Get.to(() => SinglePostScreen(
            profileImg: profileImg,
            userName: jobModel.userName,
            workDescription: jobModel.workDescription,
            image: jobModel.image,
            title: jobModel.Title,
            price: jobModel.price ?? 0.0,
            createdAt: timeDifference,
            jobType: jobModel.jobType,
            fromPending: fromPending,
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildJobTypeAndLocation(),
          const SizedBox(height: 10),
          Text(
            jobModel.Title ?? '',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            jobModel.workDescription ?? '',
            style: const TextStyle(fontSize: 16, color: Colors.black54),
          ),
          const SizedBox(height: 10),
          _buildPriceInfo(),
        ],
      ),
    );
  }

  Widget _buildJobTypeAndLocation() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          decoration: BoxDecoration(
            border: Border.all(color: getJobTypeColor(jobModel.jobType)),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            "# ${jobModel.jobType ?? ''}",
            style: TextStyle(color: getJobTypeColor(jobModel.jobType)),
          ),
        ),
        const SizedBox(width: 20),
        Icon(Icons.location_on, color: getJobTypeColor(jobModel.jobType)),
        Text(
          "Balkumari, Lalitpur",
          style: TextStyle(color: getJobTypeColor(jobModel.jobType)),
        ),
      ],
    );
  }

  Widget _buildPriceInfo() {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          Text(
            "Rs ${jobModel.price?.toString() ?? ''}",
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            "work".tr,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (!fromPending)
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(Icons.chat),
              color: mainColor,
              onPressed: () {
                // Add chat action here
              },
            ),
          ),
        const SizedBox(width: 30),
        Expanded(
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              shape: const StadiumBorder(),
              side: const BorderSide(width: 2, color: borderButtonColor),
              foregroundColor: borderButtonColor,
            ),
            onPressed: fromPending ? _markAsComplete : _applyForJob,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
              child: Obx(
                () => job.isLoading.value
                    ? const CircularProgressIndicator()
                    : Text(
                        fromPending ? 'Mark as Complete' : 'applyNow'.tr,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _markAsComplete() {
    
  }

  void _applyForJob() async {
    var role = await UserSharedPreference.getStringDataFromStorage('role');
    if (role != null && role.toUpperCase() == 'WORKPROVIDER') {
      Get.snackbar('You are a work provider', 'You cannot apply for this job',
          backgroundColor: Colors.red);
    } else {
      job.apply(jobModel.id.toString());
    }
  }
}