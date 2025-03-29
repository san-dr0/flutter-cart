import 'package:clean_arch2/config/db/hiver_riverpod/hiver_riverpod_model/hive_riverpod_model.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:clean_arch2/feature/riverpod-feature/component/button/ink.dart';
import 'package:clean_arch2/feature/riverpod-feature/feature/riverpod/auth/auth.riverpod.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../auth/model/auth.signup.riverpod.model.dart';

part "cart.riverpod.g.dart";

var authProvider = AsyncNotifierProvider<AuthRiverPod, AuthSignupRiverpodModel?>(() {
  return AuthRiverPod();
});

@riverpod
class CartRiverPod extends _$CartRiverPod{

  @override
  List<ProductEntryRiverPodModel> build() {
    return [];
  }

  FutureOr<void> addToCart(ProductEntryRiverPodModel product) {
    var rec = state.where((rec) => rec.id == product.id).toList();

    if (rec.isNotEmpty) {
      rec[0].quantity = rec[0].quantity + 1;
    }
    else {
      state = [
        ...state, 
        ProductEntryRiverPodModel(id: product.id, name: product.name, price: product.price, quantity: 1)
      ];
    }

    Fluttertoast.showToast(msg: productAddedToCartTitle, toastLength: Toast.LENGTH_SHORT);
  }

  FutureOr<void> removeProductFromCart(ProductEntryRiverPodModel product) {
    state = state.where((item) => item.id != product.id).toList();
  }

  FutureOr<void> cartOnBuyProduct(BuildContext context) {
    var authRecord = ref.read(authProvider);
    
    if (authRecord.value != null) {

    }
    else if (authRecord.value == null){
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Column(
                  children: [
                    Text(authNotLoggedInTitle),
                    const SizedBox(height: 10.0,),
                    inkButton(tapped: (param) {
                      context.push('/riverpod-auth-login');
                      context.pop();
                    }, subTitle: "Okay")
                  ],
                ),
              ),
            ],
          ),
        );
      },);
    }
  }
}
