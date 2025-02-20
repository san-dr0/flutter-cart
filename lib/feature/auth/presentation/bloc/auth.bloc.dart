import 'dart:async';

import 'package:clean_arch2/feature/auth/presentation/bloc/auth.state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth.event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(): super(AuthOnValidCredentials(authCredentialsModel: null)) {
    on<AuthOnLoginEvent>(authOnLoginEvent);
    on<AuthOnLogoutEvent>(authOnLogoutEvent);
  }

  FutureOr<void> authOnLoginEvent(AuthOnLoginEvent event, Emitter<AuthState> emit) {

  }

  FutureOr<void> authOnLogoutEvent(AuthOnLogoutEvent event, Emitter<AuthState> emit) {

  }
}
