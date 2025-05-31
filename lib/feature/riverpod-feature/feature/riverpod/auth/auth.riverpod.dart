import 'dart:async';
import 'package:clean_arch2/config/db/hiver_riverpod/riverpod_db.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:clean_arch2/feature/riverpod-feature/feature/auth/model/signup/signup.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../../auth/model/auth.signup.riverpod.model.dart';

class AuthRiverPod extends AsyncNotifier<SupaUserModelRetrieve?> {
  
  @override
  Future<SupaUserModelRetrieve?> build() async{
    return currentActiveUser();
  }

  SupaUserModelRetrieve? currentActiveUser() {
    // log("Got >>>> ${state.value}");
    return state.value;
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
    var response = await ref.read(riverpodDbProvider.notifier).loginUser(email: email, password: password);
    
    if (response == null) {
      Fluttertoast.showToast(msg: invalidCredsTitle, toastLength: Toast.LENGTH_SHORT);
      return;
    }

    SupaUserModelRetrieve responseAuth = response as SupaUserModelRetrieve;

    SupaUserModelRetrieve? authSignupRiverpodModel = SupaUserModelRetrieve(
      id: responseAuth.id, 
      firstname: responseAuth.firstname, 
      lastname: responseAuth.lastname,
      email: email, 
      password: password,
      userType: responseAuth.userType
    );
    state = AsyncValue.data(authSignupRiverpodModel);

    if (responseAuth.userType == 'admin') {
      context.go("/riverpod-dashboard");
      return;
    }
    
    context.go('/admin-dashboard-v2');
    return;
  }

  void logOutUser() {
    state = AsyncValue.data(null);
  }

  FutureOr<int> supRegisterNewUser(SupaUserModel user) async {
    return await ref.read(riverpodDbProvider.notifier).supaRegisterNewUser(user);
  }
  
  // SUPABASE
  FutureOr<SupaUserModelRetrieve?> supaLoginUser(SupaLoginUser user) async {
    final response = await ref.read(riverpodDbProvider.notifier).supaLoginUser(user);

    if (response != null) {
      state = AsyncValue.data(response);
      return response;
    }
        
    return null;
  }
}
