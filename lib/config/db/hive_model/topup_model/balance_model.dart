import 'package:hive_flutter/hive_flutter.dart';
part 'balance_model.g.dart';

@HiveType(typeId: 5)
class BalanceEntity {
  @HiveField(0)
  String id;
  @HiveField(1)
  String email;
  @HiveField(2)
  double currentBalance;

  BalanceEntity({
    required this.id, required this.email, required this.currentBalance
  });
}
