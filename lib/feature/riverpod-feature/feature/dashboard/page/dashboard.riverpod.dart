import 'dart:developer';

import 'package:biometric_signature/android_config.dart';
import 'package:biometric_signature/biometric_signature.dart';
import 'package:biometric_signature/ios_config.dart';
import 'package:clean_arch2/core/color.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:clean_arch2/core/text.style.dart';
import 'package:clean_arch2/feature/riverpod-feature/feature/riverpod/pod-entry/pod_entry.dart';
import 'package:device_security_checking/device_security_checking.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

// var authProvider = AsyncNotifierProvider<AuthRiverPod, AuthSignupRiverpodModel?>(() {
//   return AuthRiverPod();
// });

class DashBoardRiverpodPage extends ConsumerStatefulWidget {
  const DashBoardRiverpodPage({super.key});

  @override
  ConsumerState<DashBoardRiverpodPage> createState () => _DashBoardRiverpodPage();
}

class _DashBoardRiverpodPage extends ConsumerState<DashBoardRiverpodPage> {
  final _deviceSecurityChecking = DeviceSecurityChecking();
  bool isDeveloperOptionEnabled = false;
  RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkDeveloperOptionsEnabled();
  }
  void checkDeveloperOptionsEnabled () async {
    final isEnabled = await _deviceSecurityChecking.developerModeChecking();
    setState(() {
      isDeveloperOptionEnabled = isEnabled;
    });
  }

  void onTopup() {
    context.push("/riverpod-topup");
  }
  void onBiometrics () async {
    final biometricSignature = BiometricSignature();
    try{
      final String? biometricType = await biometricSignature.biometricAuthAvailable();
      log("biometricType $biometricType");
      
      // final bool? result = await biometricSignature.deleteKeys();
      final bool doExist = await biometricSignature.biometricKeyExists(checkValidity: true) ?? false;

      if (!doExist) {
        final String? biometricKey = await biometricSignature.createKeys(
          androidConfig: AndroidConfig(useDeviceCredentials: true),
          iosConfig: IosConfig(useDeviceCredentials: false)
        );
         log("DoExists --- >>> $doExist");
        log("biometricKey >>> $biometricKey");
        final String? signatrue = await biometricSignature.createSignature(
          options: {
            "payload": biometricKey!,
            "promptMessage": "You are Welcome!",
          "shouldMigrate": "true",
          "allowDeviceCredentials": "true"
          }
        );
        log('signatrue >>> $signatrue');
      }
      else {
        log("Already has keys");
      }
      
     

    } on PlatformException catch(e) {
      debugPrint("ErrM 1--- ${e.message}");
      debugPrint("ErrC 2--- ${e.code}");
    }
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
      body: SmartRefresher(
        onLoading: () {
          _refreshController.loadComplete();
        },
        onRefresh: () {
          _refreshController.refreshCompleted();
        },
        controller: _refreshController,
        enablePullDown: true,
        enablePullUp: true,
        physics: const BouncingScrollPhysics(),
        footer: CustomFooter(
          builder: (context, mode) {
            return mode == LoadStatus.loading ? const SizedBox(height: 20, child: Center(child: CircularProgressIndicator())) : const SizedBox(height: 20);
          },
        ),
        header: const WaterDropHeader(),
        child: Column(
          children: [
          ],
        ),
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
                  const SizedBox(height: 42.0,),
                  Text(
                    "Balance: \$ ${currentBalance.hasValue ? double.parse(currentBalance.value!).toStringAsFixed(2) : 0.00}",
                    style: textStyle(),
                  ),
                  if (isDeveloperOptionEnabled)
                    Text(
                      "Developer Option is Enabled",
                      style: textStyle(color: Colors.red[200]!),
                    )
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
              onTap: () {
                onBiometrics();
              },
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
