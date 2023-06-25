part of 'name_input_cubit.dart';

abstract class NameInputState extends Equatable {
  const NameInputState();

  @override
  List<Object> get props => [];
}

class NameInputInitial extends NameInputState {}

class NameInputError extends NameInputState {
  final String message; //the error message
  const NameInputError({required this.message});
  @override
  String toString() => 'NameInputError';
  @override
  List<Object> get props => [message];
}

class NameInputOk extends NameInputState {
  final String name;
  const NameInputOk({required this.name});
  @override
  String toString() => 'NameInputOk';
  @override
  List<Object> get props => [name];
}
