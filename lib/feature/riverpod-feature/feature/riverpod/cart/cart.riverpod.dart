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
    }
    else {
      tempCartList!.add(product);
      state = AsyncValue.data(tempCartList);
    }

    Fluttertoast.showToast(msg: productAddedToCartTitle, toastLength: Toast.LENGTH_SHORT);
  }

  FutureOr<void> removeProductFromCart(ProductEntryRiverPodModel product) {
    // state = state.value?.where((item) => item.id != product.id).toList();
  }

  FutureOr<void> cartOnBuyProduct(BuildContext context) async{
    var authRecord = ref.read(authProvider);
    
    if (authRecord.value != null) {
    var balance = await ref.read(balancePod.notifier).getCurrentBalance(email: authRecord.value!.email);
      if (balance > 0) {

        alertDialog(context: context, title: areYouSureYouWantToPayThisTitle, okayFunc: () {}, closeFunc: () {

        });
      }
      else if (balance <= 0) {
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
