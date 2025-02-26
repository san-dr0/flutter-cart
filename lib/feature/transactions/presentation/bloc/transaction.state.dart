import 'package:equatable/equatable.dart';

abstract class TransactionState extends Equatable {

}

class TransactionStateOnLoadingState extends TransactionState {
  @override
  List<Object?> get props => [];
}
