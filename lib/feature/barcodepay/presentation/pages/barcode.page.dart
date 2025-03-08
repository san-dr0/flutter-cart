import 'package:clean_arch2/core/color.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:flutter/material.dart';

class BarcodePayPage extends StatefulWidget {
  const BarcodePayPage({super.key});

  @override
  State<BarcodePayPage> createState () => _BarcodePayPage();
}

class _BarcodePayPage extends  State<BarcodePayPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: tealColor,
        title: Text(barcodePayTitle),
      ),
    );
  }
}
