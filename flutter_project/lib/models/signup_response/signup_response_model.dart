import 'package:json_annotation/json_annotation.dart';

part 'signup_response_model.g.dart';

@JsonSerializable()

class SignupResponseModel {
  final String? msg;
  final String? token;
  final User? user;

  SignupResponseModel({
    required this.msg,
    required this.token,
    required this.user,
  });

  factory SignupResponseModel.fromJson(Map<String, dynamic> json) => _$SignupResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$SignupResponseModelToJson(this);

}

@JsonSerializable()

class User {
  String? name;
  String? userId;
  String? role;

  User({
    required this.name,
    required this.userId,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}