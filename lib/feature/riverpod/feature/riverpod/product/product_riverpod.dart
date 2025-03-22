import 'package:clean_arch2/config/db/hiver_riverpod/hiver_riverpod_model/hive_riverpod_model.dart';
import 'package:clean_arch2/config/db/hiver_riverpod/riverpod_db.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part "product_riverpod.g.dart";

@riverpod
class ProductPod extends _$ProductPod{  
  @override
  List<ProductEntryRiverPodModel> build() {
    return [];
  }

  void insertProduct(ProductEntryRiverPodModel productEntryRiverPod) {
    try{
      ref.read(riverpodDbProvider.notifier).addProductItem(productEntryRiverPod);
      Fluttertoast.showToast(msg: productAddedTitle, toastLength: Toast.LENGTH_SHORT);
    }
    catch(error) {
      Fluttertoast.showToast(msg: somethingWentWrongTitle, toastLength: Toast.LENGTH_LONG);
    }
  }

  FutureOr<List<ProductEntryRiverPodModel>> getAllProduct() async {
    List<ProductEntryRiverPodModel> productList = await ref.watch(riverpodDbProvider.notifier).allProductItem(); 

    return productList;
  }
}
