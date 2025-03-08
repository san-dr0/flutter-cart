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

class DashBoardOnNavigateToUpdateCredsEvent extends DashBoardEvent {
  BuildContext context;

  DashBoardOnNavigateToUpdateCredsEvent({required this.context});
}

class DashBoardOnNavigateToTopUpEvent extends DashBoardEvent {
  BuildContext context;

  DashBoardOnNavigateToTopUpEvent({required this.context});
}

class DashBoardOnNavigateToBarcodePayEvent extends DashBoardEvent {
  BuildContext context;

  DashBoardOnNavigateToBarcodePayEvent({required this.context});
}
