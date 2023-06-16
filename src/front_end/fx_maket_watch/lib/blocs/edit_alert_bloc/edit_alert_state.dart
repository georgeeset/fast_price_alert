part of 'edit_alert_bloc.dart';

class EditAlertState extends Equatable {
  const EditAlertState({
    required this.timeframeOk,
    required this.alertMediumOk,
    required this.repeatSetpointOk,
    required this.expirationOk,
    required this.noteError,
    required this.myAlert,
    required this.conditionOk,
  });

  final PriceAlert myAlert;
  final bool conditionOk;
  final bool timeframeOk;
  final bool alertMediumOk;
  final bool repeatSetpointOk;
  final bool expirationOk;
  final String noteError;

  copyWith({
    PriceAlert? myAlert,
    bool? conditionOk,
    bool? timeframeOk,
    bool? alertMediumOk,
    bool? repeatSetpointOk,
    bool? expirationOk,
    String? noteError,
  }) {
    return EditAlertState(
      myAlert: myAlert ?? this.myAlert,
      conditionOk: conditionOk ?? this.conditionOk,
      timeframeOk: timeframeOk ?? this.timeframeOk,
      alertMediumOk: alertMediumOk ?? this.alertMediumOk,
      repeatSetpointOk: repeatSetpointOk ?? this.repeatSetpointOk,
      expirationOk: expirationOk ?? this.expirationOk,
      noteError: noteError ?? this.noteError,
    );
  }

  @override
  List<Object> get props => [
        myAlert,
        conditionOk,
        timeframeOk,
        alertMediumOk,
        repeatSetpointOk,
        expirationOk,
        noteError,
      ];
}
