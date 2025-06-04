import 'package:clean_arch2/config/db/hiver_riverpod/hiver_riverpod_model/hive_riverpod_model.dart';
import 'package:clean_arch2/core/color.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:clean_arch2/feature/riverpod-feature/component/button/ink.dart';
import 'package:clean_arch2/feature/riverpod-feature/feature/riverpod/pod-entry/pod_entry.dart';
import 'package:clean_arch2/feature/riverpod-feature/feature/riverpod/product/product_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

final productProvider = AsyncNotifierProvider<ProductPod, List<ProductEntryRiverPodModel>>(() {
    return ProductPod();
});

class ProductListPage extends ConsumerStatefulWidget {
  const ProductListPage({super.key});
  
  @override
  ConsumerState<ProductListPage> createState () => _ProductListPage();
}

class _ProductListPage extends ConsumerState<ProductListPage> {
  RefreshController refreshController = RefreshController(initialRefresh: false);
  List<ProductEntryRiverPodModel> productRecord = [];

  void onUpdateProduct(ProductEntryRiverPodModel product) {
    context.push("/admin-update-product-v2", extra: product);
  }

  void onViewProduct(ProductEntryRiverPodModel product) {
    
  }

  void onRefresh() {
    setState(() {
    });
    refreshController.refreshCompleted();
  }

  void onGetProductList() async{
    final adminAuth = ref.read(adminAuthPod).value;
    final product = await ref.watch(productProvider.notifier).getAllProductPerAdmin(adminAuth!.email);
    setState(() {
      productRecord = product;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    onGetProductList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: tealColor,
        title: Text(productListTitle),
      ),
      body: SafeArea(
        child: SmartRefresher(
          controller: refreshController,
          child: ListView.separated(
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Name: ${productRecord[index].name}"),
                      Text("\$: ${productRecord[index].price}"),
                      Text("Qty: ${productRecord[index].quantity}"),
                      const SizedBox(height: 5.0,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          inkButton(tapped: (param) {
                            onUpdateProduct(productRecord[index]);
                          }, subTitle: "Update"),
                          const SizedBox(width: 5.0,),
                          inkButton(tapped: (param) {

                          }, subTitle: "View"),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          }, 
          separatorBuilder: (context, index) {
            return const SizedBox(height: 5.0,);
          }, 
          itemCount: productRecord.length
        ),
        ),
      ),
    );
  }
}
