import 'package:hive_flutter/hive_flutter.dart';
part "balance_riverpod_model.g.dart";

@HiveType(typeId: 9)
class BalanceRiverpodModel {
  @HiveField(0)
  final double currentBalance;

  BalanceRiverpodModel({
    required this.currentBalance
  });
}
