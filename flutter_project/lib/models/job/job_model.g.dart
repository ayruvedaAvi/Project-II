// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobModel _$JobModelFromJson(Map<String, dynamic> json) => JobModel(
      Title: json['Title'] as String?,
      Work_Description: json['Work_Description'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      image: json['image'] as String?,
    );

Map<String, dynamic> _$JobModelToJson(JobModel instance) => <String, dynamic>{
      'Title': instance.Title,
      'Work_Description': instance.Work_Description,
      'price': instance.price,
      'image': instance.image,
    };
