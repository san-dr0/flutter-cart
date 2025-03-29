import 'dart:async';
import 'dart:developer';

import 'package:clean_arch2/config/db/hiver_riverpod/riverpod_db.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:clean_arch2/feature/riverpod-feature/component/button/alertDialog.dart';
import 'package:clean_arch2/feature/riverpod-feature/model/auth/auth.riverpod.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../../auth/model/auth.signup.riverpod.model.dart';

class AuthRiverPod extends AsyncNotifier<AuthRiverPodModel?> {
  
  @override
  FutureOr<AuthRiverPodModel?> build() {
    return null;
  }
  
  AsyncValue<AuthRiverPodModel?> getActiveUser() {
    return state;
  }
  
  FutureOr<void> onSingupUser(BuildContext context, AuthSignupRiverpodModel signUp) async {
    int singUpResponse = await ref.read(riverpodDbProvider.notifier).signupUser(signUp);
    
    if (singUpResponse == 1) {
      Fluttertoast.showToast(msg: userAlreadyExistsTitle, toastLength: Toast.LENGTH_LONG);
    }
    else if (singUpResponse == 0) {
      Fluttertoast.showToast(msg: userCreatedSuccessfullyTitle, toastLength: Toast.LENGTH_SHORT);
      context.push("/riverpod-auth-login");
    }

  }
  
  FutureOr<void> onLoginUser({required BuildContext context, required String email, required String password}) async {
    Object? response = await ref.read(riverpodDbProvider.notifier).loginUser(email: email, password: password);
    log('weqwe >>> ');
    log(response.toString());
    if (response == null) {
      Fluttertoast.showToast(msg: invalidCredsTitle, toastLength: Toast.LENGTH_SHORT);
      return;
    }
    // context.go("/")
  }
}
