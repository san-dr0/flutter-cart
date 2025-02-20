import 'dart:async';

import 'package:clean_arch2/config/db/hive_model/product_model/product_model.dart';
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


}
