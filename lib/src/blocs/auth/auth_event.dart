
import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class GetAuth extends AuthEvent {
  final String login;
  final String password;

  const GetAuth(this.login, this.password);

  @override
  List<Object> get props => [login, password];
}