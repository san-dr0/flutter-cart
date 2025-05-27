import 'package:clean_arch2/config/db/hiver_riverpod/hiver_riverpod_model/hive_riverpod_model.dart';
import 'package:clean_arch2/core/color.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:clean_arch2/feature/riverpod-feature/feature/riverpod/pod-entry/pod_entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartListPodPage extends ConsumerStatefulWidget {
  const CartListPodPage({super.key});

  @override
  ConsumerState<CartListPodPage> createState () => _CartListPodPage();
}

class _CartListPodPage extends ConsumerState<CartListPodPage> {

  void removeItem (ProductEntryRiverPodModel product) {
    ref.read(cartRiverPod.notifier).removeProductFromCart(context, product);
  }

  void updateCartQuantity (ProductEntryRiverPodModel product) {
    ref.read(cartRiverPod.notifier).addToCart(product);
  }

  void onPayCartItem () {
    ref.read(cartRiverPod.notifier).cartOnBuyProduct(context);
  }

  @override
  Widget build(BuildContext context) {
    var cartList = ref.watch(cartRiverPod);

    return Scaffold(
      appBar: AppBar(
        title: Text(cartTitle),
        backgroundColor: tealColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.separated(
          itemBuilder: (context, index) {
            return Card(
              child: Padding(padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Name: ${cartList.value![index].name}"),
                        Text("\$: ${cartList.value![index].price.toStringAsFixed(2)}"),
                        Text("Qty: ${cartList.value![index].quantity}"),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(onPressed: () {
                          removeItem(cartList.value![index]);
                        }, icon: Icon(Icons.remove)),
                        IconButton(onPressed: () {
                          updateCartQuantity(cartList.value![index]);
                        }, icon: Icon(Icons.add))
                      ],
                    ),
                  ],
                ),
              ),
            );
          }, 
          separatorBuilder: (context, index) {
            return const SizedBox(height: 8.0,);
          }, 
            itemCount: cartList.value!.length
          ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          onPayCartItem();
        },
        child: Icon(
          Icons.payments_outlined,
          color: Colors.red[600],
        ),
      ),
    );
  }
}