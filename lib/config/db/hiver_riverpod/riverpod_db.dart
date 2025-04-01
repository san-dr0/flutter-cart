import 'dart:developer';

import 'package:clean_arch2/config/db/hiver_riverpod/hiver_riverpod_model/hive_riverpod_model.dart';
import 'package:clean_arch2/config/db/hiver_riverpod/hiver_riverpod_model/txn_riverpod_model.dart';
import 'package:clean_arch2/feature/riverpod-feature/feature/auth/model/auth.signup.riverpod.model.dart';
import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
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
      var credList = accountBox.values.toList();
      bool isCredExist = false;
      for(var asr in credList) {
        if (asr.email == signUp.email) {
          isCredExist = true;
          break;
        }
      }

      if (isCredExist) {
        return 1;
      }

      accountBox.put(signUp.email, signUp);
      return 0;
    }
    catch(error) {
      log("Errr >>> ");
      log(error.toString());
      return -1;
    }
  }

  FutureOr<double?> getCurrentBalance({String email = ""}) async {
    try{
      var balanceBox = await Hive.openBox("riverpod-balance");      
      var balanceRepsonse = balanceBox.get(email);

      if (balanceRepsonse == null) {
        return 0.00;
      }
      var currentBalance = balanceRepsonse;

      return currentBalance;
    }
    catch(error) {
      return 0.00;
    }
  }

  FutureOr<double?> updateBalance({String email = "", double newBalance = 0.00}) async {
    try{
      var balanceBox = await Hive.openBox("riverpod-balance");
      var currBalance = balanceBox.get(email);
      double updatedBalance = 0.00;
      
      if (currBalance == null) {
        balanceBox.put(email, newBalance);
      }
      else {
        updatedBalance = double.parse(currBalance.toString()) + newBalance;
        balanceBox.put(email, updatedBalance);
      }
      
      return updatedBalance;
    }
    catch(error) {
      log("Errororo --- >>> ");
      log(error.toString());
      return null;
    }
  }

  FutureOr<Object?> loginUser({required String email, required String password}) async {
    try{
      var accountBox = await Hive.openBox("riverpod-account");
      var accountResponse = accountBox.get(email);
      
      return accountResponse;
    }
    catch(error) {
      return null;
    }
  }
  
  FutureOr<int?> addCartTransactionList({required List<ProductEntryRiverPodModel> cartList, required  String email}) async {
    try{
      var txnBox = await Hive.openBox("riverpod-txnHistory");
      TransactionHistoryRiverpodModel txnRecord = TransactionHistoryRiverpodModel(
        id: Uuid().v1(), email: email, cartList: cartList
      );
      txnBox.add(txnRecord);

      return 0;
    }
    catch(error) {
      return -1;
    }
  }

  FutureOr<List<TransactionHistoryRiverpodModel>> getTransactionHistory({required String email})  async {
    try{
      var txnBox = await Hive.openBox("riverpod-txnHistory");
      List<TransactionHistoryRiverpodModel> transctionRecords = [];
      
      for(TransactionHistoryRiverpodModel tr in txnBox.values.toList()) {
        if (tr.email == email) {
          transctionRecords.add(TransactionHistoryRiverpodModel.fromJson(tr));
        }
      }
      
      return transctionRecords;
    }
    catch(error) {
      return [];
    }
  }
}
