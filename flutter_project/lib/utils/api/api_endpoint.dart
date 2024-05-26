import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:flutter_project/models/login/login_model.dart';
import 'package:flutter_project/models/login_response/login_response_model.dart';
import 'package:flutter_project/utils/api/api_urls.dart';
import 'package:flutter_project/utils/api/dio_exception_handler.dart';
import 'package:flutter_project/utils/api/http_services.dart';
import 'package:flutter_project/utils/shared_preferences/shared_preference.dart';

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
        LoginResponseModel loginResponse = LoginResponseModel.fromJson(response.data);

        debugPrint('Login successful: ${loginResponse.user!.name}');

        // Optionally handle the token or other login-related data
        var token = loginResponse.token;
        await UserSharedPreference.saveDataToStorage('token', token);

        isLogin = true; // Login successful
      } else {
        throw Exception('Failed to login: ${response.data}');
      }
    } catch (e) {
      if (e is DioException) {
        String errorMessage = DioExceptionHandler(exception: e).getErrorMessage();
        throw Exception(errorMessage);
      } else {
        throw Exception('An unexpected error occurred during login');
      }
    }
    return isLogin;
  }

  Future<bool> logOut() async {
    bool isLogOut = false; // Default to false indicating logout failed
    String url = baseUrl + logoutUrl;
    Response response;
    var dio = HttpServices().getDioInstance();
    String? token = await UserSharedPreference.getStringDataFromStorage('token');
    try {
      response = await dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        debugPrint('Logout successful');
        UserSharedPreference.removeDataFromStorage('token');
        isLogOut = true; // Logout successful
      } else {
        throw Exception('Failed to logout: ${response.data}');
      }
    } catch (e) {
      if (e is DioException) {
        String errorMessage = DioExceptionHandler(exception: e).getErrorMessage();
        throw Exception(errorMessage);
      } else {
        debugPrint('Error: ${e.toString()}');
        throw Exception('An unexpected error occurred during logout');
      }
    }
    return isLogOut;
  }
}
