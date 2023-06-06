import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fx_maket_watch/repository/validator.dart';

part 'name_input_state.dart';

class NameInputCubit extends Cubit<NameInputState> {
  NameInputCubit() : super(NameInputInitial());
  final Validator validator = Validator();

  updateText(String name) {
    String? result = validator.validateName(name);
    if (result == null) {
      emit(NameInputOk(name: name));
    } else {
      emit(NameInputError(message: result));
    }
  }
}
