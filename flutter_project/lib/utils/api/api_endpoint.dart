import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:flutter_project/models/login/login_model.dart';
import 'package:flutter_project/models/login_response/login_response_model.dart';
import 'package:flutter_project/utils/api/api_urls.dart';
import 'package:flutter_project/utils/api/http_services.dart';

class ApiEndpoints {
  Future<bool> login(LoginModel loginModel) async {
  bool isLogin = false; // Default to false indicating login failed
  String url = baseUrl + loginUrl;
  Response response;
  var dio = HttpServices().getDioInstance();

  try {
    response = await dio.post(
      url,
      data: loginModel.toJson(),
    );

    if (response.statusCode == 201) {
      LoginResponse loginResponse = LoginResponse.fromJson(response.data);
      debugPrint(loginResponse.name);

      // Optionally handle the token or other login-related data
      // var token = loginResponse.token;
      // await setStringData('token', '$token');
      // if (token != null) {
      //   isLogin = true;
      // } else {
      //   isLogin = false;
      // }

      isLogin = true; // Login successful
    } else {
      throw Exception('Failed to login: ${response.data}');
    }
  } catch (e) {
    // Handle different types of exceptions if needed
    if (e is DioException) {
      // Handle Dio errors specifically
      debugPrint('DioError: ${e.message}');
      // Optionally parse DioError to extract more specific details
      throw Exception('Failed to login due to network or server issue');
    } else {
      // Handle other types of exceptions
      debugPrint('Error: ${e.toString()}');
      throw Exception('An unexpected error occurred during login');
    }
  }
  return isLogin;
}

}
