import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fx_maket_watch/repository/util_functions.dart';
import 'package:fx_maket_watch/services/api_calls.dart' as service;

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<AppStartedEvent>((event, emit) async {
      emit(AuthenticationInitial());
    });

    on<LoginEvent>((event, emit) async {
      emit(AuthenticationLoadingState());
      await service
          .login(userName: event.userName, password: event.password)
          .then((value) => emit(
                AuthenticatedState(apiKey: value),
              ))
          .catchError(
              (err) => emit(AuthenticationError(message: err.toString())));
    });

    on<LogoutEvent>((event, emit) async {
      emit(AuthenticationInitial());
    });

    on<RegisterEvent>((event, emit) async {
      emit(AuthenticationLoadingState());

      try {
        var response = await service.signup(
          firstName: event.firstName,
          userName: event.userName,
          password: event.password,
          surname: event.surname,
          interests: event.interests,
        );

        if (response.statusCode == 201) {
          emit(RegisteredState());
        } else {
          emit(AuthenticationError(message: valueFromStrMap(response.body)));
        }
      } catch (e) {
        emit(AuthenticationError(message: e.toString()));
      }
    });
  }

  @override
  void onChange(Change<AuthenticationState> change) {
    print('state changed');
    print(change.currentState.toString());
    print('New State');
    print(change.nextState.toString());
    super.onChange(change);
  }
}
