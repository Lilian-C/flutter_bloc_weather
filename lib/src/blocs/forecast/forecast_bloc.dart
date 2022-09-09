import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/src/blocs/forecast/forecast_event.dart';
import 'forecast_state.dart';
import 'package:flutter_weather_app/src/repositories/forecast.repository.dart';

class ForecastBloc extends Bloc<ForecastEvent, ForecastState> {
  final ForecastRepository repository;

  ForecastBloc(this.repository) : super(const ForecastInitial()) {
    on<GetForecast>(_onGetForecast);
  }

  void _onGetForecast(GetForecast event, Emitter<ForecastState> emit) async {
    emit(ForecastLoading());
    try {
      final response = await repository.fetchFiveDayForecast(event.cityName);
      if (response.status == 200)
        emit(ForecastLoaded(response.data));
      else
        emit(ForecastError(response.message));
    } on DioError {
      emit(ForecastError("Couldn't fetch forecast."));
    }
  }
}