import 'package:json_annotation/json_annotation.dart';

part 'signup_model.g.dart';

// dart run build_runner build

@JsonSerializable()
class SignupModel {
  String? firstName;
  String? lastName;
  String? mobileNo;
  String? email;
  String? password;

  SignupModel({
    this.firstName,
    this.lastName,
    this.mobileNo,
    this.email,
    this.password,
  });

  factory SignupModel.fromJson(Map<String, dynamic> json) =>
      _$SignupModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignupModelToJson(this);
}
