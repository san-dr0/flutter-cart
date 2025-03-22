import 'dart:developer';

import 'package:clean_arch2/config/db/hiver_riverpod/hiver_riverpod_model/hive_riverpod_model.dart';
import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part "riverpod_db.g.dart";

@riverpod
class RiverpodDb extends _$RiverpodDb{
  
  @override
  void build() {
    
  }

  FutureOr<int> addProductItem(ProductEntryRiverPodModel productItem) async {
    try{
      final product = await Hive.openBox("riverpod-product");
      product.add(productItem);

      return 1;
    }
    catch(error) {
      return 0;
    }
  }
  FutureOr<List<ProductEntryRiverPodModel>> allProductItem() async{
    final riverpodProduct = await Hive.openBox("riverpod-product");

    List<ProductEntryRiverPodModel> productList = [];
    for(var rp in riverpodProduct.values.toList()) {
      ProductEntryRiverPodModel productModel = rp as ProductEntryRiverPodModel;
      log("Name ::: ${productModel.name}");
      
      productList.add(productModel);
    }
    
    return productList;
  }
}
