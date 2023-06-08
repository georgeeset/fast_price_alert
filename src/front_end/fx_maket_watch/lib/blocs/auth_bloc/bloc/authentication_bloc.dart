import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

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
  }

  @override
  void onChange(Change<AuthenticationState> change) {
    print('state changed');
    print(change.currentState);
    super.onChange(change);
  }
}
