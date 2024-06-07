import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/models/jobs/getAllJobsModel/get_all_jobs_model.dart';
import 'package:flutter_project/models/jobs/postJobModel/job_model.dart';

import 'package:flutter_project/models/login/login_model.dart';
import 'package:flutter_project/models/login_response/login_response_model.dart';
import 'package:flutter_project/models/signup/signup_model.dart';
import 'package:flutter_project/models/signup_response/signup_response_model.dart';
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

        await UserSharedPreference.saveDataToStorage('name', loginResponse.user!.name);

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

  Future<bool> signup(SignupModel signupModel) async {
    bool isSignup = false; // Default to false indicating signup failed
    String url = baseUrl + registerUrl;
    Response response;
    var dio = HttpServices().getDioInstance();

    try {
      response = await dio.post(
        url,
        data: signupModel.toJson(),
      );

      if (response.statusCode == 201) {
        // debugPrint('Signup successful');
        isSignup = true; // Signup successful
      } else {
        throw Exception('Failed to signup: ${response.data}');
      }
    } catch (e) {
      if (e is DioException) {
        String errorMessage = DioExceptionHandler(exception: e).getErrorMessage();
        throw Exception(errorMessage);
      } else {
        throw Exception('An unexpected error occurred during signup');
      }
    }
    return isSignup;
  }

  Future<bool> verifyOtp(String otp) async {
    bool isVerified = false; // Default to false indicating verification failed
    String url = baseUrl + verifyOtpUrl;
    Response response;
    var dio = HttpServices().getDioInstance();

    try {
      response = await dio.post(
        url,
        data: {
          'otp': otp,
        },
      );

      if (response.statusCode == 200) {
        debugPrint('OTP verification successful');
        SignupResponseModel signupResponse = SignupResponseModel.fromJson(response.data);

        var token = signupResponse.token;
        await UserSharedPreference.saveDataToStorage('token', token);

        isVerified = true; // OTP verification successful
      } else {
        throw Exception('Failed to verify OTP: ${response.data}');
      }
    } catch (e) {
      if (e is DioException) {
        String errorMessage = DioExceptionHandler(exception: e).getErrorMessage();
        throw Exception(errorMessage);
      } else {
        throw Exception('An unexpected error occurred during OTP verification.');
      }
    }
    return isVerified;
  }

  Future<bool> postJob(JobModel jobModel) async {
    bool isJobPosted = false; // Default to false indicating job post failed
    String url = baseUrl + postJobUrl;
    Response response;
    var dio = HttpServices().getDioInstance();
    String? token = await UserSharedPreference.getStringDataFromStorage('token');

    try {
      response = await dio.post(
        url,
        data: jobModel.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 201) {
        debugPrint('Job posted successfully');
        isJobPosted = true; // Job post successful
      } else {
        throw Exception('Failed to post job: ${response.data}');
      }
    } catch (e) {
      if (e is DioException) {
        String errorMessage = DioExceptionHandler(exception: e).getErrorMessage();
        throw Exception(errorMessage);
      } else {
        throw Exception('An unexpected error occurred during job post');
      }
    }
    return isJobPosted;
  }

  Future<GetAllJobsModel> getAllJobs() async {
    GetAllJobsModel getAllJobsModel = GetAllJobsModel(jobs: [], count: 0);
    String url = baseUrl + getAllJobsUrl;
    Response response;
    var dio = HttpServices().getDioInstance();
    String? token = await UserSharedPreference.getStringDataFromStorage('token');
    dio.options.headers['Authorization'] = 'Bearer $token';

    try {
      response = await dio.get(url);

      if (response.statusCode == 200) {
        getAllJobsModel = GetAllJobsModel.fromJson(response.data);
      } else {
        throw Exception('Failed to get jobs: ${response.data}');
      }
    } catch (e) {
      if (e is DioException) {
        String errorMessage = DioExceptionHandler(exception: e).getErrorMessage();
        throw Exception(errorMessage);
      } else {
        throw Exception('An unexpected error occurred while fetching jobs');
      }
    }
    return getAllJobsModel;
  }
}
