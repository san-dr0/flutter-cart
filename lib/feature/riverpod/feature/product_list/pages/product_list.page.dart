import 'dart:developer';

import 'package:clean_arch2/config/db/hiver_riverpod/hiver_riverpod_model/hive_riverpod_model.dart';
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
  String t = "test";
  @override
  Widget build(BuildContext context) {
    
    final productList = ref.watch(productPodProvider.notifier).getAllProduct();
    
    return switch(productList) {
      AsyncData() => Text("Tests"),
      AsyncError() => Text("Errr"),
      _ => Text("Ohhh")
    };
  }
}
