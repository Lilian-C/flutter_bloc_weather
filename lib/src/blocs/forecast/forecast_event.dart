
import 'package:equatable/equatable.dart';

abstract class ForecastEvent extends Equatable {
  const ForecastEvent();
}

class GetForecast extends ForecastEvent {
  final String cityName;

  const GetForecast(this.cityName);

  @override
  List<Object> get props => [cityName];
}