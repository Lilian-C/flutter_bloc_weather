import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_app/src/helpers/connection.helper.dart';
import 'package:flutter_weather_app/src/models/response.model.dart';
import 'package:flutter_weather_app/src/repositories/auth.repository.dart';
import 'package:flutter_weather_app/src/repositories/sources/network/auth.service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_repository_test.mocks.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockAuthService extends Mock implements AuthService {}

class MockConnectionHelper extends Mock implements ConnectionHelper {}

@GenerateMocks([MockAuthRepository])
@GenerateMocks([MockAuthService])
@GenerateMocks([MockConnectionHelper])
void main() {
  MockAuthService mockAuthService = MockMockAuthService();

  group('Testing Auth Repository', () {
    MockConnectionHelper mockConnectedConnectionHelper = MockMockConnectionHelper();
    AuthRepository connectedRepository = AuthRepository(mockAuthService, mockConnectedConnectionHelper);
    ResponseModel basicResponse = ResponseModel();

    when(mockAuthService.login("lilian.cadiou@outlook.fr", "123")).thenAnswer((_) async => basicResponse);
    when(mockConnectedConnectionHelper.hasConnection()).thenAnswer((_) async => true);

    test("Testing repository with internet connection", () async {
      expect(await connectedRepository.login("lilian.cadiou@outlook.fr", "123"), basicResponse);
      expect((await connectedRepository.login("lilian.cadiou@outlook.fr", "123")).message, isNot("Device offline"));
    });

    MockConnectionHelper mockDisconnectedConnectionHelper = MockMockConnectionHelper();
    AuthRepository disconnectedRepository = AuthRepository(mockAuthService, mockDisconnectedConnectionHelper);
    when(mockDisconnectedConnectionHelper.hasConnection()).thenAnswer((_) async => false);

    test("Testing repository without internet connection", () async {
      expect((await disconnectedRepository.login("lilian.cadiou@outlook.fr", "123")).message, "Device offline");
    });
  });
}
