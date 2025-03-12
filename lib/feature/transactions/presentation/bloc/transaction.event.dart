abstract class TransactionEvent {}

class TransactionOnLoadingEvent extends TransactionEvent {}

class TransactionOnLoadedEvent extends TransactionEvent {
  String email;

  TransactionOnLoadedEvent({required this.email});
}

class TransactionOnPayWithQREvent extends TransactionEvent {

  TransactionOnPayWithQREvent();
}

class TransactionProceedPayWithQREvent extends TransactionEvent {
  String qrCodeInfo;

  TransactionProceedPayWithQREvent({required this.qrCodeInfo});
}
