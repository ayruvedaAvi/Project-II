// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'job_details_model.g.dart';

@JsonSerializable()
class JobDetailsResponseModel{
  JobDetailsModel? job;

  JobDetailsResponseModel({this.job});

  factory JobDetailsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$JobDetailsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$JobDetailsResponseModelToJson(this);
}

@JsonSerializable()
class JobDetailsModel {
  String? id;
  String? Title;
  String? workDescription;
  String? status;
  String? userId;
  String? userName;
  String? userLastName;
  String? userEmail;
  String? jobType;
  String? jobLocation;
  double? price;
  String? image;
  String? createdAt;
  String? updatedAt;
  List<Applicant>? applications;
  Applicant? assignedWorker;
  Applicant? completedBy;

  JobDetailsModel({
    this.id,
    this.Title,
    this.workDescription,
    this.price,
    this.image,
    this.status,
    this.userId,
    this.userName,
    this.userLastName,
    this.userEmail,
    this.jobType,
    this.jobLocation,
    this.createdAt,
    this.updatedAt,
  });

  factory JobDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$JobDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$JobDetailsModelToJson(this);
}

@JsonSerializable()
class Applicant {
  String? workerId;
  String? workerName;

  Applicant({
    this.workerId,
    this.workerName,
  });

  factory Applicant.fromJson(Map<String, dynamic> json) =>
      _$ApplicantFromJson(json);

  Map<String, dynamic> toJson() => _$ApplicantToJson(this);
}
