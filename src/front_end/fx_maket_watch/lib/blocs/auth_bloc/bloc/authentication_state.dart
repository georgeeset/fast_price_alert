part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoadingState extends AuthenticationState {}

class AuthenticatedState extends AuthenticationState {
  final String apiKey;
  const AuthenticatedState({required this.apiKey});

  @override
  String toString() => 'AuthenticatedState';

  @override
  List<Object> get props => [apiKey];
}
