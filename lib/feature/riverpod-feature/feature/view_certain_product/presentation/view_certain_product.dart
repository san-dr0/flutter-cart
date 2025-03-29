import 'package:clean_arch2/config/db/hiver_riverpod/hiver_riverpod_model/hive_riverpod_model.dart';
import 'package:clean_arch2/core/color.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:clean_arch2/feature/riverpod-feature/component/button/ink.dart';
import 'package:clean_arch2/feature/riverpod-feature/feature/riverpod/cart/cart.riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: must_be_immutable
class ViewCertainProductPodPage extends ConsumerStatefulWidget {
  ViewCertainProductPodPage({super.key, required this.productEntryRiverPodModel});
  ProductEntryRiverPodModel productEntryRiverPodModel;

  @override
  ConsumerState<ViewCertainProductPodPage> createState () => _ViewCertainProductPodPage();
}

class _ViewCertainProductPodPage extends ConsumerState<ViewCertainProductPodPage> {

  void onAddToCart() {
    ref.read(cartRiverPodProvider.notifier).addToCart(widget.productEntryRiverPodModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(viewCertainProductTitle),
        backgroundColor: tealColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Name: ${widget.productEntryRiverPodModel.name}"),
                  Text("\$: ${widget.productEntryRiverPodModel.price}"),
                  Text("Qty: ${widget.productEntryRiverPodModel.quantity}"),
                  const SizedBox(height: 10.0,),
                  Center(
                    child: inkButton(tapped: (param) {
                      onAddToCart();
                    }, subTitle: "Add to cart"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
