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
    on<TransactionProceedPayWithQREvent>(transactionProceedPayWithQREvent);
  }

  FutureOr<void> transactionOnLoadedEvent(TransactionOnLoadedEvent event, Emitter<TransactionState> emit) async {
    String email = event.email;
    List<TransactionEntity> historicalRecords =  await appDatabase.getTransactionRecordOfCertainUser(email: email);

    emit(TransactionOnLoadedRecordsState(transactionRecords: historicalRecords));
  }

  FutureOr<void> transactionOnPayWithQREvent(TransactionOnPayWithQREvent event, Emitter<TransactionState> emit) {
    // String qrCodeInfo = event.qrCodeInfo;
    // List<String> qrCodeInfoSplittedValues = qrCodeInfo.split(";");
    // double amount = double.parse(qrCodeInfoSplittedValues[0].split("&")[1]);
    // String email = qrCodeInfoSplittedValues[1].split("&")[1];
    // String dateTime = qrCodeInfoSplittedValues[2].split("&")[1];

    // appDatabase.paidTransactionUsingQR(email: email, dateTtime: dateTime, amount: amount);
    emit(TransactionConfirmPayWithQRState());
  }

  FutureOr<void> transactionProceedPayWithQREvent(TransactionProceedPayWithQREvent event, Emitter<TransactionState> emit) {
    String qrCodeInfo = event.qrCodeInfo;
    List<String> qrCodeInfoSplittedValues = qrCodeInfo.split(";");
    double amount = double.parse(qrCodeInfoSplittedValues[0].split("&")[1]);
    String email = qrCodeInfoSplittedValues[1].split("&")[1];
    String dateTime = qrCodeInfoSplittedValues[2].split("&")[1];

    appDatabase.paidTransactionUsingQR(email: email, dateTtime: dateTime, amount: amount);
    emit(TransactionProceedConfirmationPayWithQRState());
  }
}
