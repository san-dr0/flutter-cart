
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

class TodoHomePage extends ConsumerStatefulWidget {
  const TodoHomePage({super.key});
  @override
  ConsumerState<TodoHomePage> createState () => _TodoHomePage();
}

class _TodoHomePage extends ConsumerState<TodoHomePage> {	
	List<ProductEntryRiverPodModel>? productList = [];
	bool isLoading = true;
	List<ProductEntryRiverPodModel>? cartProductList = [];

	void getRecords () async {
		var product = ref.watch(productProvider).value;
		bool loading = ref.read(appLoading).value!;
		var cartList = ref.watch(cartRiverPod).value;
		setState(() {
		  productList = product;
			isLoading = loading;
			cartProductList = cartList;
		});
	}

  void loginAdminDashBoard () {
    final adminAuth = ref.read(adminAuthPod).value;
    ref.read(userTypePod.notifier).setUserType("admin");
    if (adminAuth != null) {
      context.push("/admin-dashboard-v2");
      return;
    }
    context.push("/riverpod-auth-login");
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
    ref.read(userTypePod.notifier).setUserType("user");
    if (ref.read(authProvider).value != null) {
      context.push("/riverpod-dashboard");
      return;
    }
    context.push('/riverpod-auth-login');
  }

  @override
  Widget build(BuildContext context) {
		getRecords();
		Widget content = SizedBox();

		if (isLoading){
			content = Center(
				child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
					crossAxisAlignment: CrossAxisAlignment.center,
					children: [
						CircularProgressIndicator(
							color: Colors.amber,
						),
						Text(pleaseWaitTitle)
					],
				),
			);
		}
		else {
			content = Padding(
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
                        Text("Name: ${productList![index].name}"),
                        Text("\$: ${productList![index].price.toStringAsFixed(2)}"),
                        Text("Qty: ${productList![index].quantity}"),
                      ],
                    ),
                    Column(
                      children: [
                        inkButton(tapped: (param) {
                          addToCart(productList![index]);
                        }, subTitle: "Add to cart"),
                        const SizedBox(height: 5.0,),
                        inkButton(tapped: (param) {
                          onViewProductInfo(productList![index]);
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
          itemCount: productList != null ? productList!.length : 0,
        ),
      );
		}

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
                  cartProductList!.length.toString(),
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
      body: content
    );
  }
}
