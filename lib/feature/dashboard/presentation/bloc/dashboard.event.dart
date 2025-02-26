import 'package:flutter/material.dart';

class DashBoardEvent {}

class DashBoardOnNavigateToShopEvent extends DashBoardEvent {
  BuildContext context;

  DashBoardOnNavigateToShopEvent({required this.context});
}

class DashBoardOnNavigateToTransactionsEvent extends DashBoardEvent {
  BuildContext context;

  DashBoardOnNavigateToTransactionsEvent({required this.context});
}

class DashBoardOnNavigateToSettingsEvent extends DashBoardEvent {}
