import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'forecast_state.dart';
import 'package:flutter_weather_app/src/repositories/forecast.repository.dart';

class ForecastCubit extends Cubit<ForecastState> {
  final ForecastRepository repository;

  ForecastCubit(this.repository) : super(const ForecastInitial());

  void onGetForecast(String city) async {
    emit(const ForecastLoading());
    try {
      final response = await repository.fetchFiveDayForecast(city);
      if (response.status == 200) {
        emit(ForecastLoaded(response.data));
      }
      else {
        emit(ForecastError(response.message));
      }
    } on DioError {
      emit(const ForecastError("Couldn't fetch forecast."));
    }
  }
}