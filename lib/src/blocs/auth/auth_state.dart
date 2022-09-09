import 'package:equatable/equatable.dart';
import 'package:flutter_weather_app/src/models/forecast.model.dart';
import 'package:flutter_weather_app/src/models/report.model.dart';
import 'package:flutter_weather_app/src/models/user.model.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
  @override
  List<Object> get props => [];
}

class AuthLoading extends AuthState {
  const AuthLoading();
  @override
  List<Object> get props => [];
}

class AuthLoaded extends AuthState {
  final UserModel user;
  const AuthLoaded(this.user);
  @override
  List<Object> get props => [user];
}

class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);
  @override
  List<Object> get props => [message];
}