import 'dart:developer';

import 'package:clean_arch2/config/db/hiver_riverpod/hiver_riverpod_model/hive_riverpod_model.dart';
import 'package:clean_arch2/config/db/hiver_riverpod/hiver_riverpod_model/txn_riverpod_model.dart';
import 'package:clean_arch2/feature/riverpod-feature/feature/auth/model/auth.signup.riverpod.model.dart';
import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../feature/riverpod-feature/feature/auth/model/signup/signup.model.dart';
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
    try{
      // final riverpodProduct = await Hive.openBox("riverpod-product");

      // for(var rp in riverpodProduct.values.toList()) {
      //   ProductEntryRiverPodModel productModel = rp as ProductEntryRiverPodModel;
        
      //   productList.add(productModel);
      // }
      List<ProductEntryRiverPodModel> productList = [];
      final supabase = Supabase.instance.client;
      final product = await supabase.from('products').select('''id, name, price, quantity''');
      
      for(var p in product) {
        int id = p['id'];
        String name = p['name'];
        double price = (p['price'] as num).toDouble();
        int quantity = p['quantity'];
        productList.add(ProductEntryRiverPodModel(id: id.toString(), name: name, price: price, quantity: quantity));
        // productList.add(ProductEntryRiverPodModel.fromJson(p));
      }
      return productList;
    }
    catch(error) {
      log('Error');
      log(error.toString());

      return [];
    }
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

  FutureOr<String?> getCurrentBalance({String email = ""}) async {
    try{
      // var balanceBox = await Hive.openBox("riverpod-balance");      
      // var balanceRepsonse = balanceBox.get(email);

      // if (balanceRepsonse == null) {
      //   return 0.00;
      // }
      // var currentBalance = balanceRepsonse;

      // return currentBalance;
      // END of Riverpod and Hive implementation

      final instance = Supabase.instance.client;
      final resp = await instance.auth
        .signInWithPassword(email: 'lisandro.batiancila@gmail.com', password: 'p4ssW0rd');

      final response = await instance.from("balances")
        .select("running_balance")
        .eq("email", email)
        .eq("user_id", resp.user!.id);
      
      if (response.isNotEmpty) {
        return response[0]['running_balance'].toString();
      }
      return "0.00";
    }
    catch(error) {
      log("Errr >>> getCurrentBalance");
      log(error.toString());
      return "0.00";
    }
  }

  FutureOr<String?> updateBalance({String email = "",
   double currentRunningBalance = 0.00, double newBalance = 0.00}) async {
    try{
      // var balanceBox = await Hive.openBox("riverpod-balance");
      // var currBalance = balanceBox.get(email);
      // String updatedBalance = "0.00";
      
      // if (currBalance == null) {
      //   balanceBox.put(email, newBalance);
      // }
      // else {
      //   updatedBalance = (double.parse(currBalance.toString()) + newBalance).toString();
      //   balanceBox.put(email, updatedBalance);
      // }
      
      // return updatedBalance;
      // END of Riverpod and Hive implementation

      final instance = Supabase.instance.client;
      await instance.from("balances")
        .update({
          "running_balance": (currentRunningBalance + newBalance)
        })
        .eq("email", email);
      
      return (currentRunningBalance + newBalance).toString();
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

  // SUPABASE
  FutureOr<int> supaRegisterNewUser(SupaUserModel user) async {
    // 0 user already exists
    // 1 success
    // - fail
    try{
      final instance = Supabase.instance.client;
      final signUpResponse = await instance.auth.signUp(
        email: user.email,
        password: user.password);

      final response = await instance.from("users").insert([{
        "firstname": user.firstname,
        "lastname": user.lastname,
        "email": user.email,
        "password": user.password,
        "user_type": "user"
      }]).select();

      if (response.isNotEmpty) {
        supaDefaultUserCurrentRunningBalance(response[0]['id'], user.email, signUpResponse.user!.id);
        return 1;
      }
      return 0;
    }
    catch(error) {
      log("Errr ---- supaRegisterNewUser");
      log(error.toString());
      return -1;
    }
  }

  FutureOr<SupaUserModelRetrieve?> supaLoginUser(SupaLoginUser user) async {
    try{
      final instance = Supabase.instance.client;
      final response = await instance.from("users")
      .select("id, firstname, lastname, email, password, user_type")
      .eq("email", user.email)
      .eq("password", user.password);
      
      if (response.isNotEmpty) {
        return SupaUserModelRetrieve.fromJson(response[0]);
      }
     
      return null;
    }
    catch(error) {
      log("Errr ---- Login");
      log(error.toString());
      return null;
    }
  }

  FutureOr<void> supaDefaultUserCurrentRunningBalance(int userId, String email, String userUuid) async {
    try{
      final instance = Supabase.instance.client;
      await instance.from("balances").insert({
        "user_id": userUuid,
        "email": email,
        "running_balance": 0.00
      });
    }
    catch(error) {
      log("Errr ---- supaDefaultUserCurrentRunningBalance");
      log(error.toString());
      return null;
    }
  }

  FutureOr<SupaUserModelRetrieve?> supaAdminLogin(SupaLoginUser user) async {
    try{
      final instance = Supabase.instance.client;
      final response = await instance.auth.signInWithPassword(email: user.email, password: user.password);
      
      if (response.user != null) {
        final userResponse = await instance.from("users")
        .select("id, firstname, lastname, email, password")
        .eq("email", user.email)
        .eq("password", user.password);

        if (userResponse.isNotEmpty) {
          return SupaUserModelRetrieve.fromJson(userResponse[0]);
        }
      }
    }
    catch(error) {
      log("Errr ---- supaAdminLogin");
      log(error.toString());
      return null;
    }
  }

  FutureOr<int?> supaAdminSignup(SupaUserModel user) async{
    // the ADMIN is the MLhuillier Credentials
    try{
      final instance = Supabase.instance.client;
      await instance.auth.signUp(email: 'lisandro.batiancila@mlhuillier.com', password: "p4ssw0rd_00");

      await instance.from("users").insert([{
        "email": user.email,
        "password": user.password,
        "firstname": user.firstname,
        "lastname": user.lastname,
        "user_type": 'admin'
      }]);

      return 1;
    }
    catch(error) {
      log('Errror ---- supaAdminSignup');
      log(error.toString());

      return 0;
    }   
  }

  FutureOr<void> supaAdminInsertProduct(ProductEntryRiverPodModel product, SupaLoginUser user) async {
    try{
      SupabaseClient instance = Supabase.instance.client;
      AuthResponse adminId = await instance.auth.signInWithPassword(
        email: user.email,
        password: user.password
      );
      log("supaAdminInsertProduct >>>> ---- ");
      log(adminId.toString());
      // await instance.from("products").insert({
      //   "name": product.name,
      //   "price": product.price,
      //   "quantity": product.quantity,
      //   // "admin_id": adminId.user.
      // });
      
    }
    catch(error) {
      log('Errorrrrrr --- supaAdminInsertProduct');
    }
  }
}
