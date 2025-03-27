import 'package:clean_arch2/config/db/hiver_riverpod/hiver_riverpod_model/hive_riverpod_model.dart';
import 'package:clean_arch2/core/color.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:clean_arch2/feature/riverpod/component/button/ink.dart';
import 'package:clean_arch2/feature/riverpod/feature/riverpod/product/product_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final productProvider = AsyncNotifierProvider<ProductPod, List<ProductEntryRiverPodModel>>(() {
    return ProductPod();
});

class ProductListPage extends ConsumerStatefulWidget {
  const ProductListPage({super.key});
  
  @override
  ConsumerState<ProductListPage> createState () => _ProductListPage();
}

class _ProductListPage extends ConsumerState<ProductListPage> {

  void onUpdateProduct(ProductEntryRiverPodModel product) {
    context.push("/admin-update-product-v2", extra: product);
  }

  void onViewProduct(ProductEntryRiverPodModel product) {
    
  }
  
  @override
  Widget build(BuildContext context) {
    final productRecord = ref.watch(productProvider);
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: tealColor,
        title: Text(productListTitle),
      ),
      body: SafeArea(
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
                      Text("Name: ${productRecord.value![index].name}"),
                      Text("\$: ${productRecord.value![index].price}"),
                      Text("Qty: ${productRecord.value![index].quantity}"),
                      const SizedBox(height: 5.0,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          inkButton(tapped: (param) {
                            onUpdateProduct(productRecord.value![index]);
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
          itemCount: productRecord.value != null ? productRecord.value!.length:0),
      ),
    );
  }
}
