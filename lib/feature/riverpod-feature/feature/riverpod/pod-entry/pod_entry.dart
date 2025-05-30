import 'package:clean_arch2/config/db/hiver_riverpod/hiver_riverpod_model/hive_riverpod_model.dart';
import 'package:clean_arch2/config/db/hiver_riverpod/hiver_riverpod_model/txn_riverpod_model.dart';
import 'package:clean_arch2/feature/riverpod-feature/feature/riverpod/auth/auth.riverpod.dart';
import 'package:clean_arch2/feature/riverpod-feature/feature/riverpod/balance/balance.riverpod.dart';
import 'package:clean_arch2/feature/riverpod-feature/feature/riverpod/cart/cart.riverpod.dart';
import 'package:clean_arch2/feature/riverpod-feature/feature/riverpod/txn_history/txn_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../admin/model/admin.model.dart';
import '../../auth/model/signup/signup.model.dart';
import '../auth/admin.auth.riverpod.dart';
import '../user-type/user_type.dart';

var authProvider = AsyncNotifierProvider<AuthRiverPod, SupaUserModelRetrieve?>(() {
  return AuthRiverPod();
});

var cartRiverPod = AsyncNotifierProvider<CartRiverPod, List<ProductEntryRiverPodModel>>(() {
  return CartRiverPod();
});

var balancePod = AsyncNotifierProvider<BalanceRiverPod, String?> (() {
  return BalanceRiverPod();
});

var transactionsPod = AsyncNotifierProvider<TransactionPod, List<TransactionHistoryRiverpodModel>>(() {
  return TransactionPod();
});

var adminAuthPod = AsyncNotifierProvider<AdminAuthRiverPod, AdminCredentials?>(() {
  return AdminAuthRiverPod();
});

var userTypePod = AsyncNotifierProvider<RiverPodUserType, String?>(() {
  return RiverPodUserType();
});
