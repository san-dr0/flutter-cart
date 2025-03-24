import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part "hive_riverpod_model.g.dart";

@HiveType(typeId: 6)
class ProductEntryRiverPodModel extends Equatable{
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

  ProductEntryRiverPodModel copyWith({String name = "", double price = 0.00, int quantity = 0}) {
    return ProductEntryRiverPodModel(id: id, name: name, price: price, quantity: quantity);
  }
  
  @override
  // TODO: implement props
  List<Object?> get props => [id, name, price, quantity];
}
