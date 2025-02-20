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

class CartOnRemoveProductEvent extends CartEvent {
  ProductModel productModel;
  CartOnRemoveProductEvent({required this.productModel});
}

class CartOnDeductQuanityEvent extends CartEvent {
  ProductModel productModel;

  CartOnDeductQuanityEvent({required this.productModel});
}

class CartOnAddQuantityEvent extends CartEvent {
  ProductModel productModel;
  CartOnAddQuantityEvent({required this.productModel});
}
