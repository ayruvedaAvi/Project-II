
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioExceptionHandler{
  final DioException exception;

  const DioExceptionHandler({required this.exception});

  String getErrorMessage() {
    String errorMessage = 'Failed to login due to network or server issue';

        switch (exception.type) {
          case DioExceptionType.connectionTimeout:
            errorMessage =
                'Connection timeout. Please check your internet connection.';
            break;
          case DioExceptionType.sendTimeout:
            errorMessage = 'Request send timeout. Please try again.';
            break;
          case DioExceptionType.receiveTimeout:
            errorMessage = 'Response receive timeout. Please try again.';
            break;
          case DioExceptionType.badCertificate:
            errorMessage =
                'Bad certificate. Please check your network connection.';
            break;
          case DioExceptionType.badResponse:
            // The server returned a response with an error status code
            if (exception.response != null) {
              errorMessage =
                  'Bad response: ${exception.response?.statusCode} ${exception.response?.statusMessage}';
              // Optionally, you can parse the response body if needed
              debugPrint('Response data: ${exception.response?.data}');
            }
            break;
          case DioExceptionType.connectionError:
            errorMessage =
                'Connection error. Please check your network connection.';
            break;
          case DioExceptionType.unknown:
            // The server returned a response with an error status code
            if (exception.response != null) {
              errorMessage =
                  'Server error: ${exception.response?.statusCode} ${exception.response?.statusMessage}';
              // Optionally, you can parse the response body if needed
              debugPrint('Response data: ${exception.response?.data}');
            }
            break;
          case DioExceptionType.cancel:
            errorMessage = 'Request to the server was cancelled.';
            break;
        }

        debugPrint('DioError: ${exception.message}');
        debugPrint('Error type: ${exception.type}');
        debugPrint('Request options: ${exception.requestOptions}');
        if (exception.error != null) {
          debugPrint('Original error: ${exception.error}');
        }
        return errorMessage;
  }
}