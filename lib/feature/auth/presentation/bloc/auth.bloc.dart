import 'dart:async';
import 'dart:developer';

import 'package:clean_arch2/config/db/app_db.dart';
import 'package:clean_arch2/config/db/hive_model/product_model/product_model.dart';
import 'package:clean_arch2/config/db/request/request.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:clean_arch2/feature/auth/domain/auth.domain.dart';
import 'package:clean_arch2/feature/auth/presentation/bloc/auth.state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'auth.event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AppDatabase appDatabase;

  AuthBloc({required this.appDatabase}): super(AuthOnValidCredentialsState(authCredentialsModel: null)) {
    on<AuthOnLoginEvent>(authOnLoginEvent);
    on<AuthOnLogoutEvent>(authOnLogoutEvent);
    on<AuthOnNavigateToSignupEvent>(authOnNavigateToSignup);
    on<AuthOnSignupUserEvent>(authOnSignupUserEvent);
    on<AuthOnAlreadyHaveAnAccountEvent>(authOnAlreadyHaveAnAccountEvent);
    on<AuthOnCheckoutEvent>(authOnCheckoutEvent);
    on<AuthCancelCartConfirmationDialog>(authCancelCartConfirmationDialog);
    on<AuthProceedBuyCartItemConfirmationDialog>(authProceedBuyCartItemConfirmationDialog);
    on<AuthOnUpdateCredentialEvent>(authOnUpdateCredentialEvent);
  }

  FutureOr<void> authOnLoginEvent(AuthOnLoginEvent event, Emitter<AuthState> emit) async {
    String email = event.email;
    String password = event.password;
    BuildContext context = event.context;
    emit(AuthOnLoadingState());
    Request<AuthCredentialsModel>? req = await appDatabase.validateUserCredentials(email: email, password: password);
    
    if (req != null) {
      if (req.code == 200) {
        emit(AuthOnInvalidCredentialsState(errorMessage: ''));
        
        AuthCredentialsModel authCredentialsModel = AuthCredentialsModel.fromJson(req.data!);
        emit(AuthOnValidCredentialsState(authCredentialsModel: authCredentialsModel));
        
        context.push("/dashboard");
      }
      else if (req.code == 401) {
        emit(AuthOnInvalidCredentialsState(errorMessage: req.message));
      }
    }
  }

  FutureOr<void> authOnLogoutEvent(AuthOnLogoutEvent event, Emitter<AuthState> emit) {
    BuildContext context = event.context;

    emit(AuthOnValidCredentialsState(authCredentialsModel: null));
    context.push("/");
  }

  FutureOr<void> authOnNavigateToSignup(AuthOnNavigateToSignupEvent event, Emitter<AuthState> emit) {
    BuildContext context = event.context;
    context.push("/signup");
  }

  FutureOr<void> authOnSignupUserEvent(AuthOnSignupUserEvent event, Emitter<AuthState> emit) async {
    String firstName = event.firstName;
    String middleName = event.middleName;
    String lastName = event.lastName;
    String email = event.email;
    String password = event.password;
    BuildContext context = event.context;

    Map<String, dynamic> userInfo = {
      "firstName": firstName,
      "middleName": middleName,
      "lastName": lastName,
      "email": email,
      "password": password,
      "userType": event.userType
    };

    int response = await appDatabase.addUser(userInfo);
    if (event.userType.isEmpty) {
      emit(AuthOnIssueInSigningUpState(message: 'Please select signup as.'));
    }
    else if (response == 1) {
      emit(AuthOnIssueInSigningUpState(message: userCreatedSuccessfullyTitle));
      context.push("/login");
    } // SUCCESS
    else if (response == 0) {
      emit(AuthOnIssueInSigningUpState(message: userAlreadyExistsTitle));
    } // FAIL; user already exists
    else {
      emit(AuthOnIssueInSigningUpState(message: somethingWentWrongTitle));
    } // FAIL Something went wrong
  }

  FutureOr<void> authOnAlreadyHaveAnAccountEvent(AuthOnAlreadyHaveAnAccountEvent event, Emitter<AuthState> emit) {
    BuildContext context = event.context;
    
    if (state is AuthOnValidCredentialsState) {
      final authCreds = state as AuthOnValidCredentialsState;

      if (authCreds.authCredentialsModel != null) {
        context.push('/dashboard');
      }
      else {
        context.push("/login");
      }
    }
    else if (state is AuthCheckCurrentActiveUserCurrentBalanceState) {
      final authCreds = state as AuthCheckCurrentActiveUserCurrentBalanceState;

      if (authCreds.authCredentialsModel != null) {
        emit(AuthOnValidCredentialsState(authCredentialsModel: authCreds.authCredentialsModel));
        context.push('/dashboard');
      }
      else {
        context.push("/login");
      }
    }
    else {
      context.push("/login");
    }
  }

  FutureOr<void> authOnCheckoutEvent(AuthOnCheckoutEvent event, Emitter<AuthState> emit) {
    List<ProductEntity> cartProductList = event.cartProductList;
    try{
      if (state is AuthOnValidCredentialsState) {
        final authState = (state as AuthOnValidCredentialsState).authCredentialsModel;
        if (authState != null) {
          emit(AuthCheckCurrentActiveUserCurrentBalanceState(authCredentialsModel: authState));
          emit(AuthOnValidCredentialsState(authCredentialsModel: authState));
        }
        else {
          emit(AuthOnLoadingState());
          emit(AuthNotLoggedInState());
        }
      }
      else {
        emit(AuthOnLoadingState());
        emit(AuthNotLoggedInState());
      }
    }
    catch(error) {
      log('errrr >>> ');
      log(error.toString());
    }
  }

  FutureOr<void> authCancelCartConfirmationDialog(AuthCancelCartConfirmationDialog event, Emitter<AuthState> emit) {
    BuildContext context = event.context;
    Navigator.pop(context);
  }

  FutureOr<void> authProceedBuyCartItemConfirmationDialog(AuthProceedBuyCartItemConfirmationDialog event, Emitter<AuthState> emit) async {
    AuthCredentialsModel? authModel;
    if (state is AuthOnValidCredentialsState) {
      final authState = state as AuthOnValidCredentialsState;
      authModel = authState.authCredentialsModel;
    }
    emit(AuthOnResetCartProductListState());
    emit(AuthCheckCurrentActiveUserCurrentBalanceState(authCredentialsModel: authModel));
  }

  FutureOr<void> authOnUpdateCredentialEvent(AuthOnUpdateCredentialEvent event, Emitter<AuthState> emit) {
    String firstName = event.firstName;
    String middleName = event.middleName;
    String lastName = event.lastName;
    String email = event.email;
    String password = event.password;

    AuthCredentialsModel authCredentialsModel = AuthCredentialsModel
      (
        firstName: firstName, middleName: middleName, lastName: lastName, email: email, password: password,
        userType: event.userType
      );

    appDatabase.updateCredential(
      firstName: firstName, 
      middleName: middleName, 
      lastName: lastName,
      email: email, password: password
    );

    emit(AuthOnLoadingState());
    emit(AuthOnValidCredentialsState(authCredentialsModel: authCredentialsModel));
  }
}
