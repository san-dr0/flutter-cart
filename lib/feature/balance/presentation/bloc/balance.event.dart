abstract class BalanceEvent {}

class BalanceOnGetCurrentBalanceEvent extends BalanceEvent {
  String email;

  BalanceOnGetCurrentBalanceEvent({required this.email});
}
