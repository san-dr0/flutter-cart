import 'package:clean_arch2/config/db/hive_model/product_model/product_model.dart';
import 'package:clean_arch2/feature/home/domain/product.domain.dart';
import 'package:flutter/material.dart';

abstract class HomeProductEvent {}

class HomeOnLoadedEvent extends HomeProductEvent {}
class HomeOnViewCertainProductEvent extends HomeProductEvent {
  BuildContext context;
  ProductEntity productModel;

  HomeOnViewCertainProductEvent({required this.context, required this.productModel});
}