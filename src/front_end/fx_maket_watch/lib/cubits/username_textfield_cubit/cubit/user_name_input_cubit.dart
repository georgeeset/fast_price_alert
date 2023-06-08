import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fx_maket_watch/repository/validator.dart';

part 'user_name_input_state.dart';

class UserNameInputCubit extends Cubit<UserNameInputState> {
  UserNameInputCubit() : super(UserNameInputInitial());
  Validator validator = Validator();
  updateUserName({required String name}) {
    final String? result = validator.validateUserName(name);
    if (result != null) {
      emit(UserNameInputError(message: result));
    } else {
      emit(UserNameInputOk(userName: name));
    }
  }
}
