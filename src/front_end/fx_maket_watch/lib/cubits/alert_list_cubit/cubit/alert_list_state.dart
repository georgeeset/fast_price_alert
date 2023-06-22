part of 'alert_list_cubit.dart';

abstract class PriceAlertListState extends Equatable {
  const PriceAlertListState();

  @override
  List<Object> get props => [];
}

class AlertListInitial extends PriceAlertListState {
  @override
  String toString() => 'P)riceAlertListInitialstate';
}

class AlertLoading extends PriceAlertListState {
  @override
  String toString() {
    return 'PriceAlertLoadingState';
  }
}

class AlertLoaded extends PriceAlertListState {
  final List<PriceAlert> alertList;
  const AlertLoaded({required this.alertList});

  @override
  List<Object> get props => [alertList];

  @override
  String toString() => 'PriceAlertLoadedState';
}

class AlertLoadingError extends PriceAlertListState {
  final String message;
  const AlertLoadingError({required this.message});

  @override
  String toString() => 'AlertLoadingErrorState';
}

class AlertEmpty extends PriceAlertListState {
  @override
  String toString() => 'AlertEmptyState';
}
