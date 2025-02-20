import 'dart:async';
import 'dart:developer';

import 'package:clean_arch2/config/db/app_db.dart';
import 'package:clean_arch2/config/db/request/request.dart';
import 'package:clean_arch2/feature/auth/presentation/bloc/auth.state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'auth.event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AppDatabase appDatabase;

  AuthBloc({required this.appDatabase}): super(AuthOnValidCredentials(authCredentialsModel: null)) {
    on<AuthOnLoginEvent>(authOnLoginEvent);
    on<AuthOnLogoutEvent>(authOnLogoutEvent);
    on<AuthOnNavigateToSignupEvent>(authOnNavigateToSignup);
  }

  FutureOr<void> authOnLoginEvent(AuthOnLoginEvent event, Emitter<AuthState> emit) async {
    String email = event.email;
    String password = event.password;
    BuildContext context = event.context;
    Request<dynamic>? req = await appDatabase.validateUserCredentials(email: email, password: password);
    
    if (req != null) {
      if (req.code == 200) {

      }
      else if (req.code == 401) {
        emit(AuthOnInvalidCredentials(errorMessage: req.message));
      }
    }
  }

  FutureOr<void> authOnLogoutEvent(AuthOnLogoutEvent event, Emitter<AuthState> emit) {

  }

  FutureOr<void> authOnNavigateToSignup(AuthOnNavigateToSignupEvent event, Emitter<AuthState> emit) {
    BuildContext context = event.context;

    context.push("/signup");
  }
}
