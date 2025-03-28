import 'dart:developer';

import 'package:clean_arch2/config/db/hiver_riverpod/hiver_riverpod_model/hive_riverpod_model.dart';
import 'package:clean_arch2/feature/riverpod/feature/auth/model/auth.model.dart';
import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part "riverpod_db.g.dart";
/*
  Error codes;
  1) (-1) Error -> Something went wrong
  2) (0) None important -> like just show a toast message / no need to prompt a message;
  3) (1) Important add trappings
 */
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
  
  Future<List<ProductEntryRiverPodModel>> allProductItem() async {
    final riverpodProduct = await Hive.openBox("riverpod-product");

    List<ProductEntryRiverPodModel> productList = [];
    for(var rp in riverpodProduct.values.toList()) {
      ProductEntryRiverPodModel productModel = rp as ProductEntryRiverPodModel;
      
      productList.add(productModel);
    }
    
    return productList;
  }

  FutureOr<int> updateSpecificProduct(ProductEntryRiverPodModel product) async {
    try{
      final riverpodProduct = await Hive.openBox("riverpod-product");
      int index = 0;
      for (ProductEntryRiverPodModel perpm in riverpodProduct.values.toList()) {
        if (perpm.id == product.id) {
          break;
        }
        index ++;
      }
      riverpodProduct.putAt(index, product);
      return 1;
    }
    catch(error) {
      log("Errr >>> ");
      log(error.toString());
      return -1;
    }
  }

  FutureOr<int> signupUser(AuthSignupRiverpodModel signUp) async {
    try{
      var accountBox = await Hive.openBox("riverpod-account");
      accountBox.put(signUp.email, signUp);
      return 0;
    }
    catch(error) {
      return -1;
    }
  }

  FutureOr<double> getCurrentBalance({String email = ""}) async {
    var balanceBox = await Hive.openBox("riverpod-balance");
    double currentBalance = 0.00;
    
    var balanceRepsonse = balanceBox.get(email);
    log('balanceRepsonse >>>> $balanceRepsonse');
    return currentBalance;
  }

  FutureOr<int> updateBalance({String email = "", double newBalance = 0.00}) async {
    try{
      var balanceBox = await Hive.openBox("riverpod-balance");
      balanceBox.put(email, balanceBox);
      
      return 0;
    }
    catch(error) {
      return -1;
    }
  }

  FutureOr<Object?> loginUser({required String email, required String password}) async {
    try{
      var accountBox = await Hive.openBox("riverpod-account");
      var accountResponse = accountBox.get(email);
      log("accountResponse >>> ");
      log(accountResponse.toString());
      return accountResponse;
    }
    catch(error) {
      return -1;
    }
  }
}
