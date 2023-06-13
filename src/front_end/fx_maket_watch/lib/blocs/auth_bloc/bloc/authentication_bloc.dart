import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

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
      //TODO send emal and passordffor authentaication
      print(event.userName);
      print(event.password);
      emit(AuthenticatedState(apiKey: 'apiKey'));
    });

    on<LogoutEvent>((event, emit) async {
      emit(AuthenticationInitial());
    });

    on<RegisterEvent>((event, emit) async {
      emit(AuthenticationLoadingState());
      //TODO send registration message
      debugPrint(event.name);
      debugPrint(event.password);
      emit(RegisteredState());
    });
  }

  @override
  void onChange(Change<AuthenticationState> change) {
    debugPrint('state changed');
    debugPrint(change.currentState.toString());
    debugPrint('New State');
    debugPrint(change.nextState.toString());
    super.onChange(change);
  }
}
