import 'package:clean_arch2/core/color.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:clean_arch2/core/text.style.dart';
import 'package:clean_arch2/feature/riverpod-feature/feature/riverpod/pod-entry/pod_entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// var authProvider = AsyncNotifierProvider<AuthRiverPod, AuthSignupRiverpodModel?>(() {
//   return AuthRiverPod();
// });

class DashBoardRiverpodPage extends ConsumerStatefulWidget {
  const DashBoardRiverpodPage({super.key});

  @override
  ConsumerState<DashBoardRiverpodPage> createState () => _DashBoardRiverpodPage();
}

class _DashBoardRiverpodPage extends ConsumerState<DashBoardRiverpodPage> {

  void onTopup() {
    context.push("/riverpod-topup");
  }
  void onBiometrics () {

  }

  void onTransactions () {

  }

  void onLogout() {
    ref.read(authProvider.notifier).logOutUser();
    context.go("/");
  }

  void onGoHome() {
    context.go("/");
  }

  void onGoToTransactions() {
    context.push("/riverpod-transactions");
  }

  @override
  Widget build(BuildContext context) {
    var authPod = ref.watch(authProvider);
    var currentBalance = ref.watch(balancePod);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: tealColor,
        title: Text(dashBoardTitle),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: tealColor
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name: ${authPod.value?.lastname}, ${authPod.value?.firstname}",
                    style: textStyle(),
                  ),
                  Text(
                    "Email: ${authPod.value?.email}",
                    style: textStyle(),
                  ),
                  const SizedBox(height: 50.0,),
                  Text(
                    "Balance: \$ ${currentBalance.hasValue ? currentBalance.value!.toStringAsFixed(2) : 0.00}",
                    style: textStyle(),
                  ),
                ],
              ),
            ),
            ListTile(
              onTap: () {
                onGoHome();
              },
              title: Text("Home"),
            ),
            ListTile(
              onTap: () {
                onTopup();
              },
              title: Text("Topup"),
            ),
            ListTile(
              title: Text("Biometrics"),
            ),
            ListTile(
              onTap: () {
                onGoToTransactions();
              },
              title: Text("Transactions"),
            ),
            ListTile(
              onTap: () {
              },
              title: Text("Inquiries"),
            ),
            ListTile(
              onTap: () {
                onLogout();
              },
              title: Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
