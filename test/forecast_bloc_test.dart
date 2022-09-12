import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_app/src/blocs/base/bloc.dart';
import 'package:flutter_weather_app/src/models/report.model.dart';
import 'package:flutter_weather_app/src/models/response.model.dart';
import 'package:flutter_weather_app/src/repositories/forecast.repository.dart';
import 'package:flutter_weather_app/src/repositories/sources/network/forecast.service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'forecast_bloc_test.mocks.dart';

class MockForecastRepository extends Mock implements ForecastRepository {}

class MockForecastService extends Mock implements ForecastService {}

@GenerateMocks([MockForecastRepository])
@GenerateMocks([MockForecastService])
void main() {
  group('Testing Forecast Bloc', () {
    MockForecastRepository mockForecastRepository = MockMockForecastRepository();

    ResponseModel successResponse = ResponseModel(status: 200, message: "", data: ReportModel());
    ResponseModel errorResponse = ResponseModel(status: 500, message: "An error occured", data: "");

    when(mockForecastRepository.fetchFiveDayForecast("Paris")).thenAnswer((_) async => successResponse);
    when(mockForecastRepository.fetchFiveDayForecast("")).thenAnswer((_) async => errorResponse);
    when(mockForecastRepository.fetchFiveDayForecast("CrashMe")).thenAnswer((_) async => throw DioError(requestOptions: RequestOptions(path: "/")));

    blocTest(
      'emits [ForecastLoading, ForecastLoaded] when successful',
      build: () => ForecastCubit(mockForecastRepository),
      act: (ForecastCubit bloc) => bloc.onGetForecast("Paris"),
      expect: () => [
        const ForecastLoading(),
        ForecastLoaded(successResponse.data),
      ],
    );

    blocTest(
      'emits [ForecastLoading, ForecastError] when unsuccessful',
      build: () => ForecastCubit(mockForecastRepository),
      act: (ForecastCubit bloc) => bloc.onGetForecast("city"),
      expect: () => [
        const ForecastLoading(),
        const ForecastError("An error occured"),
      ],
    );

    blocTest(
      'emits [ForecastLoading, ForecastError] when Dio throws an error',
      build: () => ForecastCubit(mockForecastRepository),
      act: (ForecastCubit bloc) => bloc.onGetForecast("CrashMe"),
      expect: () => [
        const ForecastLoading(),
        const ForecastError("Couldn't fetch forecast."),
      ],
    );
  });
}
