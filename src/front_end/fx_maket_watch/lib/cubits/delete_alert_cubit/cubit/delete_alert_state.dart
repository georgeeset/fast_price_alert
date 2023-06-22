part of 'delete_alert_cubit.dart';

abstract class DeleteAlertState extends Equatable {
  const DeleteAlertState();

  @override
  List<Object> get props => [];
}

class DeleteAlertInitial extends DeleteAlertState {
  @override
  String toString() => 'DeleteAlertInitialState';
}

class DeleteLoading extends DeleteAlertState {
  @override
  String toString() => 'DeletingAlertState';
}

class AlertDeleted extends DeleteAlertState {
  const AlertDeleted({required this.message});
  final String message;
  @override
  String toString() => 'AlertDeletedState';
}

class DeleteFailed extends DeleteAlertState {
  const DeleteFailed({required this.message});
  final String message;
  @override
  String toString() => "DeleteFailed";
}
