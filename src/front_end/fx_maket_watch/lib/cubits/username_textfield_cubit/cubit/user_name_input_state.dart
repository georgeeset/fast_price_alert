part of 'user_name_input_cubit.dart';

abstract class UserNameInputState extends Equatable {
  const UserNameInputState();

  @override
  List<Object> get props => [];
}

class UserNameInputInitial extends UserNameInputState {}

class UserNameInputError extends UserNameInputState {
  final String message;
  const UserNameInputError({required this.message});

  @override
  String toString() => 'UserNameInputError';

  @override
  List<Object> get props => [message];
}

class UserNameInputOk extends UserNameInputState {
  final String userName;
  const UserNameInputOk({required this.userName});

  @override
  String toString() => 'UserNameInputOk';

  @override
  List<Object> get props => [userName];
}
