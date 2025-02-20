import 'package:clean_arch2/feature/home/domain/product.domain.dart';
import 'package:flutter/material.dart';

abstract class CartEvent {}

class CartOnBuyProductEvent extends CartEvent {
  ProductModel productModel;

  CartOnBuyProductEvent({required this.productModel});
}

class CartOnViewProductListEvent extends CartEvent {
  BuildContext context;

  CartOnViewProductListEvent({required  this.context});
}

class CartOnAmountToPaidEvent extends CartEvent {}
