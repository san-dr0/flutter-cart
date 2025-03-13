abstract class TopUpEvent {

}
class TopUpOnTopUpNewBalanceEvent extends TopUpEvent {
  

  TopUpOnTopUpNewBalanceEvent();
}

class TopUpOnProceedTransactionEvent extends TopUpEvent {
  double topUpValue = 0.00;
  String email;

  TopUpOnProceedTransactionEvent({required this.topUpValue, required this.email});
}

class TopUpCheckCurrentActiveUserCurrentBalanceEvent extends TopUpEvent {}
