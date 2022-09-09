import 'package:equatable/equatable.dart';
import 'package:flutter_weather_app/src/models/forecast.model.dart';
import 'package:flutter_weather_app/src/models/report.model.dart';

abstract class ForecastState extends Equatable {
  const ForecastState();
}

class ForecastInitial extends ForecastState {
  const ForecastInitial();
  @override
  List<Object> get props => [];
}

class ForecastLoading extends ForecastState {
  const ForecastLoading();
  @override
  List<Object> get props => [];
}

class ForecastLoaded extends ForecastState {
  final ReportModel report;
  const ForecastLoaded(this.report);
  @override
  List<Object> get props => [report];
}

class ForecastError extends ForecastState {
  final String message;
  const ForecastError(this.message);
  @override
  List<Object> get props => [message];
}