import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_weather_app/src/helpers/http/http.helper.dart';
import 'package:flutter_weather_app/src/helpers/storage/storage.helper.dart';
import 'package:flutter_weather_app/src/helpers/storage/storage.keys.dart';
import 'package:flutter_weather_app/src/models/forecast.model.dart';
import 'package:flutter_weather_app/src/models/report.model.dart';
import 'package:flutter_weather_app/src/models/response.model.dart';
import 'package:flutter_weather_app/src/models/user.model.dart';
import './base/endpoints.dart' as Endpoints;

class ForecastService {
  Future<ResponseModel> getForecast(String city) async {
    ResponseModel response = ResponseModel();
    ReportModel forecasts;

    final String url = Endpoints.forecast.fiveDayForecasts;
    final queryParameters = {"q": city, "lang": "fr"};
    final retForecast = HttpHelper.get(url, queryParameters: queryParameters);

    await retForecast.then((res) {
      forecasts = ReportModel.fromJson(res.data!);

      response.status = res.statusCode!;
      response.data = forecasts;
      response.message = res.statusMessage!;

    }).catchError((e) {
      if (e is DioError) {
        response.status = e.response?.statusCode ?? 500;
        response.data = e.response;
        response.message = e.message;
      }
      else
        print(e.toString());
    });

    return response;
  }
}
