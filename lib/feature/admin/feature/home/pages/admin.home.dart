import 'package:clean_arch2/core/color.dart';
import 'package:flutter/material.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState () => _AdminHomePage();
}

class _AdminHomePage extends State<AdminHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: tealColor,
      ),
    );
  }
}
