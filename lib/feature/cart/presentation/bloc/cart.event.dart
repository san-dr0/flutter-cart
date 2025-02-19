import 'package:clean_arch2/feature/home/domain/product.domain.dart';
import 'package:flutter/material.dart';

abstract class CartEvent {}

class CartOnBuyProduct extends CartEvent {
  ProductModel productModel;

  CartOnBuyProduct({required this.productModel});
}

class CartOnViewProduct extends CartEvent {
  BuildContext context;

  CartOnViewProduct({required  this.context});
}
