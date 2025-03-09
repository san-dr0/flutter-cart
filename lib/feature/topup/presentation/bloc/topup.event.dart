abstract class TopUpEvent {

}

class TopUpOnTopUpNewBalanceEvent extends TopUpEvent {
  double topUpValue = 0.00;
  String email;

  TopUpOnTopUpNewBalanceEvent({required this.topUpValue, required this.email});
}
