import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fx_maket_watch/constants.dart' as constants;

import '../../models/alert_model.dart';

part 'edit_alert_event.dart';
part 'edit_alert_state.dart';

class EditAlertBloc extends Bloc<EditAlertEvent, EditAlertState> {
  EditAlertBloc()
      : super(
          const EditAlertState(
            myAlert: PriceAlert(
              condition: '',
              commodity: '',
              setpoint: 0.0,
              timeFrame: '',
              alertMedium: '',
              repeatSetpoint: 1,
              note: '',
            ),
            alertMediumOk: false,
            timeframeOk: false,
            repeatSetpointOk: true,
            expirationOk: false,
            noteError: '',
            commodityOk: false,
            conditionOk: false,
            setpointOk: false,
            updateModeOn: false,
          ),
        ) {
    // on<EditAlertEvent>((event, emit) {});

    on<UpdateCommodity>(((event, emit) {
      if (event.commodity != constants.commodityTitle) {
        emit(
          state.copyWith(
              myAlert: state.myAlert.updateAlert(commodity: event.commodity),
              commodityOk: true),
        );
      } else {
        emit(state.copyWith(commodityOk: false));
      }
    }));

    on<UpdateTimeFrame>((event, emit) {
      if (event.timeFrame != constants.timeFrameTitle) {
        emit(state.copyWith(
          myAlert: state.myAlert.updateAlert(timeFrame: event.timeFrame),
          timeframeOk: true,
        ));
      } else {
        emit(state.copyWith(timeframeOk: false));
      }
    });

    on<UpdateSetpoint>((event, emit) {
      try {
        var numba = double.parse(event.setpoint);
        emit(
          state.copyWith(
            setpointOk: true,
            myAlert: state.myAlert.updateAlert(setpoint: numba),
          ),
        );
      } catch (e) {
        emit(state.copyWith(setpointOk: false));
      }
    });

    on<UpdateCondition>((event, emit) {
      if (event.condition != constants.conditionTitle) {
        emit(state.copyWith(
            conditionOk: true,
            myAlert: state.myAlert.updateAlert(condition: event.condition)));
      } else {
        emit(state.copyWith(conditionOk: false));
      }
    });

    on<UpdateAlertMedium>(
      (event, emit) {
        if (event.alertMedium != constants.alertMediumTitle) {
          emit(
            state.copyWith(
              myAlert:
                  state.myAlert.updateAlert(alertMedium: event.alertMedium),
              alertMediumOk: true,
            ),
          );
        } else {
          emit(state.copyWith(alertMediumOk: false));
        }
      },
    );

    on<UpdateExpiration>(
      (event, emit) {
        emit(
          state.copyWith(
            myAlert:
                state.myAlert.updateAlert(expirationInDate: event.selectedDate),
            expirationOk: true,
          ),
        );
      },
    );

    on<UpdateRepeatSetpoint>(
      (event, emit) {
        try {
          var numba = int.parse(event.repeatSetpoint);
          emit(
            state.copyWith(
                repeatSetpointOk: true,
                myAlert: state.myAlert.updateAlert(repeatSetpoint: numba)),
          );
        } catch (e) {
          emit(state.copyWith(repeatSetpointOk: false));
        }
      },
    );

    on<UpdateNote>(
      (event, emit) {
        if (event.note.length < 5) {
          emit(state.copyWith(noteError: ('5 Characters is to short')));
        } else {
          emit(
            state.copyWith(
              noteError: '',
              myAlert: state.myAlert.updateAlert(note: event.note),
            ),
          );
        }
      },
    );

    on<ClearForm>(
      (event, emit) {
        emit(state.copyWith(
          myAlert: const PriceAlert(
            condition: '',
            commodity: '',
            setpoint: 0.0,
            timeFrame: '',
            alertMedium: '',
            repeatSetpoint: 1,
            note: '',
          ),
          alertMediumOk: false,
          timeframeOk: false,
          repeatSetpointOk: true,
          expirationOk: false,
          noteError: '',
          commodityOk: false,
          conditionOk: false,
          setpointOk: false,
          updateModeOn: true,
        ));
      },
    );

    on<LoadNewAlert>(
      (event, emit) {
        PriceAlert newAlert = event.alert;
        emit(state.copyWith(
          myAlert: newAlert,
          commentOk: true,
          alertMediumOk: true,
          timeframeOk: true,
          expirationOk: true,
          noteError: '',
          commodityOk: true,
          setpointOk: true,
          repeatSetpointOk: true,
          conditionOk: true,
          updateModeOn: true,
        ));
      },
    );

    on<UpdateMode>((event, emit) {
      emit(
        state.copyWith(
          updateModeOn: true,
        ),
      );
    });

    on<OffUpdate>(
      (event, emit) => emit(
        state.copyWith(
          updateModeOn: false,
        ),
      ),
    );
  }

  @override
  void onChange(Change<EditAlertState> change) {
    super.onChange(change);
    print('edit alert newState ${change.nextState}');
  }

  @override
  void onEvent(EditAlertEvent event) {
    super.onEvent(event);
    print('new Event $event');
  }
}
