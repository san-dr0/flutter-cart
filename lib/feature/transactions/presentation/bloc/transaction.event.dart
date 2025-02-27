abstract class TransactionEvent {}

class TransactionOnLoadingEvent extends TransactionEvent {}

class TransactionOnLoadedEvent extends TransactionEvent {
  String email;

  TransactionOnLoadedEvent({required this.email});
}
