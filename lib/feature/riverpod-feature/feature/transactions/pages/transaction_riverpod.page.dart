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
        child: Column(
          children: [
            Text(txnPod.hasValue ? txnPod.value!.length.toString(): '')
          ],
        ),
      ),
    );
  }
}
