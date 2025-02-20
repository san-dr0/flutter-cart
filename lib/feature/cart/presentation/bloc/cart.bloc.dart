import 'dart:async';

import 'package:clean_arch2/core/string.dart';
import 'package:clean_arch2/feature/cart/presentation/bloc/cart.event.dart';
import 'package:clean_arch2/feature/cart/presentation/bloc/cart.state.dart';
import 'package:clean_arch2/feature/home/domain/product.domain.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc(): super(CartOnLoadedState()) {

    on<CartOnBuyProductEvent>(cartOnBuyProduct);
    on<CartOnViewProductListEvent>(cartOnViewProductList);
    on<CartOnAmountToPaidEvent>(cartOnAmountToPaidEvent);
    // remove product
    on<CartOnRemoveProductEvent>(cartOnRemoveProductEvent);
    // deduct product quantity
    on<CartOnDeductQuanityEvent>(cartOnDeductQuanityEvent);
    // add product quantity
    on<CartOnAddQuantityEvent>(cartOnAddQuantityEvent);
  }

  FutureOr<void> cartOnBuyProduct(CartOnBuyProductEvent event, Emitter<CartState> emit) {
    ProductModel tempProductModel = event.productModel;
    
    List<ProductModel> cartList = state is CartProductState? (state as CartProductState).productList : [] ;
    bool isFound = false;
    ProductModel productModel = ProductModel(
      id: tempProductModel.id, 
      name: tempProductModel.name, 
      price: tempProductModel.price, 
      quantity: 1
    );

    for(ProductModel pm in cartList) {
      if (pm.id == tempProductModel.id) {
        pm.quantity = pm.quantity + 1;
        isFound = true;
        break;
      }
    }

    if (!isFound) {
      cartList.add(productModel);
      Fluttertoast.showToast(msg: productQuantityUpdatedTitle);
    }

    
    
    emit(CartOnLoadedState());
    emit(CartProductState(productList: cartList));
    Fluttertoast.showToast(msg: productAddedTitle, toastLength: Toast.LENGTH_SHORT);
  }

  FutureOr<void> cartOnViewProductList(CartOnViewProductListEvent event, Emitter<CartState> emit) {
    BuildContext context = event.context;

    context.push("/cart");
  }

  FutureOr<void> cartOnAmountToPaidEvent(CartOnAmountToPaidEvent event, Emitter<CartState> emit) {
    List<ProductModel> cartList = state is CartProductState? (state as CartProductState).productList : [];
    double toPay = 0.00;

    for(ProductModel cl in cartList) {
      toPay += cl.price * cl.quantity;
    }

    emit(CartProductToPaidSatate(totalToPaid: toPay));
    emit(CartProductState(productList: cartList));
  }

  FutureOr<void> cartOnRemoveProductEvent(CartOnRemoveProductEvent event, Emitter<CartState> emit) {
    ProductModel productModel = event.productModel;
    List<ProductModel> cartList = state is CartProductState? (state as CartProductState).productList : [];

    cartList.remove(productModel);

    emit(CartOnLoadedState());
    emit(CartProductState(productList: cartList));
    Fluttertoast.showToast(msg: itemRemovedTitle, toastLength: Toast.LENGTH_SHORT);
  }

  FutureOr<void> cartOnDeductQuanityEvent(CartOnDeductQuanityEvent event, Emitter<CartState> emit) {
    ProductModel productModel = event.productModel;
    List<ProductModel> cartList = state is CartProductState? (state as CartProductState).productList : [];
    for(ProductModel cl in cartList) {
      if (cl.id == productModel.id) {
        cl.quantity = cl.quantity - 1;
        if (cl.quantity == 0) {
          cartList.remove(cl);
        }
        break;
      }
    }
    // we don't emit a state here; because we are using the "CartOnAmountToPaidEvent" event
    // it's doing the emitting of new state;
  }

  FutureOr<void> cartOnAddQuantityEvent(CartOnAddQuantityEvent event, Emitter<CartState> emit) {
    ProductModel productModel = event.productModel;
    List<ProductModel> cartList = state is CartProductState? (state as CartProductState).productList : [];
    for(ProductModel cl in cartList) {
      if (cl.id == productModel.id) {
        cl.quantity = cl.quantity + 1;
        break;
      }
    }
  }
}
