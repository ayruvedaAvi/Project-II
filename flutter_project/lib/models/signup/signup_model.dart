import 'package:json_annotation/json_annotation.dart';

part 'signup_model.g.dart';

// dart run build_runner build

@JsonSerializable()
class SignupModel {
  String? name;
  String? phoneNumber;
  String? email;
  String? password;

  SignupModel({
    this.name,
    this.phoneNumber,
    this.email,
    this.password,
  });

  factory SignupModel.fromJson(Map<String, dynamic> json) =>
      _$SignupModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignupModelToJson(this);
}
