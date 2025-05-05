import 'package:clean_arch2/core/color.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:clean_arch2/feature/riverpod-feature/feature/riverpod/pod-entry/pod_entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransactionHistoryRiverpodPage extends ConsumerStatefulWidget {
  const TransactionHistoryRiverpodPage({super.key});

  @override
  ConsumerState<TransactionHistoryRiverpodPage> createState () => _TransactionHistoryRiverpodPage();
}

class _TransactionHistoryRiverpodPage extends ConsumerState<TransactionHistoryRiverpodPage> {
  @override
  Widget build(BuildContext context) {
  var txnPod = ref.watch(transactionsPod);
  
    return Scaffold(
      appBar: AppBar(
        title: Text(transactionTitle),
        backgroundColor: tealColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.separated(itemBuilder: (context, index) {
          return Card(
            child: Padding(padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: 150.0,
                child: ListView.builder(itemBuilder: (context, index2) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Name: ${txnPod.value![index].cartList[index2].name}"),
                          Text("\$: ${txnPod.value![index].cartList[index2].price.toStringAsFixed(2)}"),
                          Text("Qty: ${txnPod.value![index].cartList[index2].quantity}"),
                        ],
                      ),
                    ),
                  );
                }, itemCount: txnPod.value![index].cartList.length,),
              )
            ),
          );
        } , separatorBuilder: (context, index) {
          return Text("sperator");
        }, itemCount: txnPod.hasValue ? txnPod.value!.length: 0),
      ),
    );
  }
}
