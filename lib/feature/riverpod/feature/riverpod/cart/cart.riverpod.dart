import 'package:clean_arch2/config/db/hiver_riverpod/hiver_riverpod_model/hive_riverpod_model.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "cart.riverpod.g.dart";

@riverpod
class CartRiverPod extends _$CartRiverPod{

  @override
  List<ProductEntryRiverPodModel> build() {
    return [];
  }

  FutureOr<void> addToCart(ProductEntryRiverPodModel product) {
    var rec = state.where((rec) => rec.id == product.id).toList();

    if (rec.isNotEmpty) {
      rec[0].quantity = rec[0].quantity + 1;
    }
    else {
      state = [
        ...state, 
        ProductEntryRiverPodModel(id: product.id, name: product.name, price: product.price, quantity: 1)
      ];
    }

    Fluttertoast.showToast(msg: productAddedToCartTitle, toastLength: Toast.LENGTH_SHORT);
  }
  FutureOr<void> removeProductFromCart(ProductEntryRiverPodModel product) {
    state.remove(product);
  }
}
