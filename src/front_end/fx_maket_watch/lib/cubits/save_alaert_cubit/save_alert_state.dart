part of 'save_alert_cubit.dart';

abstract class SaveAlertState extends Equatable {
  const SaveAlertState();

  @override
  List<Object> get props => [];
}

class SaveAlertInitial extends SaveAlertState {
  @override
  String toString() => "SaveAlertInitialState";
}

class SaveAlertLoading extends SaveAlertState {
  @override
  String toString() {
    return "SaveAlerLoadingState";
  }
}

class SaveAlertFailed extends SaveAlertState {
  final String message;
  const SaveAlertFailed({required this.message});

  @override
  String toString() => 'SaveAlertFailed';
}

class SaveAlertSuccess extends SaveAlertState {
  final Map<String, dynamic> response;
  // final int code;
  const SaveAlertSuccess({required this.response});

  @override
  String toString() => 'SaveAlardSuccessState';
}
