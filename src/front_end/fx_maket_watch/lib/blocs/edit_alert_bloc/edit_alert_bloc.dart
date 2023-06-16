import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

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
            conditionOk: false,
          ),
        ) {
    // on<EditAlertEvent>((event, emit) {});

    on<UpdateCommodity>(((event, emit) {}));
  }
}
