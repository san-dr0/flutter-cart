import 'package:clean_arch2/feature/home/domain/product.domain.dart';
import 'package:flutter/material.dart';

abstract class CartEvent {}

// this event is buying for product
class CartOnBuyProductEvent extends CartEvent {
  ProductModel productModel;

  CartOnBuyProductEvent({required this.productModel});
}

// this event is viewing all cart product
class CartOnViewProductListEvent extends CartEvent {
  BuildContext context;

  CartOnViewProductListEvent({required  this.context});
}

// this event is for getting to be paid of cart product
class CartOnAmountToPaidEvent extends CartEvent {}

// this event is removing certain product in cart list
class CartOnRemoveProductEvent extends CartEvent {
  ProductModel productModel;
  CartOnRemoveProductEvent({required this.productModel});
}

// this event is for removing one quantity each time for certain product
class CartOnDeductQuanityEvent extends CartEvent {
  ProductModel productModel;

  CartOnDeductQuanityEvent({required this.productModel});
}

// this event is for adding one quantity each time for certain product
class CartOnAddQuantityEvent extends CartEvent {
  ProductModel productModel;
  CartOnAddQuantityEvent({required this.productModel});
}

class CartOnCheckOutEvent extends CartEvent {
  BuildContext context;
  
  CartOnCheckOutEvent({required this.context});
}

class CartOnResetProductListEvent extends CartEvent {}
