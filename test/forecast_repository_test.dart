import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_app/src/helpers/connection.helper.dart';
import 'package:flutter_weather_app/src/models/response.model.dart';
import 'package:flutter_weather_app/src/repositories/forecast.repository.dart';
import 'package:flutter_weather_app/src/repositories/sources/network/forecast.service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'forecast_repository_test.mocks.dart';

class MockForecastRepository extends Mock implements ForecastRepository {}

class MockForecastService extends Mock implements ForecastService {}

class MockConnectionHelper extends Mock implements ConnectionHelper {}

@GenerateMocks([MockForecastRepository])
@GenerateMocks([MockForecastService])
@GenerateMocks([MockConnectionHelper])
void main() {
  MockForecastService mockForecastService = MockMockForecastService();

  group('Testing Forecast Repository', () {
    MockConnectionHelper mockConnectedConnectionHelper = MockMockConnectionHelper();
    ForecastRepository connectedRepository = ForecastRepository(mockForecastService, mockConnectedConnectionHelper);
    ResponseModel basicResponse = ResponseModel();

    when(mockForecastService.getForecast("Nantes")).thenAnswer((_) async => basicResponse);
    when(mockConnectedConnectionHelper.hasConnection()).thenAnswer((_) async => true);

    test("Testing repository with internet connection", () async {
      expect(await connectedRepository.fetchFiveDayForecast("Nantes"), basicResponse);
      expect((await connectedRepository.fetchFiveDayForecast("Nantes")).message, isNot("Device offline"));
    });

    MockConnectionHelper mockDisconnectedConnectionHelper = MockMockConnectionHelper();
    ForecastRepository disconnectedRepository = ForecastRepository(mockForecastService, mockDisconnectedConnectionHelper);
    when(mockDisconnectedConnectionHelper.hasConnection()).thenAnswer((_) async => false);

    test("Testing repository without internet connection", () async {
      expect((await disconnectedRepository.fetchFiveDayForecast("Nantes")).message, "Device offline");
    });
  });
}
