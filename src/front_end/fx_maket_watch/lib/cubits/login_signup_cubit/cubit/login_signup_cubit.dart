import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_signup_state.dart';

class LoginSignupCubit extends Cubit<LoginSignupState> {
  LoginSignupCubit() : super(SignupState());

  loginSelected() {
    emit(LoginState());
  }

  signupSelected() {
    emit(SignupState());
  }
}
