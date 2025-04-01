import 'package:clean_arch2/config/db/hiver_riverpod/hiver_riverpod_model/hive_riverpod_model.dart';
import 'package:hive/hive.dart';
part "txn_riverpod_model.g.dart";

@HiveType(typeId: 9)
class TransactionHistoryRiverpodModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final List<ProductEntryRiverPodModel> cartList;

  TransactionHistoryRiverpodModel({
    required this.id, required this.email, required this.cartList
  });
}
