import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../services/api_calls.dart';

part 'delete_alert_state.dart';

class DeleteAlertCubit extends Cubit<DeleteAlertState> {
  DeleteAlertCubit() : super(DeleteAlertInitial());

  deleteOneAlert({
    required int alertId,
    required String apiKey,
  }) async {
    emit(DeleteLoading());

    await deleteAlert(alertId: alertId, token: apiKey).then((value) {
      emit(
        AlertDeleted(message: value.values.toString()),
      );
    }).onError(
      (error, stackTrace) {
        emit(
          DeleteFailed(
            message: error.toString(),
          ),
        );
      },
    );
  }
}
