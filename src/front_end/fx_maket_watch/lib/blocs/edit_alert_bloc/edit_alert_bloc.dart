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
              repeatSetpoint: 0,
              note: '',
            ),
            alertMediumOk: false,
            timeframeOk: false,
            repeatSetpointOk: false,
            expirationOk: false,
            noteError: '',
            commodityOk: false,
            conditionOk: false,
            setpointOk: false,
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