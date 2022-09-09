import 'package:flutter_weather_app/src/helpers/connection.helper.dart';
import 'package:flutter_weather_app/src/models/response.model.dart';
import 'package:flutter_weather_app/src/repositories/sources/network/auth.service.dart';
import 'package:flutter_weather_app/src/repositories/sources/network/forecast.service.dart';

class ForecastRepository {
  final ForecastService api;
  final ConnectionHelper connectionHelper;
  ForecastRepository(this.api, this.connectionHelper);

  Future<ResponseModel> fetchFiveDayForecast(String city) async {
    ResponseModel response = ResponseModel();

    final hasConnection = await connectionHelper.hasConnection();

    if (hasConnection) {
      response = await this.api.getForecast(city);
    } else {
      response.message = "Device offline";
    }

    return response;
  }
}
