import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fx_maket_watch/repository/validator.dart';

part 'surname_input_state.dart';

class SurnameInputCubit extends Cubit<SurnameInputState> {
  SurnameInputCubit() : super(SurnameInputInitial());
  final Validator validator = Validator();

  updateText(String surname) {
    String? result = validator.validateName(surname);
    if (result != null) {
      emit(SurnameInputError(message: result));
    } else {
      emit(SurnameInputOk(surname));
    }
  }
}
