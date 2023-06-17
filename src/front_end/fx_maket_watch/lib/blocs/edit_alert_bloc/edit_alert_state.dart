part of 'edit_alert_bloc.dart';

class EditAlertState extends Equatable {
  const EditAlertState({
    required this.timeframeOk,
    required this.alertMediumOk,
    required this.repeatSetpointOk,
    required this.expirationOk,
    required this.noteError,
    required this.myAlert,
    required this.commodityOk,
    required this.setpointOk,
    required this.conditionOk,
  });

  final PriceAlert myAlert;
  final bool commodityOk;
  final bool timeframeOk;
  final bool alertMediumOk;
  final bool repeatSetpointOk;
  final bool expirationOk;
  final bool setpointOk;
  final String noteError;
  final bool conditionOk;

  EditAlertState copyWith({
    PriceAlert? myAlert,
    bool? commodityOk,
    bool? timeframeOk,
    bool? alertMediumOk,
    bool? repeatSetpointOk,
    bool? expirationOk,
    String? noteError,
    bool? setpointOk,
    bool? conditionOk,
  }) {
    return EditAlertState(
      myAlert: myAlert ?? this.myAlert,
      commodityOk: commodityOk ?? this.commodityOk,
      timeframeOk: timeframeOk ?? this.timeframeOk,
      alertMediumOk: alertMediumOk ?? this.alertMediumOk,
      repeatSetpointOk: repeatSetpointOk ?? this.repeatSetpointOk,
      expirationOk: expirationOk ?? this.expirationOk,
      noteError: noteError ?? this.noteError,
      setpointOk: setpointOk ?? this.setpointOk,
      conditionOk: conditionOk ?? this.conditionOk,
    );
  }

  @override
  List<Object> get props => [
        myAlert,
        commodityOk,
        timeframeOk,
        alertMediumOk,
        repeatSetpointOk,
        expirationOk,
        noteError,
        setpointOk,
        conditionOk
      ];
}
