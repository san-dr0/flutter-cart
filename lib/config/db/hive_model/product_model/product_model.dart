import 'package:hive/hive.dart';
part 'product_model.g.dart';

@HiveType(typeId: 1)
class ProductEntity {
  ProductEntity({required this.id, required this.name, required this.quantity, required this.price});

  @HiveField(0)
  int id;
  @HiveField(1)
  String name;

  @HiveField(2)
  int quantity;
  
  @HiveField(3)
  double price;

  @override
  String toString() {
    return "Name: $name, Qty: $quantity, Price: $price";
  }
}
