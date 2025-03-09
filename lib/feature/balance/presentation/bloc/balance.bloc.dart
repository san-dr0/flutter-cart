import 'dart:async';
import 'package:clean_arch2/config/db/app_db.dart';
import 'package:clean_arch2/feature/balance/presentation/bloc/balance.event.dart';
import 'package:clean_arch2/feature/balance/presentation/bloc/balance.state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BalanceBloc extends Bloc<BalanceEvent, BalanceState> {
  AppDatabase appDatabase;
  
  BalanceBloc({required this.appDatabase}): super(BalanceOnLoadingState()) {
    on<BalanceOnGetCurrentBalanceEvent>(balanceOnGetCurrentBalanceEvent);
  }

  FutureOr<void> balanceOnGetCurrentBalanceEvent(BalanceOnGetCurrentBalanceEvent event, Emitter<BalanceState> emit) async {
    String email = event.email;
    emit(BalanceOnLoadingState());
    double currentBalance = await appDatabase.getActiveUserCurrentBalance(email);

    emit(BalanceLoadedState(currentBalance: currentBalance));
  }
}
