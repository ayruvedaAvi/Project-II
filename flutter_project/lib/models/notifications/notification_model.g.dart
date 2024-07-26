// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationResponseModel _$NotificationResponseModelFromJson(
        Map<String, dynamic> json) =>
    NotificationResponseModel(
      (json['notifications'] as List<dynamic>)
          .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NotificationResponseModelToJson(
        NotificationResponseModel instance) =>
    <String, dynamic>{
      'notifications': instance.notifications,
    };

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      json['id'] as String,
      json['title'] as String,
      json['body'] as String,
      json['read'] as bool,
      json['createdAt'] as String,
      (json['v'] as num).toInt(),
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'read': instance.read,
      'createdAt': instance.createdAt,
      'v': instance.v,
    };
