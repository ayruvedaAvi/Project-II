// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_jobs_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllJobsModel _$GetAllJobsModelFromJson(Map<String, dynamic> json) =>
    GetAllJobsModel(
      jobs: (json['jobs'] as List<dynamic>?)
          ?.map((e) => JobDetailsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      count: (json['count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$GetAllJobsModelToJson(GetAllJobsModel instance) =>
    <String, dynamic>{
      'jobs': instance.jobs,
      'count': instance.count,
    };
