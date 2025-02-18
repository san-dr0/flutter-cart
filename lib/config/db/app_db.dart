import 'dart:developer';
import 'dart:io';

import 'package:clean_arch2/config/db/hive_model/product_model/product_model.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDatabase {
  void initBaseRecords() async {
    
    final sharedPref = await SharedPreferences.getInstance();
    String? isInitialized = sharedPref.getString("isInitialized");
    
    if (isInitialized == null) {
      return;
    }
    
    // List<ProductEntity> productList = [
    //   ProductEntity(name: "Hansel", quantity: 10, price: 5.0),
    //   ProductEntity(name: "Fita", quantity: 7, price: 8.0),
    //   ProductEntity(name: "Hansel", quantity: 10, price: 8.0),
    //   ProductEntity(name: "Cream-0", quantity: 12, price: 6.0),
    //   ProductEntity(name: "Barnuts", quantity: 33, price: 5.0),
    //   ProductEntity(name: "Snow Bear", quantity: 5, price: 3.0),
    //   ProductEntity(name: "Happy", quantity: 22, price: 3.0),
    // ];

    // hiveEcommerce.put("product", productList);
  }
}
