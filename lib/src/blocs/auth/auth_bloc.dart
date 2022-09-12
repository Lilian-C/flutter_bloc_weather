import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/src/blocs/auth/auth_event.dart';
import 'auth_state.dart';
import 'package:flutter_weather_app/src/repositories/auth.repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;

  AuthBloc(this.repository) : super(const AuthInitial()) {
    on<GetAuth>(_onGetAuth);
  }

  void _onGetAuth(GetAuth event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try {
      final response = await repository.login(event.login, event.password);
      if (response.status == 201) {
        emit(AuthLoaded(response.data));
      } else {
        emit(AuthError(response.message));
      }
    } on DioError {
      emit(const AuthError("Couldn't fetch auth."));
    }
  }
}
