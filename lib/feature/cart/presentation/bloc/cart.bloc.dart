import 'dart:async';
import 'dart:developer';

import 'package:clean_arch2/config/db/app_db.dart';
import 'package:clean_arch2/config/db/hive_model/product_model/product_model.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:clean_arch2/feature/cart/presentation/bloc/cart.event.dart';
import 'package:clean_arch2/feature/cart/presentation/bloc/cart.state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  AppDatabase appDatabase;
  CartBloc({required this.appDatabase}): super(CartOnLoadedState()) {

    on<CartOnBuyProductEvent>(cartOnBuyProduct);
    on<CartOnViewProductListEvent>(cartOnViewProductList);
    on<CartOnAmountToPaidEvent>(cartOnAmountToPaidEvent);
    // remove product
    on<CartOnRemoveProductEvent>(cartOnRemoveProductEvent);
    // deduct product quantity
    on<CartOnDeductQuanityEvent>(cartOnDeductQuanityEvent);
    // add product quantity
    on<CartOnAddQuantityEvent>(cartOnAddQuantityEvent);
    // on checkout
    // on<CartOnCheckOutEvent>(cartOnCheckOutEvent);
    // on go to shoping
    on<CartOnResetProductListEvent>(cartOnResetProductListEvent);
  }

  FutureOr<void> cartOnBuyProduct(CartOnBuyProductEvent event, Emitter<CartState> emit) {
    ProductEntity tempProductModel = event.productModel;
    
    List<ProductEntity> cartList = state is CartProductState? (state as CartProductState).productList : [] ;
    bool isFound = false;
    ProductEntity productModel = ProductEntity(
      id: tempProductModel.id, 
      name: tempProductModel.name, 
      price: tempProductModel.price, 
      quantity: 1
    );

    for(ProductEntity pm in cartList) {
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
    
    if (state is CartProductState) {
      final cartProductList = (state as CartProductState).productList;

      if (cartProductList.isNotEmpty) {
        context.push("/cart");
      }
      else {
        emit(CartProductEmptyState());
      }
    }
    else {
      emit(CartProductEmptyState());
      emit(CartOnLoadedState());
    }

  }

  FutureOr<void> cartOnAmountToPaidEvent(CartOnAmountToPaidEvent event, Emitter<CartState> emit) {
    List<ProductEntity> cartList = state is CartProductState? (state as CartProductState).productList : [];
    double toPay = 0.00;

    toPay = cartList.fold(toPay, (p, e) => p+(e.price * e.quantity));

    emit(CartProductToPaidSatate(totalToPaid: toPay));
    emit(CartProductState(productList: cartList));
  }

  FutureOr<void> cartOnRemoveProductEvent(CartOnRemoveProductEvent event, Emitter<CartState> emit) {
    ProductEntity productModel = event.productModel;
    List<ProductEntity> cartList = state is CartProductState? (state as CartProductState).productList : [];

    cartList.remove(productModel);

    emit(CartOnLoadedState());
    emit(CartProductState(productList: cartList));
    Fluttertoast.showToast(msg: itemRemovedTitle, toastLength: Toast.LENGTH_SHORT);
  }

  FutureOr<void> cartOnDeductQuanityEvent(CartOnDeductQuanityEvent event, Emitter<CartState> emit) {
    ProductEntity productModel = event.productModel;
    List<ProductEntity> cartList = state is CartProductState? (state as CartProductState).productList : [];
    for(ProductEntity cl in cartList) {
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
    ProductEntity productModel = event.productModel;
    List<ProductEntity> cartList = state is CartProductState? (state as CartProductState).productList : [];
    for(ProductEntity cl in cartList) {
      if (cl.id == productModel.id) {
        cl.quantity = cl.quantity + 1;
        break;
      }
    }
  }

  FutureOr<void> cartOnResetProductListEvent(CartOnResetProductListEvent event, Emitter<CartState> emit) {
    String email = event.email;
    if (state is CartProductState) {
      final cartList = (state as CartProductState).productList;
      appDatabase.saveCartRecordPerUser(email, cartList);
    }
    emit(CartOnLoadedState());
    emit(CartProductToPaidSatate(totalToPaid: 0.00));
    emit(CartProductState(productList: []));
  }
}
