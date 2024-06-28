import 'package:flutter/material.dart';
import 'package:flutter_project/controllers/jobControllers/deleteJob/delete_job_controller.dart';
import 'package:flutter_project/controllers/jobControllers/getJobs/get_single_job_controller.dart';
import 'package:flutter_project/screens/baseScreens/addpost_screen.dart';
import 'package:get/get.dart';

class CustomActiveuserBottomsheet extends StatefulWidget {
  final Function(String) onDelete;
  final String jobId;
  const CustomActiveuserBottomsheet(
      {super.key, required this.onDelete, required this.jobId});

  @override
  State<CustomActiveuserBottomsheet> createState() =>
      _CustomActiveuserBottomsheetState();
}

class _CustomActiveuserBottomsheetState
    extends State<CustomActiveuserBottomsheet> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.white,
          builder: (context) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    onTap: () async {
                      GetSingleJobController getSingleJobController =
                          GetSingleJobController();
                      var job = await getSingleJobController.getSingleJob(widget.jobId);
                      Get.to(() => AddpostScreen(job: job, isEdit: true));
                    },
                    leading: const Icon(
                      Icons.edit,
                      color: Colors.black,
                    ),
                    title: const Text(
                      'Edit',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Colors.white,
                            title: const Text('Confirm Delete'),
                            content: const Text(
                                'Are you sure you want to delete this post?'),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                },
                              ),
                              TextButton(
                                child: const Text('Delete'),
                                onPressed: () {
                                  DeleteJobController deleteJobController =
                                      DeleteJobController();
                                  deleteJobController
                                      .deleteJob(widget.jobId.toString());
                                  widget.onDelete(widget.jobId);
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    leading: const Icon(
                      Icons.delete,
                      color: Colors.black,
                    ),
                    title: const Text(
                      'Delete',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: const Icon(
                      Icons.share,
                      color: Colors.black,
                    ),
                    title: const Text(
                      'Share',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: const Icon(
                      Icons.change_circle_outlined,
                      color: Colors.black,
                    ),
                    title: const Text(
                      'Change Status',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      icon: const Icon(Icons.more_vert),
      color: Colors.black,
    );
  }
}
