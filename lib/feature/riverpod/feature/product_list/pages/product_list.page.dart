import 'package:clean_arch2/core/color.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:clean_arch2/feature/riverpod/feature/riverpod/product/product_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductListPage extends ConsumerStatefulWidget {
  const ProductListPage({super.key});
  
  @override
  ConsumerState<ProductListPage> createState () => _ProductListPage();
}

class _ProductListPage extends ConsumerState<ProductListPage> {

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(productListTitle),
        backgroundColor: tealColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.separated(
          itemBuilder: (context, index) {
            return Text("Ohh");
          }, 
          separatorBuilder: (context, index) {
            return const SizedBox(height: 8.0,);
          }, 
          itemCount: 5),
      ),
    );
  }
}
