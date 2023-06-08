part of 'login_signup_cubit.dart';

abstract class LoginSignupState extends Equatable {
  const LoginSignupState();

  @override
  List<Object> get props => [];
}

class LoginState extends LoginSignupState {}

class SignupState extends LoginSignupState {}
