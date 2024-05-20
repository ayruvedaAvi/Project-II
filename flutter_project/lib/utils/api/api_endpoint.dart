import 'package:dio/dio.dart';
import 'package:flutter_project/models/login/login_model.dart';
import 'package:flutter_project/utils/api/api_urls.dart';
import 'package:flutter_project/utils/api/http_services.dart';

class ApiEndpoints {
  Future<Response> login(LoginModel loginModel) async {
    bool isLogin = true;
    String url = baseUrl + loginUrl;
    Response response;
    var dio = HttpServices().getDioInstance();
    try{
      response = await dio.post(
        url,
        data: loginModel.toJson(),
      );
      if (response.statusCode == 201) {
        return response;
      } else {
        throw Exception(response.data);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
