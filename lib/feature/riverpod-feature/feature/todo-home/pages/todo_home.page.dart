
import 'dart:developer';

import 'package:clean_arch2/config/db/hiver_riverpod/hiver_riverpod_model/hive_riverpod_model.dart';
import 'package:clean_arch2/core/color.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:clean_arch2/core/text.style.dart';
import 'package:clean_arch2/feature/riverpod-feature/component/button/ink.dart';
import 'package:clean_arch2/feature/riverpod-feature/feature/product_list/pages/product_list.page.dart';
import 'package:clean_arch2/feature/riverpod-feature/feature/riverpod/pod-entry/pod_entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TodoHomePage extends ConsumerStatefulWidget {
  const TodoHomePage({super.key});
  @override
  ConsumerState<TodoHomePage> createState () => _TodoHomePage();
}

class _TodoHomePage extends ConsumerState<TodoHomePage> {

  void loginAdminDashBoard () {
    context.go("/admin-dashboard-v2");
  }

  void addToCart(ProductEntryRiverPodModel product) {
    ref.read(cartRiverPod.notifier).addToCart(product);
  }

  void onViewProductInfo(ProductEntryRiverPodModel product) {
    context.push("/riverpod-on-view-certain-product", extra: product);
  }

  void onViewCartList() {
    if (ref.read(cartRiverPod).value!.isEmpty) {
      Fluttertoast.showToast(msg: emptyCartTitle, toastLength: Toast.LENGTH_SHORT);
      
      return;
    }
    context.push("/riverpod-on-view-cart-list");
  }

  void onLoginUser() {
    if (ref.read(authProvider).value != null) {
      context.push("/riverpod-dashboard");
      return;
    }
    context.push('/riverpod-auth-login');
  }

  @override
  Widget build(BuildContext context) {
    var productList = ref.watch(productProvider);
    var cartProductList = ref.watch(cartRiverPod);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: tealColor,
        title: Text(cartTitle),
        actions: [
          IconButton(onPressed: () {
            onLoginUser();
          }, icon: Icon(Icons.person, color: whiteColor,)),
          Stack(
            children: [
              IconButton(onPressed: () {
                onViewCartList();
              }, icon: Icon(Icons.shopping_cart, color: whiteColor)),
              Positioned(
                top: -5,
                right: 8,
                child: Text(
                  cartProductList.value!.length.toString(),
                  style: textStyle(
                    color: Colors.red,
                    fontSize: 22.0
                  ),
                ),
              )
            ],
          ),
          IconButton(onPressed: () {
            loginAdminDashBoard();
          }, icon: Icon(Icons.admin_panel_settings_outlined, color: whiteColor)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.separated(
          itemBuilder: (context, index) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Name: ${productList.value![index].name}"),
                        Text("\$: ${productList.value![index].price.toStringAsFixed(2)}"),
                        Text("Qty: ${productList.value![index].quantity}"),
                      ],
                    ),
                    Column(
                      children: [
                        inkButton(tapped: (param) {
                          addToCart(productList.value![index]);
                        }, subTitle: "Add to cart"),
                        const SizedBox(height: 5.0,),
                        inkButton(tapped: (param) {
                          onViewProductInfo(productList.value![index]);
                        }, subTitle: "View info"),
                      ],
                    )
                  ],
                ),
              ),
            );
          }, 
          separatorBuilder: (context, index) {
            return SizedBox(height: 5.0,);
          }, 
          itemCount: productList.value != null ? productList.value!.length : 0,
        ),
      ),
    );
  }
}
