// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignupModel _$SignupModelFromJson(Map<String, dynamic> json) => SignupModel(
      name: json['name'] as String?,
      lastName: json['lastName'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      role: json['role'] as String?,
    );

Map<String, dynamic> _$SignupModelToJson(SignupModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'lastName': instance.lastName,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'password': instance.password,
      'role': instance.role,
    };
