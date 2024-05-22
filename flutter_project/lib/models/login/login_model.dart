import 'package:json_annotation/json_annotation.dart';

part 'login_model.g.dart';

// dart run build_runner build

@JsonSerializable()
class LoginModel {
  String? email;
  String? password;

  LoginModel({
    this.email,
    this.password,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginModelToJson(this);
}