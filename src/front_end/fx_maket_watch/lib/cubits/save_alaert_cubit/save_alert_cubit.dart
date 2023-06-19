import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fx_maket_watch/services/api_calls.dart';

import '../../models/alert_model.dart';

part 'save_alert_state.dart';

class SaveAlertCubit extends Cubit<SaveAlertState> {
  SaveAlertCubit() : super(SaveAlertInitial());

  saveAlert(PriceAlert newAlert, String token) async {
    emit(SaveAlertLoading());

    var alertDressup = newAlert;
    var nowTime = DateTime.now();
    var inHours = alertDressup.expirationInDate!.difference(nowTime).inHours;
    alertDressup = alertDressup.updateAlert(expirationInHrs: inHours);
    // print(alertDressup.expirationInHrs);

    await addAlert(newAlert: alertDressup, token: token).then((value) {
      // print(value['alert_id']);
      emit(SaveAlertSuccess(response: value));
    }).onError((error, stackTrace) {
      // print('failed in cubit$error');
      emit(
        SaveAlertFailed(message: error.toString()),
      );
    });
  }
}
