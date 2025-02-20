import 'package:clean_arch2/core/color.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:clean_arch2/feature/home/domain/product.domain.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ViewCertainProductPage extends StatefulWidget {
  ViewCertainProductPage({super.key, required this.productModel});
  
  ProductModel productModel;

  @override
  State<ViewCertainProductPage> createState () => _ViewCertainProductPage();
}

class _ViewCertainProductPage extends State<ViewCertainProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          viewCertainProductTitle,
        ),
        backgroundColor: tealColor,
      ),
      body: Column(
        children: [
          Text(widget.productModel.name)
        ],
      ),
    );
  }
}
