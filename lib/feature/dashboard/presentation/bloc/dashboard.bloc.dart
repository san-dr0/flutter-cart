import 'dart:async';

import 'package:clean_arch2/feature/dashboard/presentation/bloc/dashboard.event.dart';
import 'package:clean_arch2/feature/dashboard/presentation/bloc/dashboard.state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DashBoardBloc extends Bloc<DashBoardEvent, DomainState> {
  DashBoardBloc(): super(DomainAppStartedState()) {

    on<DashBoardOnNavigateToShopEvent>(dashBoardOnNavigateToShopEvent);
    on<DashBoardOnNavigateToTransactionsEvent>(dashBoardOnNavigateToTransactionsEvent);
    on<DashBoardOnNavigateToUpdateCredsEvent>(dashBoardOnNavigateToUpdateCredsEvent);
    on<DashBoardOnNavigateToTopUpEvent>(dashBoardOnNavigateToTopUpEvent);
    on<DashBoardOnNavigateToBarcodePayEvent>(dashBoardOnNavigateToBarcodePayEvent);
  }

  FutureOr<void> dashBoardOnNavigateToShopEvent(DashBoardOnNavigateToShopEvent event, Emitter<DomainState> emit) {
    BuildContext context = event.context;

    context.push("/");
  }

  FutureOr<void> dashBoardOnNavigateToTransactionsEvent(DashBoardOnNavigateToTransactionsEvent event, Emitter<DomainState> emit) {
    BuildContext context = event.context;

    context.push("/transactions");
  }

  FutureOr<void> dashBoardOnNavigateToUpdateCredsEvent(DashBoardOnNavigateToUpdateCredsEvent event, Emitter<DomainState> emit) {
    BuildContext context = event.context;

    context.push("/update-creds");
  }

  FutureOr<void> dashBoardOnNavigateToTopUpEvent(DashBoardOnNavigateToTopUpEvent event, Emitter<DomainState> emit) {
    BuildContext context = event.context;

    context.push("/top-up");
  }
  FutureOr<void> dashBoardOnNavigateToBarcodePayEvent(DashBoardOnNavigateToBarcodePayEvent event, Emitter<DomainState> emit) {
    BuildContext context = event.context;

    context.push("/barcode-pay");
  }
}
