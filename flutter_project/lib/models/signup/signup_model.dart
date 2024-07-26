import 'package:json_annotation/json_annotation.dart';

part 'signup_model.g.dart';

// dart run build_runner build

@JsonSerializable()
class SignupModel {
  String? name;
  String? lastName;
  String? phoneNumber;
  String? email;
  String? password;
  String? role;

  SignupModel({
    this.name,
    this.lastName,
    this.phoneNumber,
    this.email,
    this.password,
    this.role,
  });

  factory SignupModel.fromJson(Map<String, dynamic> json) =>
      _$SignupModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignupModelToJson(this);
}
