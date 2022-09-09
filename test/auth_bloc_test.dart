import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_app/src/blocs/base/bloc.dart';
import 'package:flutter_weather_app/src/helpers/connection.helper.dart';
import 'package:flutter_weather_app/src/models/report.model.dart';
import 'package:flutter_weather_app/src/models/response.model.dart';
import 'package:flutter_weather_app/src/models/user.model.dart';
import 'package:flutter_weather_app/src/repositories/auth.repository.dart';
import 'package:flutter_weather_app/src/repositories/forecast.repository.dart';
import 'package:flutter_weather_app/src/repositories/sources/network/auth.service.dart';
import 'package:flutter_weather_app/src/repositories/sources/network/forecast.service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_bloc_test.mocks.dart';
import 'forecast_bloc_test.mocks.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockAuthService extends Mock implements AuthService {}

@GenerateMocks([MockAuthRepository])
@GenerateMocks([MockAuthService])
void main() {
  group('Testing Auth Bloc', () {
    MockAuthRepository mockAuthRepository = MockMockAuthRepository();

    ResponseModel successResponse = ResponseModel(status: 201, message: "", data: UserModel());
    ResponseModel errorResponse = ResponseModel(status: 500, message: "An error occured", data: "");

    when(mockAuthRepository.login("lilian.cadiou@outlook.fr", "123")).thenAnswer((_) async => successResponse);
    when(mockAuthRepository.login("username", "123")).thenAnswer((_) async => errorResponse);
    when(mockAuthRepository.login("Crash", "Me")).thenAnswer((_) async => throw DioError(requestOptions: RequestOptions(path: "/")));

    blocTest(
      'emits [AuthLoading, AuthLoaded] when successful',
      build: () => AuthBloc(mockAuthRepository),
      act: (AuthBloc bloc) => bloc.add(GetAuth("lilian.cadiou@outlook.fr", "123")),
      expect: () => [
        AuthLoading(),
        AuthLoaded(successResponse.data),
      ],
    );

    blocTest(
      'emits [AuthLoading, AuthError] when unsuccessful',
      build: () => AuthBloc(mockAuthRepository),
      act: (AuthBloc bloc) => bloc.add(GetAuth("username", "123")),
      expect: () => [
        AuthLoading(),
        AuthError("An error occured"),
      ],
    );

    blocTest(
      'emits [AuthLoading, AuthError] when unsuccessful',
      build: () => AuthBloc(mockAuthRepository),
      act: (AuthBloc bloc) => bloc.add(GetAuth("Crash", "Me")),
      expect: () => [
        AuthLoading(),
        AuthError("Couldn't fetch auth."),
      ],
    );
  });
}
