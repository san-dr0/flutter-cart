import 'dart:developer';

import 'package:clean_arch2/config/db/hiver_riverpod/hiver_riverpod_model/hive_riverpod_model.dart';
import 'package:clean_arch2/core/color.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:clean_arch2/feature/riverpod/component/button/ink.dart';
import 'package:clean_arch2/feature/riverpod/feature/riverpod/product/product_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final productList = FutureProvider<List<ProductEntryRiverPodModel>>((ref) async {
    return await ref.watch(productPodProvider.notifier).getAllProduct();
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
    
    final rec = ref.watch(productList);
    
    return switch (rec) {
      AsyncError(:final error) => Text('Error: $error'),
      AsyncData(:final value) => Scaffold(
        appBar: AppBar(
          backgroundColor: tealColor,
          title: Text(productListTitle),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.separated(
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Name: ${value[index].name}"),
                      Text("\$: ${value[index].price.toStringAsFixed(2)}"),
                      Text("Qty: ${value[index].quantity.toString()}"),
                      const SizedBox(height: 10.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          inkButton(tapped: (param) {
                            onUpdateProduct(param as ProductEntryRiverPodModel);
                          }, 
                            subTitle: "Update", bgColor: tealColor, splashColor: Colors.teal[800]!, param: value[index]
                          ),
                          const SizedBox(width: 10.0,),
                          inkButton(tapped: (param) {
                            onViewProduct(param as ProductEntryRiverPodModel);
                          }, subTitle: "View", bgColor: tealColor, splashColor: Colors.teal[800]!),
                        ],
                      )
                    ],
                  ),
                ),
              );
            }, 
            separatorBuilder: (context, index) {
              return const SizedBox(height: 6.0,);
            }, 
            itemCount: value.length),
        ),
      ),
      _ => SafeArea(
        child: Center(
          child: CircularProgressIndicator()
        ),
      ),
    };
  }
}
