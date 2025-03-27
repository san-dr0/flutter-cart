import 'package:clean_arch2/core/color.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:clean_arch2/feature/riverpod/feature/riverpod/cart/cart.riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartListPodPage extends ConsumerStatefulWidget {
  const CartListPodPage({super.key});

  @override
  ConsumerState<CartListPodPage> createState () => _CartListPodPage();
}

class _CartListPodPage extends ConsumerState<CartListPodPage> {

  @override
  Widget build(BuildContext context) {
    var cartList = ref.watch(cartRiverPodProvider);

    return Text("tests");
  }
}