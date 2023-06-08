part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppStartedEvent extends AuthenticationEvent {
  @override
  String toString() => 'AppStartedEvent';
}

class LoginEvent extends AuthenticationEvent {
  final String userName;
  final String password;

  const LoginEvent({required this.userName, required this.password});
}

class LogoutEvent extends AuthenticationEvent {
  @override
  String toString() => 'LogoutEvent';
}
