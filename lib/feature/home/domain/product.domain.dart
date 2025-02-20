import 'package:clean_arch2/config/db/hive_model/product_model/product_model.dart';
import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final int id;
  final String name;
  int quantity;
  final double price;

  ProductModel({required this.id, required this.name, this.quantity = 0, required this.price});

  factory ProductModel.fromJson(ProductEntity json) {
    return ProductModel(
      id: json.id,
      name: json.name,
      quantity: json.quantity,
      price: json.price
    );
  }
  
  @override
  List<Object?> get props => [name, quantity, price];
}
