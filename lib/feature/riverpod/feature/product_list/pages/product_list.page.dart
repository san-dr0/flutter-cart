import 'package:clean_arch2/core/color.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:flutter/material.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});
  
  @override
  State<ProductListPage> createState () => _ProductListPage();
}

class _ProductListPage extends State<ProductListPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(productListTitle),
        backgroundColor: tealColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text("Tests"),
      ),
    );
  }
}
