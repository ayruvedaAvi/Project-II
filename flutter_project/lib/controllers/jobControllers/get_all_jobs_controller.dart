import 'package:flutter_project/models/jobs/getAllJobsModel/get_all_jobs_model.dart';
import 'package:flutter_project/core/api/api_endpoint.dart';
import 'package:get/get.dart';

class GetAllJobsController extends GetxController {
  GetAllJobsModel? getAllJobsModel;
  Future<GetAllJobsModel?> getAllJobs() async {
    getAllJobsModel = await ApiEndpoints().getAllJobs();
    return getAllJobsModel;
  }
}