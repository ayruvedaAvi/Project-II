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
                    title: Text(
                      'edit'.tr,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Colors.white,
                            title: Text('confirmDelete'.tr),
                            content: Text(
                                'suretodelete'.tr),
                            actions: <Widget>[
                              TextButton(
                                child: Text('cancel'.tr),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                },
                              ),
                              TextButton(
                                child: Text('delete'.tr),
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
                    title: Text(
                      'delete'.tr,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: const Icon(
                      Icons.share,
                      color: Colors.black,
                    ),
                    title:  Text(
                      'share'.tr,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: const Icon(
                      Icons.change_circle_outlined,
                      color: Colors.black,
                    ),
                    title: Text(
                      'changeStatus'.tr,
                      style: const TextStyle(color: Colors.black),
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
