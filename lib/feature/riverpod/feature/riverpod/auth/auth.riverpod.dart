import 'dart:async';

import 'package:clean_arch2/config/db/hiver_riverpod/riverpod_db.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:clean_arch2/feature/riverpod/component/button/alertDialog.dart';
import 'package:clean_arch2/feature/riverpod/model/auth/auth.riverpod.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../auth/model/auth.model.dart';

class AuthRiverPod extends AsyncNotifier<AuthRiverPodModel?> {
  
  @override
  FutureOr<AuthRiverPodModel?> build() {
    return null;
  }
  
  AsyncValue<AuthRiverPodModel?> getActiveUser() {
    return state;
  }
  
  FutureOr<void> onSingupUser(AuthSignupRiverpodModel signUp) {
    ref.read(riverpodDbProvider.notifier).signupUser(signUp);
  }
  
  FutureOr<void> onLoginUser({required BuildContext context, required String email, required String password}) async {
    Object? response = await ref.read(riverpodDbProvider.notifier).loginUser(email: email, password: password);
    
    if (response == null) {
      if (!context.mounted) return;
      alertDialog(context: Navigator.of(context).context, title: authNotLoggedInTitle);
    }
    // if (response < 0) {
    //   Fluttertoast.showToast(msg: somethingWentWrongTitle, toastLength: Toast.LENGTH_SHORT);
    //   return;
    // }
    // Fluttertoast.showToast(msg: userCreatedSuccessfullyTitle, toastLength: Toast.LENGTH_SHORT);
  }
  
}
