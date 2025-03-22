import 'package:hive/hive.dart';
part "hive_riverpod_model.g.dart";

@HiveType(typeId: 6)
class ProductEntryRiverPodModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final double price;
  @HiveField(3)
  final int quantity;

  ProductEntryRiverPodModel({
    required this.id, required this.name, required this.price, required this.quantity
  });
}
