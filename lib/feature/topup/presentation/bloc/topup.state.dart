import 'package:equatable/equatable.dart';

abstract class TopUpBaseState extends Equatable {}

class TopUpState extends TopUpBaseState {
  @override
  List<Object?> get props => [];
}

class TopUpOnLoadingState extends TopUpBaseState {
  @override
  List<Object?> get props => [];
}
class TopUpCurrentBalanceChangedState extends TopUpBaseState {
  @override
  List<Object?> get props => [];
}

class TopUpProceedTransactionState extends TopUpBaseState {
  @override
  List<Object?> get props => [];
}

class TopUpCurrentActiveUserBalanceIsInsufficientState extends TopUpBaseState {

  TopUpCurrentActiveUserBalanceIsInsufficientState();
  @override
  List<Object?> get props => [
  ];
}

class TopUpCurrentActiveUserRunningBalanceState extends TopUpBaseState {
  double currentActiveUserRunningBalance = 0.00;
  String email;

  TopUpCurrentActiveUserRunningBalanceState({required this.currentActiveUserRunningBalance, required this.email});
  
  @override
  List<Object?> get props => [currentActiveUserRunningBalance];
}