// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'job_model.g.dart';

@JsonSerializable()
class JobModel {
  String? Title;
  String? workDescription;
  double? price;
  String? image;

  JobModel({
    this.Title,
    this.workDescription,
    this.price,
    this.image,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) =>
      _$JobModelFromJson(json);

  Map<String, dynamic> toJson() => _$JobModelToJson(this);
}
