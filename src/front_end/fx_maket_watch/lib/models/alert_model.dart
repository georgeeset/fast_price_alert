/// Model for alert data

import "model_constants.dart" as constants;

class PriceAlert {
  final String condition;
  final String commodity;
  final int setpoint;
  final String timeFrame;
  final String alertMedium;
  final int repeatSetpoint;
  final int? expirationInHrs;
  final int? expirationInSecs;
  final int alertId;
  final int? alertCount;
  final int timeCreated;
  final int userId;
  final String note;

  const PriceAlert({
    required this.condition,
    required this.commodity,
    required this.setpoint,
    required this.timeFrame,
    required this.alertMedium,
    required this.repeatSetpoint,
    this.expirationInHrs,
    this.expirationInSecs,
    required this.alertId,
    this.alertCount,
    required this.timeCreated,
    required this.userId,
    required this.note,
  });

  factory PriceAlert.fromJson({required Map<String, dynamic> json}) {
    return PriceAlert(
      condition: json[constants.condition],
      commodity: json[constants.commodity],
      setpoint: json[constants.setpoint],
      timeFrame: json[constants.timeFrame],
      alertMedium: json[constants.alertMedium],
      repeatSetpoint: json[constants.repeatSetpoint],
      expirationInHrs: json[constants.expiration],
      expirationInSecs: json[constants.expiration],
      alertId: json[constants.alertId],
      alertCount: json[constants.alertCount],
      timeCreated: json[constants.timeCreated],
      userId: json[constants.userId],
      note: json[constants.note],
    );
  }

  updateAlert({
    String? condition,
    String? commodity,
    int? setpoint,
    String? timeFrame,
    String? alertMedium,
    int? expirationInHrs,
    int? repeatSetpoint,
    String? note,
  }) {
    return PriceAlert(
      condition: condition ?? this.condition,
      commodity: commodity ?? this.commodity,
      setpoint: setpoint ?? this.setpoint,
      timeFrame: timeFrame ?? this.timeFrame,
      alertMedium: alertMedium ?? this.alertMedium,
      repeatSetpoint: repeatSetpoint ?? this.repeatSetpoint,
      note: note ?? this.note,
      timeCreated: timeCreated,
      alertId: alertId,
      userId: userId,
    );
  }

  toJson({bool forUpdate = false}) {
    Map<String, dynamic> jsonData = {
      constants.condition: condition,
      constants.commodity: commodity,
      constants.setpoint: setpoint,
      constants.timeFrame: timeFrame,
      constants.alertMedium: alertMedium,
      constants.repeatSetpoint: repeatSetpoint,
      constants.note: note,
    };
    if (forUpdate) jsonData.addAll({constants.alertId: alertId});

    return jsonData;
  }
}
