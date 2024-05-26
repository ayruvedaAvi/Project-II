// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignupResponseModel _$SignupResponseModelFromJson(Map<String, dynamic> json) =>
    SignupResponseModel(
      msg: json['msg'] as String?,
      token: json['token'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SignupResponseModelToJson(
        SignupResponseModel instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'token': instance.token,
      'user': instance.user,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      name: json['name'] as String?,
      userId: json['userId'] as String?,
      role: json['role'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'userId': instance.userId,
      'role': instance.role,
    };
