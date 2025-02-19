import 'package:clean_arch2/feature/home/domain/product.domain.dart';
import 'package:equatable/equatable.dart';

abstract class CartState extends Equatable {}

class CartOnLoadedState extends CartState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CartProductState extends CartState {
  List<ProductModel> productList = [];
  
  CartProductState({required this.productList});
  
  @override
  List<Object?> get props => [productList]; 
}
