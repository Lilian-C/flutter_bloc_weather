import 'package:flutter_weather_app/src/helpers/connection.helper.dart';
import 'package:flutter_weather_app/src/models/response.model.dart';
import 'package:flutter_weather_app/src/repositories/sources/network/auth.service.dart';

class AuthRepository {
  final AuthService api;
  final ConnectionHelper connectionHelper;
  AuthRepository(this.api, this.connectionHelper);

  Future<ResponseModel> login(String login, String password) async {
    ResponseModel response = ResponseModel();

    final hasConnection = await connectionHelper.hasConnection();

    if (hasConnection) {
      response = await api.login(login, password);
    } else {
      response.message = "Device offline";
    }

    return response;
  }
}
