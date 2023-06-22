part of 'edit_alert_bloc.dart';

abstract class EditAlertEvent extends Equatable {
  const EditAlertEvent();

  @override
  List<Object> get props => [];
}

class UpdateCondition extends EditAlertEvent {
  final String condition;

  const UpdateCondition({required this.condition});

  @override
  List<Object> get props => [condition];

  @override
  String toString() {
    return 'UpdateconditionEvent';
  }
}

class UpdateCommodity extends EditAlertEvent {
  final String commodity;

  const UpdateCommodity({required this.commodity});

  @override
  List<Object> get props => [commodity];
  @override
  String toString() => "UpdateCommodityEvent";
}

class UpdateSetpoint extends EditAlertEvent {
  ///to be converted to double before updating
  final String setpoint;

  const UpdateSetpoint({required this.setpoint});

  @override
  List<Object> get props => [setpoint];

  @override
  String toString() => "UpdateSetpointEvent";
}

class UpdateTimeFrame extends EditAlertEvent {
  final String timeFrame;

  const UpdateTimeFrame({required this.timeFrame});

  @override
  List<Object> get props => [timeFrame];
  @override
  String toString() => "UpdateTimeframeEvent";
}

class UpdateAlertMedium extends EditAlertEvent {
  final String alertMedium;

  const UpdateAlertMedium({required this.alertMedium});

  @override
  List<Object> get props => [alertMedium];

  @override
  String toString() => 'UpdateAlertMediumEvent';
}

class UpdateRepeatSetpoint extends EditAlertEvent {
  final String repeatSetpoint;

  const UpdateRepeatSetpoint({required this.repeatSetpoint});

  @override
  List<Object> get props => [repeatSetpoint];

  @override
  String toString() {
    return 'UpdateSetpointEvent';
  }
}

class UpdateNote extends EditAlertEvent {
  final String note;

  const UpdateNote({required this.note});

  @override
  List<Object> get props => [note];

  @override
  String toString() => 'UpdateNoteEvent';
}

class LoadNewAlert extends EditAlertEvent {
  final PriceAlert alert;
  const LoadNewAlert({required this.alert});

  @override
  List<Object> get props => [alert];
  @override
  String toString() => "LoadNewAlertEvent";
}

class UpdateExpiration extends EditAlertEvent {
  final DateTime selectedDate;
  const UpdateExpiration({required this.selectedDate});

  @override
  List<Object> get props => [selectedDate];

  @override
  String toString() => 'UpdateExpirationState';
}

///To help trigger updatemode so that all fields
///will be updated with nre data
class UpdateMode extends EditAlertEvent {
  @override
  String toString() => 'UpdateEvent';
}

///allow widgets like textinputs to stop listening to what
///they write thereby causing intference
class OffUpdate extends EditAlertEvent {
  @override
  String toString() => 'OffUpdateEvent';
}

class ClearForm extends EditAlertEvent {
  @override
  String toString() => 'ClearFormEvent';
}
