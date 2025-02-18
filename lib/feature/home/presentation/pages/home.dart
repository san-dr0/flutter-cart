import 'dart:developer';

import 'package:clean_arch2/core/string.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState () => _HomePage();
}

class _HomePage extends State<HomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final eBox = Hive.box("eCommerce");
    final r = eBox.get("product");
    log("R >>> ");
    log(r.toString());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(homeTitle),
      ),
    );
  }
}
