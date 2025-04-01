import 'package:clean_arch2/config/db/hiver_riverpod/hiver_riverpod_model/hive_riverpod_model.dart';
import 'package:clean_arch2/config/db/hiver_riverpod/hiver_riverpod_model/txn_riverpod_model.dart';
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
        child: Expanded(
          child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Column(
                    children: [
                      Text(txnPod.value![index].id),
                      SizedBox(
                        height: 150.0,
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, cartIndex) {
                            return Card(
                              child: Padding(padding: const EdgeInsets.all(6.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Name: ${txnPod.value![index].cartList[cartIndex].name}"),
                                    Text("Price: \$ ${txnPod.value![index].cartList[cartIndex].price}"),
                                    Text("Qty: ${txnPod.value![index].cartList[cartIndex].quantity}"),
                                  ],
                                ),
                              )
                            );
                          }, 
                          separatorBuilder: (context, index) => const SizedBox(height: 6.0,), 
                          itemCount: txnPod.value![index].cartList.length
                        ),
                      )
                    ],
                  ),
                ),
              );
            }, 
            separatorBuilder: (context, index) {
              return const SizedBox(height: 6.0);
            }, 
            itemCount: txnPod.hasValue ? txnPod.value!.length : 0),
        ),
      ),
    );
  }
}
