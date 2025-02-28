import 'package:clean_arch2/config/db/hive_model/transaction_model/transaction_model.dart';
import 'package:equatable/equatable.dart';

abstract class TransactionState extends Equatable {

}

class TransactionOnLoadingState extends TransactionState {
  @override
  List<Object?> get props => [];
}

class TransactionOnLoadedRecordsState extends TransactionState {
  List<TransactionEntity> transactionRecords = [];

  TransactionOnLoadedRecordsState({required this.transactionRecords});
    
  @override
  List<Object?> get props => [
    transactionRecords
  ];

}
