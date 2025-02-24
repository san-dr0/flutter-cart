import 'package:hive/hive.dart';

@HiveType(typeId: 3)
class TransactionModel {
  @HiveField(0)
  String txtId;
  @HiveField(1)
  String productName;
  @HiveField(2)
  double price;
  @HiveField(3)
  int quantity;
  @HiveField(4)
  DateTime date;

  TransactionModel({
    required this.txtId, 
    required this.productName,
    required this.price, 
    required this.quantity,
    required this.date
  });
}
