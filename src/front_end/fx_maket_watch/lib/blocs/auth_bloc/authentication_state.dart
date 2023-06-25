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

  Map<String, dynamic> toMap() {
    return {'apiKey': apiKey};
  }
}

class RegisteredState extends AuthenticationState {
  @override
  String toString() {
    return 'REgisteredState';
  }
}

class AuthenticationError extends AuthenticationState {
  final String message;
  const AuthenticationError({required this.message});
  @override
  String toString() => 'AuthenticationError State';
}
