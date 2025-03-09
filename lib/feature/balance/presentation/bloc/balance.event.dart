abstract class BalanceEvent {}

class BalanceOnGetCurrentBalanceEvent extends BalanceEvent {
  String email;

  BalanceOnGetCurrentBalanceEvent({required this.email});
}

class BalanceOnChangedCurrentBalanceEvent extends BalanceEvent {
  double currentNewBalance = 0.00;

  BalanceOnChangedCurrentBalanceEvent({required this.currentNewBalance});
}
