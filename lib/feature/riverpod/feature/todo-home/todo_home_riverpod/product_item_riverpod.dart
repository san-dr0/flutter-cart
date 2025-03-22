import 'package:clean_arch2/feature/riverpod/feature/todo-home/model/todoModel.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'product_item_riverpod.g.dart';

@riverpod
class ProductListPod extends _$ProductListPod {
  List<ProductItem> productList = [];

  @override
  List<ProductItem> build () {
    return productList;
  }
  
  void addProduct(ProductItem productItem) {
    state = [...state, productItem];
  }

  void deleteProduct(ProductItem productItem) {
    state = state.where((ProductItem item) => item.id != productItem.id).toList();
  }
}
