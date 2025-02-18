import 'package:hive/hive.dart';
part 'product_model.g.dart';

@HiveType(typeId: 1)
class ProductEntity {
  ProductEntity({required this.name, required this.quantity, required this.price});

  @HiveField(0)
  String name;

  @HiveField(1)
  int quantity;
  
  @HiveField(2)
  double price;

  @override
  String toString() {
    return "Name: $name, Qty: $quantity, Price: $price";
  }
}
