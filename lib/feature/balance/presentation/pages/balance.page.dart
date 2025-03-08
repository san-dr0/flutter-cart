import 'package:clean_arch2/core/text.style.dart';
import 'package:flutter/material.dart';

class BalanceComponent extends StatefulWidget {
  const BalanceComponent({super.key});

  @override
  State<BalanceComponent> createState () => _BalanceComponent();
}

class _BalanceComponent extends State<BalanceComponent> {

  @override
  Widget build (BuildContext context) {
    return Column(
      children: [
        Text(
          "Balance: 0.00",
          style: textStyle(),
        )
      ],
    );
  }
}
