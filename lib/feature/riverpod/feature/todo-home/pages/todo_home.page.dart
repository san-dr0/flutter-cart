import 'package:clean_arch2/config/db/hiver_riverpod/hiver_riverpod_model/hive_riverpod_model.dart';
import 'package:clean_arch2/core/color.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:clean_arch2/core/text.style.dart';
import 'package:clean_arch2/feature/riverpod/component/button/ink.dart';
import 'package:clean_arch2/feature/riverpod/feature/product_list/pages/product_list.page.dart';
import 'package:clean_arch2/feature/riverpod/feature/riverpod/cart/cart.riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class TodoHomePage extends ConsumerStatefulWidget {
  const TodoHomePage({super.key});
  @override
  ConsumerState<TodoHomePage> createState () => _TodoHomePage();
}

class _TodoHomePage extends ConsumerState<TodoHomePage> {

  @override
  void initState() {
    super.initState(); 
  }

  void loginAdminDashBoard () {
    context.go("/admin-dashboard-v2");
  }

  void addToCart(ProductEntryRiverPodModel product) {
    ref.read(cartRiverPodProvider.notifier).addToCart(product);
  }

  void onViewProductInfo(ProductEntryRiverPodModel product) {
    context.push("/riverpod-on-view-certain-product", extra: product);
  }

  void onViewCartList() {
    if (ref.read(cartRiverPodProvider).isEmpty) {
      Fluttertoast.showToast(msg: emptyCartTitle, toastLength: Toast.LENGTH_SHORT);
      
      return;
    }
    context.push("/riverpod-on-view-cart-list");
  }

  @override
  Widget build(BuildContext context) {
    var productList = ref.watch(productProvider);
    var cartProductList = ref.watch(cartRiverPodProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: tealColor,
        title: Text(cartTitle),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.person, color: whiteColor,)),
          Stack(
            children: [
              IconButton(onPressed: () {
                onViewCartList();
              }, icon: Icon(Icons.shopping_cart, color: whiteColor)),
              Positioned(
                top: -5,
                right: 8,
                child: Text(
                  cartProductList.length.toString(),
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
                        Text("\$: ${productList.value![index].price}"),
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
          itemCount: productList.value != null ? productList.value!.length : 0
        ),
      ),
    );
  }
}
