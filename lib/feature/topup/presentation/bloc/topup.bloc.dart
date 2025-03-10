import 'dart:async';

import 'package:clean_arch2/config/db/app_db.dart';
import 'package:clean_arch2/feature/topup/presentation/bloc/topup.event.dart';
import 'package:clean_arch2/feature/topup/presentation/bloc/topup.state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopUpBloc extends Bloc<TopUpEvent, TopUpBaseState> {
  AppDatabase appDatabase;
  TopUpBloc({required this.appDatabase}): super(TopUpState()) {
    on<TopUpOnTopUpNewBalanceEvent>(topUpOnTopUpNewBalanceEvent);
  }
  
  FutureOr<void> topUpOnTopUpNewBalanceEvent(TopUpOnTopUpNewBalanceEvent event, Emitter<TopUpBaseState> emit) {
    double topUpValue = event.topUpValue;
    String email = event.email;
    
    appDatabase.updateCurrentBalance(email, topUpValue);
    emit(TopUpState());
    emit(TopUpCurrentBalanceChangedState());
  }
}
