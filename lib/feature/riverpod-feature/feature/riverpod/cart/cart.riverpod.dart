import 'package:clean_arch2/config/db/hiver_riverpod/hiver_riverpod_model/hive_riverpod_model.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:clean_arch2/feature/riverpod-feature/component/button/alertDialog.dart';
import 'package:clean_arch2/feature/riverpod-feature/component/button/ink.dart';
import 'package:clean_arch2/feature/riverpod-feature/feature/riverpod/pod-entry/pod_entry.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

@riverpod
class CartRiverPod extends AsyncNotifier<List<ProductEntryRiverPodModel>>{

  @override
  List<ProductEntryRiverPodModel> build() {
    return [];
  }
  
  FutureOr<void> addToCart(ProductEntryRiverPodModel product) {
    var rec = state.value?.where((rec) => rec.id == product.id).toList();
    List<ProductEntryRiverPodModel>? tempCartList = state.value;

    if (rec!.isNotEmpty) {
      rec[0].quantity = rec[0].quantity + 1;
      state = AsyncValue.data(state.value!);
    }
    else {
      final tempProduct = ProductEntryRiverPodModel(
        id: product.id,
        name: product.name,
        price: product.price,
        quantity: 1,
      );
      tempCartList!.add(tempProduct);
      state = AsyncValue.data(tempCartList);
    }

    Fluttertoast.showToast(msg: productAddedToCartTitle, toastLength: Toast.LENGTH_SHORT);
  }

  FutureOr<void> removeProductFromCart(BuildContext context, ProductEntryRiverPodModel product) {
    for(var product in state.value!.toList()) {
      if (product.id == product.id) {
        product.quantity = product.quantity - 1;
        if (product.quantity == 0) {
          state.value!.remove(product);
        }
      }
    }
    state = AsyncValue.data(state.value!);
    if (state.value!.isEmpty) {
      context.push("/");
    }
  }

  FutureOr<void> cartOnBuyProduct(BuildContext context) async{
    var authRecord = ref.read(authProvider);
    
    if (authRecord.value != null) {
    var balance = await ref.read(balancePod.notifier).getCurrentBalance(email: authRecord.value!.email);
      if (double.parse(balance!) > 0) {

        if (!context.mounted) return;
        
        alertDialog(context: context, title: areYouSureYouWantToPayThisTitle, okayFunc: () {
          ref.read(transactionsPod.notifier).addTransactionHistory(context: context, cartList: state.value!, email: authRecord.value!.email);
        }, closeFunc: () {
          context.pop();
        });
      }
      else if (double.parse(balance!) <= 0) {
        alertDialog(context: context, title: cantProceedPurchaseInsufficientBalance, okayFunc: () {
          context.push("/riverpod-dashboard");
        }, closeFunc: () {

        });
      }
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
