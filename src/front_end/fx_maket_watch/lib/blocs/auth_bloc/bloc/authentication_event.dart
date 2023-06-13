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

class RegisterEvent extends AuthenticationEvent {
  final String name;
  final String surname;
  final String userName;
  final String password;
  final List<String> interests;

  const RegisterEvent({
    required this.name,
    required this.surname,
    required this.userName,
    required this.password,
    required this.interests,
  });

  @override
  List<Object> get props => [
        name,
        surname,
        userName,
        surname,
        password,
        interests,
      ];
  @override
  String toString() => 'RegisterEvent';
}
