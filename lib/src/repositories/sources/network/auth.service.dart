import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_weather_app/src/helpers/storage/storage.helper.dart';
import 'package:flutter_weather_app/src/helpers/storage/storage.keys.dart';
import 'package:flutter_weather_app/src/models/response.model.dart';
import 'package:flutter_weather_app/src/models/user.model.dart';
import './base/endpoints.dart' as Endpoints;

class AuthService {
  Future<ResponseModel> login(String login, String password) async {
    ResponseModel response = ResponseModel();
    UserModel user;

    final String url = Endpoints.auth.login;

    final payload = {login, password};

    // We don't make a real call this time:
    // final retAuth = HttpHelper.post(url, body: payload);

    // We'll create a fake Response object here instead:
    final retAuth = Future.delayed(const Duration(milliseconds: 200)).then((value) {
      return Response(
          statusCode: 201,
          statusMessage: "",
          data: jsonDecode('{"id": 0, "email": "$login", "username": "OuiSNCF"}') as Map<String, dynamic>,
          requestOptions: RequestOptions(path: url, method: 'GET'));
    });

    await retAuth.then((res) {
      user = UserModel.fromJson(res.data!);

      StorageHelper.set(StorageKeys.username, user.username ?? "Undefined");

      response.status = res.statusCode!;
      response.data = user;
      response.message = res.statusMessage!;
    }).catchError((e) {
      if (e is DioError) {
        response.status = e.response?.statusCode ?? 500;
        response.data = e.response;
        response.message = e.message;
      } else {
        print(e.toString());
      }
    });

    return response;
  }
}
