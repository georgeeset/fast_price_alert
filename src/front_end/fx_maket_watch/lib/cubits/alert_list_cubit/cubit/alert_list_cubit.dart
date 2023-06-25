import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fx_maket_watch/services/api_calls.dart';

import '../../../models/alert_model.dart';

part 'alert_list_state.dart';

class PriceAlertListCubit extends Cubit<PriceAlertListState> {
  final String token;

  PriceAlertListCubit({required this.token}) : super(AlertListInitial()) {
    //ToDo request for alert
    // lodaing state
    // loaded state
    getAlert();
  }

  _fetchMe() async {
    try {
      String result = await getAllAlerts(token: token);
      Iterable l = json.decode(result);
      List<PriceAlert> alerts = List<PriceAlert>.from(
        l.map(
          (item) => PriceAlert.fromJson(json: item),
        ),
      );

      if (alerts.isEmpty) {
        emit(AlertEmpty());
      } else {
        emit(AlertLoaded(alertList: alerts));
      }
    } catch (e) {
      emit(AlertLoadingError(message: e.toString()));
    }
  }

  getAlert() {
    emit(AlertLoading());
    _fetchMe();
  }

  reloadAlert() {
    _fetchMe();
  }
}
