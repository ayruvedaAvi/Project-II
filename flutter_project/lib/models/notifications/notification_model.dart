// ignore_for_file: unused_field

import 'package:json_annotation/json_annotation.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class NotificationResponseModel{
  final List<NotificationModel> notifications;

  NotificationResponseModel(this.notifications);

  factory NotificationResponseModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationResponseModelFromJson(json);
  
  Map<String, dynamic> toJson() => _$NotificationResponseModelToJson(this);
}

@JsonSerializable()
class NotificationModel {
  final String id;
  final String title;
  final String body;
  final bool read;
  final String createdAt;
  final int v;

  NotificationModel(
    this.id,
    this.title,
    this.body,
    this.read,
    this.createdAt,
    this.v,
  );

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}
