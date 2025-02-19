// import 'package:clean_arch2/config/db/hive_model/product_model/product_model.dart';
import 'package:clean_arch2/feature/home/domain/product.domain.dart';
import 'package:equatable/equatable.dart';

abstract class HomeProductState extends Equatable {}

class HomeProductLoadingState extends HomeProductState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class HomeProductOnLoadedState extends HomeProductState {
  List<ProductModel> productList = [];

  HomeProductOnLoadedState({required this.productList});
  
  @override
  // TODO: implement props
  List<Object?> get props => [productList];
}
