import 'package:flutter/material.dart';
import 'package:flutter_project/utils/constants/colors.dart';
import 'package:get/get.dart';

class SinglePostScreen extends StatelessWidget {
  final String? profileImg;
  final String? userName;
  final String? workDescription;
  final String? image;
  final String? title;
  final double? price;
  final String? createdAt;
  final String? jobType;
  final bool fromPending;

  const SinglePostScreen({
    Key? key,
    this.workDescription,
    this.image,
    this.profileImg,
    this.userName,
    this.title,
    this.price,
    this.createdAt,
    this.jobType,
    required this.fromPending,
  }) : super(key: key);

  Color getJobTypeColor(String? jobType) {
    final Map<String, Color> jobTypeColors = {
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "Post",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        elevation: 5.0,
        shadowColor: Colors.grey,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _buildUserInfo(),
              const SizedBox(height: 15),
              _buildJobTypeAndLocation(),
              const SizedBox(height: 15),
              _buildPostContent(),
              const SizedBox(height: 10),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfo() {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(profileImg ?? ''),
        radius: 20,
      ),
      title: Text(
        userName ?? '',
        style: const TextStyle(color: Colors.black),
      ),
      subtitle: Text(
        createdAt ?? '',
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
            border: Border.all(color: getJobTypeColor(jobType)),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            "# ${jobType ?? ''}",
            style: TextStyle(color: getJobTypeColor(jobType)),
          ),
        ),
        const SizedBox(width: 20),
        Icon(Icons.location_on, color: getJobTypeColor(jobType)),
        Text(
          "Balkumari, Lalitpur",
          style: TextStyle(color: getJobTypeColor(jobType)),
        ),
      ],
    );
  }

  Widget _buildPostContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? '',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          workDescription ?? '',
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          height: 300,
          child: Image.network(
            image ?? '',
            fit: BoxFit.fitHeight,
            errorBuilder: (context, error, stackTrace) {
              return Center(child: Text("corruptImage".tr));
            },
          ),
        ),
        const SizedBox(height: 10),
        Text(
          price?.toString() ?? '',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    if (fromPending) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: borderButtonColor,
        ),
        onPressed: () {},
        child: const Text(
          "Mark as Completed",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      );
    }

    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: borderButtonColor,
            ),
            onPressed: () {},
            child: Text(
              "accept".tr,
              style: const TextStyle(fontSize: 18, color: Colors.white),
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
            child: Text(
              "chat".tr,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }
}