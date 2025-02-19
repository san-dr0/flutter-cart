import 'dart:async';

import 'package:clean_arch2/feature/cart/presentation/bloc/cart.event.dart';
import 'package:clean_arch2/feature/cart/presentation/bloc/cart.state.dart';
import 'package:clean_arch2/feature/home/domain/product.domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc(): super(CartOnLoadedState()) {

    on<CartOnBuyProduct>(cartOnBuyProduct);
  }

  FutureOr<void> cartOnBuyProduct(CartOnBuyProduct event, Emitter<CartState> emit) {
    ProductModel productModel = event.productModel;
    
    List<ProductModel> cartList = state is CartProductState? (state as CartProductState).productList : [] ;
    bool isFound = false;

    ProductModel? index = cartList.where((item) => item.id == productModel.id).first;

    for(ProductModel pm in cartList) {
      if (pm.id == productModel.id) {
        pm.quantity = pm.quantity + 1;
        isFound = true;
        break;
      }
    }

    if (!isFound) {
      cartList.add(productModel);
    }
    
    emit(CartOnLoadedState());
    emit(CartProductState(productList: cartList));
  }
}