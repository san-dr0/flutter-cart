import 'dart:async';
import 'dart:developer';

import 'package:clean_arch2/config/db/app_db.dart';
import 'package:clean_arch2/feature/topup/presentation/bloc/topup.event.dart';
import 'package:clean_arch2/feature/topup/presentation/bloc/topup.state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopUpBloc extends Bloc<TopUpEvent, TopUpBaseState> {
  AppDatabase appDatabase;
  TopUpBloc({required this.appDatabase}): super(TopUpState()) {
    on<TopUpOnTopUpNewBalanceEvent>(topUpOnTopUpNewBalanceEvent);
    on<TopUpOnProceedTransactionEvent>(topUpOnProceedTransactionEvent);
    on<TopUpCheckCurrentActiveUserCurrentBalanceEvent>(topUpCheckCurrentActiveUserCurrentBalanceEvent);
  }
  
  FutureOr<void> topUpOnTopUpNewBalanceEvent(TopUpOnTopUpNewBalanceEvent event, Emitter<TopUpBaseState> emit) {
    emit(TopUpState());
    emit(TopUpCurrentBalanceChangedState());
  }

  FutureOr<void> topUpOnProceedTransactionEvent(TopUpOnProceedTransactionEvent event, Emitter<TopUpBaseState> emit) {
    double topUpValue = event.topUpValue;
    String email = event.email;
    
    appDatabase.updateCurrentBalance(email, topUpValue);
    emit(TopUpProceedTransactionState());
  }
  
  FutureOr<void> topUpCheckCurrentActiveUserCurrentBalanceEvent(TopUpCheckCurrentActiveUserCurrentBalanceEvent event, Emitter<TopUpBaseState> emit) async{
    String email = event.email;
    double runningBalance = await appDatabase.getActiveUserCurrentBalance(email);

    emit(TopUpOnLoadingState());
    if (runningBalance > 0) {
      emit(TopUpCurrentActiveUserRunningBalanceState(currentActiveUserRunningBalance: runningBalance, email: email));
    }
    else {
      emit(TopUpCurrentActiveUserBalanceIsInsufficientState());
    }
  }
}
