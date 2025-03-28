import 'package:clean_arch2/config/db/hiver_riverpod/hiver_riverpod_model/hive_riverpod_model.dart';
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

  void removeItem (ProductEntryRiverPodModel product) {
    ref.read(cartRiverPodProvider.notifier).removeProductFromCart(product);
  }

  void addItem (ProductEntryRiverPodModel product) {
    ref.read(cartRiverPodProvider.notifier).addToCart(product);
  }

  void onPayCartItem () {
    ref.read(cartRiverPodProvider.notifier).cartOnBuyProduct(context);
  }

  @override
  Widget build(BuildContext context) {
    var cartList = ref.watch(cartRiverPodProvider);

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
                        Text("Name: ${cartList[index].name}"),
                        Text("\$: ${cartList[index].price}"),
                        Text("Qty: ${cartList[index].quantity}"),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(onPressed: () {
                          removeItem(cartList[index]);
                        }, icon: Icon(Icons.remove)),
                        IconButton(onPressed: () {
                          addItem(cartList[index]);
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
          itemCount: cartList.length),
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