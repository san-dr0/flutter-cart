import 'dart:developer';

import 'package:clean_arch2/config/db/hiver_riverpod/riverpod_db.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:clean_arch2/feature/riverpod-feature/feature/riverpod/pod-entry/pod_entry.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

@riverpod
class BalanceRiverPod extends AsyncNotifier<double> {
    @override
    Future<double> build() async {
      return getCurrentBalance(email: ref.read(authProvider).value!.email);
    }
    
    Future<double> getCurrentBalance({required String email}) async {
      var currentBalance =  await ref.read(riverpodDbProvider.notifier).getCurrentBalance(email: email);
      
      if (currentBalance == null) {
        Fluttertoast.showToast(msg: somethingWentWrongTitle, toastLength: Toast.LENGTH_SHORT);
        return 0.00;
      }

      return currentBalance;
    }
    
    FutureOr<void> updateBalance({required String email, required double balance}) async {
      double? newBalance = await ref.read(riverpodDbProvider.notifier).updateBalance(email: email, newBalance: balance);
      if (newBalance != null) {
        state = AsyncValue.data(newBalance);
        Fluttertoast.showToast(msg: topUpIsSuccessfull, toastLength: Toast.LENGTH_SHORT);
        return;
      }
      else {
        Fluttertoast.showToast(msg: somethingWentWrongTitle, toastLength: Toast.LENGTH_LONG);
      }
    }

}
