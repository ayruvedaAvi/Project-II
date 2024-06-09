import 'package:flutter_project/models/jobs/jobDetailsModel/job_details_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_all_jobs_model.g.dart';

@JsonSerializable()
class GetAllJobsModel {
  List<JobDetailsModel>? jobs;
  int? count;

  GetAllJobsModel({
    this.jobs,
    this.count,
  });

  factory GetAllJobsModel.fromJson(Map<String, dynamic> json) =>
      _$GetAllJobsModelFromJson(json);
  
  Map<String, dynamic> toJson() => _$GetAllJobsModelToJson(this);
}