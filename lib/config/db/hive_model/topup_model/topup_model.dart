import 'package:hive_flutter/hive_flutter.dart';
part 'topup_model.g.dart';

@HiveType(typeId: 4)
class TopupEnity {
  @HiveField(0)
  int id;
  @HiveField(1)
  String email;
  @HiveField(2)
  double currentBalance;

  TopupEnity({
    required this.id, required this.email, required this.currentBalance
  });
}
