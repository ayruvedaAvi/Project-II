// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobDetailsModel _$JobDetailsModelFromJson(Map<String, dynamic> json) =>
    JobDetailsModel(
      id: json['id'] as String?,
      Title: json['Title'] as String?,
      workDescription: json['workDescription'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      image: json['image'] as String?,
      status: json['status'] as String?,
      userId: json['userId'] as String?,
      userName: json['userName'] as String?,
      userLastName: json['userLastName'] as String?,
      userEmail: json['userEmail'] as String?,
      jobType: json['jobType'] as String?,
      jobLocation: json['jobLocation'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    )
      ..applications = (json['applications'] as List<dynamic>?)
          ?.map((e) => Applicant.fromJson(e as Map<String, dynamic>))
          .toList()
      ..assignedWorker = json['assignedWorker'] == null
          ? null
          : Applicant.fromJson(json['assignedWorker'] as Map<String, dynamic>)
      ..completedBy = json['completedBy'] == null
          ? null
          : Applicant.fromJson(json['completedBy'] as Map<String, dynamic>);

Map<String, dynamic> _$JobDetailsModelToJson(JobDetailsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'Title': instance.Title,
      'workDescription': instance.workDescription,
      'status': instance.status,
      'userId': instance.userId,
      'userName': instance.userName,
      'userLastName': instance.userLastName,
      'userEmail': instance.userEmail,
      'jobType': instance.jobType,
      'jobLocation': instance.jobLocation,
      'price': instance.price,
      'image': instance.image,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'applications': instance.applications,
      'assignedWorker': instance.assignedWorker,
      'completedBy': instance.completedBy,
    };

Applicant _$ApplicantFromJson(Map<String, dynamic> json) => Applicant(
      workerId: json['workerId'] as String?,
      workerName: json['workerName'] as String?,
    );

Map<String, dynamic> _$ApplicantToJson(Applicant instance) => <String, dynamic>{
      'workerId': instance.workerId,
      'workerName': instance.workerName,
    };
