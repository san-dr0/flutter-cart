import 'dart:developer';

import 'package:clean_arch2/config/db/hiver_riverpod/hiver_riverpod_model/hive_riverpod_model.dart';
import 'package:clean_arch2/config/db/hiver_riverpod/riverpod_db.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
// part "product_riverpod.g.dart";

@riverpod
class ProductPod extends AsyncNotifier<List<ProductEntryRiverPodModel>>{
  
  @override
  Future<List<ProductEntryRiverPodModel>> build() async {
    var productList = await getAllProduct();

    return productList;
  }

  void insertProduct(ProductEntryRiverPodModel productEntryRiverPod) {
    try{
       ref.read(riverpodDbProvider.notifier).addProductItem(productEntryRiverPod);
      // state.add(productEntryRiverPod);
      Fluttertoast.showToast(msg: productAddedTitle, toastLength: Toast.LENGTH_SHORT);
    }
    catch(error) {
      Fluttertoast.showToast(msg: somethingWentWrongTitle, toastLength: Toast.LENGTH_LONG);
    }
  }

  Future<List<ProductEntryRiverPodModel>> getAllProduct() async {
    List<ProductEntryRiverPodModel> productList = await ref.read(riverpodDbProvider.notifier).allProductItem();
    state = AsyncValue.data(productList);

    return Future.value(state.value);
  }
  
  FutureOr<void> updateSpecificProduct(ProductEntryRiverPodModel product) async {
    int response = await ref.read(riverpodDbProvider.notifier).updateSpecificProduct(product);

    if (response > 0) {
      Fluttertoast.showToast(msg: updateProductTitle, toastLength: Toast.LENGTH_LONG);
    }
    else {
      Fluttertoast.showToast(msg: somethingWentWrongTitle, toastLength: Toast.LENGTH_LONG);
    }
  }
}
