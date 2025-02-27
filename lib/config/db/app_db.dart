import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:clean_arch2/config/db/hive_model/product_model/product_model.dart';
import 'package:clean_arch2/config/db/request/request.dart';
import 'package:clean_arch2/feature/auth/domain/auth.domain.dart';
import 'package:clean_arch2/feature/home/domain/product.domain.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDatabase {
  void initBaseRecords() async {
    
    final sharedPref = await SharedPreferences.getInstance();
    String? isInitialized = sharedPref.getString("isInitialized");
    
    if (isInitialized != null) {
      return;
    }

    sharedPref.setString("isInitialized", "has_value");
    
    List<ProductEntity> productList = [
      ProductEntity(id: 1, name: "Cheese Ring", quantity: 10, price: 5.0),
      ProductEntity(id: 2, name: "Fita", quantity: 7, price: 8.0),
      ProductEntity(id: 3, name: "Hansel", quantity: 10, price: 8.0),
      ProductEntity(id: 4, name: "Cream-0", quantity: 12, price: 6.0),
      ProductEntity(id: 5, name: "Barnuts", quantity: 33, price: 5.0),
      ProductEntity(id: 6, name: "Snow Bear", quantity: 5, price: 3.0),
      ProductEntity(id: 7, name: "Happy", quantity: 22, price: 3.0),
    ];
    Box b = await Hive.openBox("product");
    
    for(ProductEntity pe in productList) {
      b.add(pe);
    }
  }

  FutureOr<List<ProductModel>> getProductRecord () async {
    Box box = await Hive.openBox("product");
    
    List<ProductModel> productList = [];
    for(final pe in box.values.toList()) {
      productList.add(ProductModel.fromJson(pe));
    }
    return  productList;
  }

  FutureOr<int> addUser(Map<String, dynamic> addUser) async {
    try{
      Box box = await Hive.openBox("account");
      int isSuccess = 1;

      // insert if no records at first;
      if (box.values.isEmpty) {
        box.add(addUser);
        return isSuccess;
      }
      
      bool isFound = false;
      for(final b in box.values.toList()) {
        if (b['email'] == addUser['email']) {
          isFound = true;
          break;
        }
      }

      isSuccess = 0;
      // user exists
      if (isFound) {
        isSuccess = 0;
      }
      // means no user found; and insert it to DB
      else {
        isSuccess = 1;
        box.add(addUser);
      }

      return isSuccess;
    }
    catch(error) {
      return 0;
    }
  }

  FutureOr<Request<AuthCredentialsModel>?> validateUserCredentials({String email = "", String password = ""}) async {
    try{
      Box box = await Hive.openBox("account");
      final result = box.values.where((creds) => creds['email'] == email && creds['password'] == password).toList();
      
      if (result.isEmpty) {
        return Request(code: 401, message: "User not found", data: null);
      }
      
      AuthCredentialsModel authCredentialsModel = AuthCredentialsModel(
        firstName: result[0]['firstName'], 
        middleName: result[0]['middleName'], 
        lastName: result[0]['lastName'], 
        email: email
      );
      return Request(code: 200, message: "User found", data: authCredentialsModel);
    }
    catch(error) {
      log('Err >> ');
      log(error.toString());
      return Request(code: 500, message: "Something went wrong", data: null);
    }
  }

  FutureOr<int> saveCartRecordPerUser(String email, List<ProductModel> cartList) async {
    try{
      final cartBox = await Hive.openBox("cart");

      // DateTime dateTime = DateTime.now();
      Map<String, dynamic> record = {
        "userKey": email,
        "record": cartList.toString()
      };
      
      cartBox.add(record.toString());
      return 1;
    }
    catch(error) {
      log('Err---');
      log(error.toString());
      return 0;
    }
  }

  FutureOr<void> getTransactionRecord(String email) async {
    Box cartBox = await Hive.openBox('cart');
    log('Tests >>> ');
    final txtRecords = cartBox.values.toList();
    Map<String, dynamic> rec = {};

    log(rec.runtimeType.toString());
    for(var txtR in txtRecords) {
      log(txtR);
    }
  }
}
