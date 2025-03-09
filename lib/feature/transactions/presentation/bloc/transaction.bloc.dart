import 'dart:async';
import 'dart:developer';

import 'package:clean_arch2/config/db/app_db.dart';
import 'package:clean_arch2/config/db/hive_model/transaction_model/transaction_model.dart';
import 'package:clean_arch2/feature/transactions/presentation/bloc/transaction.event.dart';
import 'package:clean_arch2/feature/transactions/presentation/bloc/transaction.state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  AppDatabase appDatabase;
  TransactionBloc({required this.appDatabase}): super(TransactionOnLoadingState()) {
    on<TransactionOnLoadedEvent>(transactionOnLoadedEvent);
    on<TransactionOnPayWithQREvent>(transactionOnPayWithQREvent);
  }

  FutureOr<void> transactionOnLoadedEvent(TransactionOnLoadedEvent event, Emitter<TransactionState> emit) async {
    String email = event.email;
    List<TransactionEntity> historicalRecords =  await appDatabase.getTransactionRecordOfCertainUser(email: email);

    emit(TransactionOnLoadedRecordsState(transactionRecords: historicalRecords));
  }

  FutureOr<void> transactionOnPayWithQREvent(TransactionOnPayWithQREvent event, Emitter<TransactionState> emit) {
    String qrCodeInfo = event.qrCodeInfo;

    log("QR code --- $qrCodeInfo");
  }
}
