import 'dart:async';

import 'package:clean_arch2/config/db/app_db.dart';
import 'package:clean_arch2/feature/transactions/presentation/bloc/transaction.event.dart';
import 'package:clean_arch2/feature/transactions/presentation/bloc/transaction.state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  AppDatabase appDatabase;
  TransactionBloc({required this.appDatabase}): super(TransactionStateOnLoadingState()) {
    on<TransactionOnLoadedEvent>(transactionOnLoadedEvent);
  }

  FutureOr<void> transactionOnLoadedEvent(TransactionOnLoadedEvent event, Emitter<TransactionState> emit) {
    appDatabase.getTransactionRecord('ada.ada@gmail.com');
  }
}
