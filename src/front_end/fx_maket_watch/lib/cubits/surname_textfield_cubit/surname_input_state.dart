part of 'surname_input_cubit.dart';

abstract class SurnameInputState extends Equatable {
  const SurnameInputState();

  @override
  List<Object> get props => [];
}

class SurnameInputInitial extends SurnameInputState {}

class SurnameInputError extends SurnameInputState {
  final String message;
  const SurnameInputError({required this.message});
  @override
  String toString() {
    return message;
  }

  @override
  List<Object> get props => [message];
}

class SurnameInputOk extends SurnameInputState {
  final String surname;
  const SurnameInputOk(this.surname);

  @override
  String toString() {
    return surname;
  }

  @override
  List<Object> get props => [surname];
}
