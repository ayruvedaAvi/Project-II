import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/models/jobs/getAllJobsModel/get_all_jobs_model.dart';

import 'package:flutter_project/models/login/login_model.dart';
import 'package:flutter_project/models/login_response/login_response_model.dart';
import 'package:flutter_project/models/signup/signup_model.dart';
import 'package:flutter_project/models/signup_response/signup_response_model.dart';
import 'package:flutter_project/core/api/api_urls.dart';
import 'package:flutter_project/core/api/dio_exception_handler.dart';
import 'package:flutter_project/core/api/http_services.dart';
import 'package:flutter_project/utils/shared_preferences/shared_preference.dart';
// ignore: depend_on_referenced_packages
import 'package:image_picker/image_picker.dart';

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
        LoginResponseModel loginResponse =
            LoginResponseModel.fromJson(response.data);

        debugPrint('Login successful: ${loginResponse.user!.name}');

        await UserSharedPreference.saveDataToStorage(
            'name', loginResponse.user!.name);

        // Optionally handle the token or other login-related data
        var token = loginResponse.token;
        await UserSharedPreference.saveDataToStorage('token', token);

        isLogin = true; // Login successful
      } else {
        throw Exception('Failed to login: ${response.data}');
      }
    } catch (e) {
      if (e is DioException) {
        String errorMessage =
            DioExceptionHandler(exception: e).getErrorMessage();
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
    String? token =
        await UserSharedPreference.getStringDataFromStorage('token');
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
        String errorMessage =
            DioExceptionHandler(exception: e).getErrorMessage();
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
        String errorMessage =
            DioExceptionHandler(exception: e).getErrorMessage();
        throw Exception(errorMessage);
      } else {
        throw Exception('An unexpected error occurred during signup');
      }
    }
    return isSignup;
  }

  Future<bool> verifyOtp(String otp, bool isPassword) async {
    bool isVerified = false; // Default to false indicating verification failed
    String url;
    if (isPassword) {
      url = baseUrl + verifyOtpForgotPassUrl;
    } else {
      url = baseUrl + verifyOtpUrl;
    }
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
        if (!isPassword) {
          SignupResponseModel signupResponse =
              SignupResponseModel.fromJson(response.data);

          var token = signupResponse.token;
          await UserSharedPreference.saveDataToStorage('token', token);
        }

        isVerified = true; // OTP verification successful
      } else {
        throw Exception('Failed to verify OTP: ${response.data}');
      }
    } catch (e) {
      if (e is DioException) {
        String errorMessage =
            DioExceptionHandler(exception: e).getErrorMessage();
        throw Exception(errorMessage);
      } else {
        throw Exception(
            'An unexpected error occurred during OTP verification.');
      }
    }
    return isVerified;
  }

  Future<bool> postJob({
    required TextEditingController title,
    required TextEditingController workDescription,
    required TextEditingController price,
    required String category,
    XFile? imageFile,
  }) async {
    bool isJobPosted = false; // Default to false indicating job post failed
    String url = baseUrl + postJobUrl;
    Response response;
    var dio = HttpServices().getDioInstance();
    String? token =
        await UserSharedPreference.getStringDataFromStorage('token');

    // Check if the token is null or empty
    if (token == null || token.isEmpty) {
      throw Exception('Authentication token is missing');
    }

    FormData formData = FormData.fromMap({
      "Title": title.text,
      "workDescription": workDescription.text,
      "price": price.text,
      "jobType": category,
      if (imageFile != null)
        "media": await MultipartFile.fromFile(imageFile.path),
    });

    try {
      response = await dio.post(
        url,
        data: formData,
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
        String errorMessage =
            DioExceptionHandler(exception: e).getErrorMessage();
        throw Exception(errorMessage);
      } else {
        throw Exception('An unexpected error occurred during job post');
      }
    }
    return isJobPosted;
  }

  Future<bool> editJob({
    required String title,
    required String workDescription,
    required String price,
    required String category,
    required String jobId,
    XFile? imageFile,
  }) async {
    bool isJobPosted = false; // Default to false indicating job post failed
    String url = baseUrl + postJobUrl;
    Response response;
    var dio = HttpServices().getDioInstance();
    String? token =
        await UserSharedPreference.getStringDataFromStorage('token');

    // Check if the token is null or empty
    if (token == null || token.isEmpty) {
      throw Exception('Authentication token is missing');
    }

    FormData formData = FormData.fromMap({
      "Title": title,
      "workDescription": workDescription,
      "price": price,
      "jobType": category,
      if (imageFile != null)
        "media": await MultipartFile.fromFile(imageFile.path),
    });

    try {
      response = await dio.patch(
        url,
        data: formData,
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
        String errorMessage =
            DioExceptionHandler(exception: e).getErrorMessage();
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
    String? token =
        await UserSharedPreference.getStringDataFromStorage('token');
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
        String errorMessage =
            DioExceptionHandler(exception: e).getErrorMessage();
        throw Exception(errorMessage);
      } else {
        throw Exception('An unexpected error occurred while fetching jobs.');
      }
    }
    return getAllJobsModel;
  }

  Future<GetAllJobsModel> getAllJobsByFilter(String jobType) async {
    GetAllJobsModel getAllJobsModel = GetAllJobsModel(jobs: [], count: 0);
    String url = baseUrl + getJobByFilterUrl;
    Response response;
    var dio = HttpServices().getDioInstance();
    String? token =
        await UserSharedPreference.getStringDataFromStorage('token');
    dio.options.headers['Authorization'] = 'Bearer $token';

    try {
      response = await dio.get(url, data: {"jobType": jobType});

      if (response.statusCode == 200) {
        getAllJobsModel = GetAllJobsModel.fromJson(response.data);
      } else {
        throw Exception('Failed to get jobs: ${response.data}');
      }
    } catch (e) {
      if (e is DioException) {
        String errorMessage =
            DioExceptionHandler(exception: e).getErrorMessage();
        throw Exception(errorMessage);
      } else {
        throw Exception('An unexpected error occurred while fetching jobs.');
      }
    }
    return getAllJobsModel;
  }

  Future<GetAllJobsModel> getAllJobsByUser() async {
    GetAllJobsModel getAllJobsModel = GetAllJobsModel(jobs: [], count: 0);
    String url = baseUrl + getAllJobsByUserUrl; // + getJobByUserUrl;
    Response response;
    var dio = HttpServices().getDioInstance();
    String? token =
        await UserSharedPreference.getStringDataFromStorage('token');
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
        String errorMessage =
            DioExceptionHandler(exception: e).getErrorMessage();
        throw Exception(errorMessage);
      } else {
        throw Exception('An unexpected error occurred while fetching jobs.');
      }
    }
    return getAllJobsModel;
  }

  Future<bool> verifyEmail(String email) async {
    bool isVerified = false; // Default to false indicating verification failed
    String url = baseUrl + verifyEmailUrl;
    Response response;
    var dio = HttpServices().getDioInstance();

    try {
      response = await dio.post(
        url,
        data: {
          'email': email,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        debugPrint('Email verification successful');
        debugPrint("otp: ${data['otp']}");
        isVerified = true; // Email verification successful
      } else {
        throw Exception('Failed to verify email: ${response.data}');
      }
    } catch (e) {
      if (e is DioException) {
        String errorMessage =
            DioExceptionHandler(exception: e).getErrorMessage();
        throw Exception(errorMessage);
      } else {
        throw Exception(
            'An unexpected error occurred during email verification.');
      }
    }
    return isVerified;
  }

  Future<bool> changePassword(String password, String newPassword) async {
    bool isPasswordChanged =
        false; // Default to false indicating password change failed
    String url = baseUrl + changePasswordUrl;
    Response response;
    var dio = HttpServices().getDioInstance();

    try {
      response = await dio.patch(
        url,
        data: {
          'newPassword': password,
          'confirmPassword': newPassword,
        },
      );

      if (response.statusCode == 200) {
        debugPrint('Password changed successfully');
        isPasswordChanged = true; // Password change successful
      } else {
        throw Exception('Failed to change password: ${response.data}');
      }
    } catch (e) {
      if (e is DioException) {
        String errorMessage =
            DioExceptionHandler(exception: e).getErrorMessage();
        throw Exception(errorMessage);
      } else {
        throw Exception('An unexpected error occurred during password change');
      }
    }
    return isPasswordChanged;
  }

  Future<bool> deleteJob({required String jobId}) async {
    bool isJobDeleted = false; // Default to false indicating job delete failed
    String url = baseUrl + deleteJobUrl;
    Response response;
    var dio = HttpServices().getDioInstance();
    String? token =
        await UserSharedPreference.getStringDataFromStorage('token');

    // Check if the token is null or empty
    if (token == null || token.isEmpty) {
      throw Exception('Authentication token is missing');
    }

    try {
      response = await dio.delete(
        url,
        data: {
          'jobId': jobId,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        debugPrint('Job deleted successfully');
        isJobDeleted = true; // Job delete successful
      } else {
        throw Exception('Failed to delete job: ${response.data}');
      }
    } catch (e) {
      if (e is DioException) {
        String errorMessage =
            DioExceptionHandler(exception: e).getErrorMessage();
        throw Exception(errorMessage);
      } else {
        throw Exception('An unexpected error occurred during job delete');
      }
    }
    return isJobDeleted;
  }
}
