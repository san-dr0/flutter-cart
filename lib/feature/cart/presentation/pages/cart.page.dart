import 'package:clean_arch2/core/string.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});
  
  @override
  State<CartPage> createState () => _CartPage();
}

class _CartPage extends State<CartPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(cartTitle),
      ),
    );
  }
}
