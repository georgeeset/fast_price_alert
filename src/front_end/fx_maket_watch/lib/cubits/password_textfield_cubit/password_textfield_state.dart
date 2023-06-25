part of 'password_textfield_cubit.dart';

abstract class PasswordTextfieldState extends Equatable {
  const PasswordTextfieldState();

  @override
  List<Object> get props => [];
}

class PasswordTextfieldInitial extends PasswordTextfieldState {}

class PasswordTextfieldError extends PasswordTextfieldState {
  final String message;
  const PasswordTextfieldError({required this.message}) : super();
  @override
  String toString() => 'PasswordTextfieldError';
  @override
  List<Object> get props => [message];
}

class PasswordTextfieldOk extends PasswordTextfieldState {
  final String password;
  const PasswordTextfieldOk({required this.password});
  @override
  String toString() => 'PasswordTextfieldOk';
  @override
  List<Object> get props => [password];
}
