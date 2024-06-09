// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobModel _$JobModelFromJson(Map<String, dynamic> json) => JobModel(
      Title: json['Title'] as String?,
      workDescription: json['workDescription'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      image: json['image'] as String?,
    );

Map<String, dynamic> _$JobModelToJson(JobModel instance) => <String, dynamic>{
      'Title': instance.Title,
      'workDescription': instance.workDescription,
      'price': instance.price,
      'image': instance.image,
    };
