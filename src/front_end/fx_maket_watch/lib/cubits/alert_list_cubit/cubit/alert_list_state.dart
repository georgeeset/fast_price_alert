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
  final List<Map<String, dynamic>> alertList;
  const AlertLoaded({required this.alertList});
  @override
  String toString() => 'PriceAlertLoadedState';
}
