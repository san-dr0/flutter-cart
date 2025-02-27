import 'package:clean_arch2/feature/home/domain/product.domain.dart';
import 'package:hive/hive.dart';
part 'transaction_model.g.dart';

@HiveType(typeId: 3)
class TransactionEntity {
  @HiveField(0)
  String email;
  @HiveField(1)
  DateTime dateTime;
  @HiveField(2)
  List<ProductModel> cartProduct;

  TransactionEntity({
    required this.email,
    required this.dateTime,
    required this.cartProduct
  });
}
