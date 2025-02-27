import 'dart:async';
import 'dart:developer';

import 'package:clean_arch2/config/db/app_db.dart';
import 'package:clean_arch2/config/db/hive_model/product_model/product_model.dart';
import 'package:clean_arch2/config/db/request/request.dart';
import 'package:clean_arch2/core/text.style.dart';
import 'package:clean_arch2/feature/auth/domain/auth.domain.dart';
import 'package:clean_arch2/feature/auth/presentation/bloc/auth.state.dart';
import 'package:clean_arch2/feature/cart/presentation/bloc/cart.bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../cart/presentation/bloc/cart.event.dart';
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
    };

    int response = await appDatabase.addUser(userInfo);
    if (response == 1) {
      emit(AuthOnIssueInSigningUpState(message: "User was created successfully"));
      context.push("/login");
    } // SUCCESS
    else if (response == 0) {
      emit(AuthOnIssueInSigningUpState(message: "User already exists"));
    } // FAIL
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
    else {
      context.push("/login");
    }
  }

  FutureOr<void> authOnCheckoutEvent(AuthOnCheckoutEvent event, Emitter<AuthState> emit) {
    BuildContext context = event.context;
    List<ProductEntity> cartProductList = event.cartProductList;
    try{
      // BuildContext context = event.context;
      if (state is AuthOnValidCredentialsState) {
        final authState = (state as AuthOnValidCredentialsState).authCredentialsModel;
        if (authState != null) {
          showDialog(
            context: context, 
            builder: (context) {
              return AlertDialog(
                title: Text("Confirm"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Are you sure you want to buy this item ?")
                  ],
                ),
                actions: [
                  InkWell(
                    onTap: () {
                      add(AuthCancelCartConfirmationDialog(context: context));
                    },
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    splashColor: Colors.teal,
                    child: Ink(
                      decoration: BoxDecoration(
                        color: Colors.teal[800],
                        borderRadius: BorderRadius.all(Radius.circular(10.0))
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Cancel",
                          style: textStyle(),
                        ),
                      ),
                    )
                  ),
                  BlocListener(
                    bloc: this,
                    listener: (context, state) {
                      context.read<CartBloc>().add(CartOnResetProductListEvent(email: authState.email));
                    },
                    listenWhen: (previous, current) => current is AuthOnResetCartProductListState 
                      || current is AuthOnValidCredentialsState,
                    child: Text(""),
                  ),
                  InkWell(
                    onTap: () {
                      add(AuthProceedBuyCartItemConfirmationDialog(context: context, cartProductList: cartProductList));
                    },
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    splashColor: Colors.teal,
                    child: Ink(
                      decoration: BoxDecoration(
                        color: Colors.teal[800],
                        borderRadius: BorderRadius.all(Radius.circular(10.0))
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Yes of course",
                          style: textStyle(),
                        ),
                      ),
                    )
                  )
                ],
              );
            },
            barrierDismissible: false
          );
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
    BuildContext context = event.context;
    AuthCredentialsModel? authModel;
    
    if (state is AuthOnValidCredentialsState) {
      final authState = state as AuthOnValidCredentialsState;
      authModel = authState.authCredentialsModel;
    }
    emit(AuthOnResetCartProductListState());
    emit(AuthOnValidCredentialsState(authCredentialsModel: authModel));
    Navigator.pop(context);
  }
}
