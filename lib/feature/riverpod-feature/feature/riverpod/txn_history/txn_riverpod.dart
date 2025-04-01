import 'package:clean_arch2/config/db/hiver_riverpod/hiver_riverpod_model/hive_riverpod_model.dart';
import 'package:clean_arch2/config/db/hiver_riverpod/hiver_riverpod_model/txn_riverpod_model.dart';
import 'package:clean_arch2/config/db/hiver_riverpod/riverpod_db.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:clean_arch2/feature/riverpod-feature/feature/riverpod/pod-entry/pod_entry.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class TransactionPod extends AsyncNotifier<List<TransactionHistoryRiverpodModel>> {
  @override
  FutureOr<List<TransactionHistoryRiverpodModel>> build() async {
    return await getTransactionHistory(email: ref.read(authProvider).value!.email);
  }
  FutureOr<void> addTransactionHistory({required BuildContext context, required List<ProductEntryRiverPodModel> cartList, required String email}) async {
    int? resposne = await ref.read(riverpodDbProvider.notifier).addCartTransactionList(cartList: cartList, email: email);

    if (resposne == null) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: somethingWentWrongTitle, toastLength: Toast.LENGTH_LONG);
    }
    else {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: transactionRecordTitleAdded, toastLength: Toast.LENGTH_SHORT);
    }
  }

  FutureOr<List<TransactionHistoryRiverpodModel>> getTransactionHistory({required String email}) async {
    List<TransactionHistoryRiverpodModel> txnList = await ref.read(riverpodDbProvider.notifier).getTransactionHistory(email: email);
    state = AsyncValue.data(txnList);
    
    return txnList;
  }
}
