import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'alert_list_state.dart';

class PriceAlertListCubit extends Cubit<PriceAlertListState> {
  PriceAlertListCubit() : super(AlertListInitial()) {
    //ToDo request for alert
    // lodaing state
    // loaded state
  }

  getAlert() {
    emit(AlertLoading());
  }
}
