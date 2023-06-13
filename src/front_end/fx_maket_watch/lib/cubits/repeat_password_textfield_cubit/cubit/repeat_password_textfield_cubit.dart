import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../password_textfield_cubit/password_textfield_cubit.dart';

part 'repeat_password_textfield_state.dart';

class RepeatPasswordTextfieldCubit extends Cubit<RepeatPasswordTextfieldState> {
  RepeatPasswordTextfieldCubit({required this.firstPassword})
      : super(RepeatPasswordTextfieldInitial()) {
    passwordSubscription = firstPassword.stream.listen((event) {
      emit(const RepeatPasswordTextfieldError(message: 'Not consistent'));
    });
  }
  late StreamSubscription passwordSubscription;
  final PasswordTextfieldCubit firstPassword;
  String? password;

  void updateText({required password}) {
    var sample = firstPassword.state;
    if (sample is PasswordTextfieldOk) {
      if (sample.password == password) {
        emit(RepeatPasswordTextfieldOk(password: password));
      } else {
        emit(const RepeatPasswordTextfieldError(message: 'Not consistent'));
      }
    }
  }

  @override
  Future<void> close() {
    passwordSubscription.cancel();
    return super.close();
  }
}
