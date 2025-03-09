import 'package:equatable/equatable.dart';

abstract class BalanceState  extends Equatable {}

class BalanceOnLoadingState extends BalanceState {
  @override
  List<Object?> get props => [];
}

class BalanceLoadedState extends BalanceState {
  double currentBalance = 0.00;

  BalanceLoadedState({required this.currentBalance});
  
  @override
  List<Object?> get props => [
    currentBalance
  ];
}
