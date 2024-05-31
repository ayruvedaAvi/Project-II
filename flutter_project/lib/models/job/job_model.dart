import 'package:json_annotation/json_annotation.dart';

part 'job_model.g.dart';

@JsonSerializable()

class JobModel {
  String? Title;
  String? Work_Description;
  double? price;
  String? image;

  JobModel({
    this.Title,
    this.Work_Description,
    this.price,
    this.image,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) =>
      _$JobModelFromJson(json);

  Map<String, dynamic> toJson() => _$JobModelToJson(this);
}