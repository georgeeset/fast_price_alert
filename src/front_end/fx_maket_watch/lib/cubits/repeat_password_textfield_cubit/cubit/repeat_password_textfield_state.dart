part of 'repeat_password_textfield_cubit.dart';

abstract class RepeatPasswordTextfieldState extends Equatable {
  const RepeatPasswordTextfieldState();

  @override
  List<Object> get props => [];
}

class RepeatPasswordTextfieldInitial extends RepeatPasswordTextfieldState {}

class RepeatPasswordTextfieldError extends RepeatPasswordTextfieldState {
  final String message;
  const RepeatPasswordTextfieldError({required this.message}) : super();
  @override
  String toString() => 'RepeatPasswordTextfieldError';
  @override
  List<Object> get props => [message];
}

class RepeatPasswordTextfieldOk extends RepeatPasswordTextfieldState {
  final String password;
  const RepeatPasswordTextfieldOk({required this.password});
  @override
  String toString() => 'RepeatPasswordTextfieldOk';
  @override
  List<Object> get props => [password];
}
