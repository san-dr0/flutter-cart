import 'package:clean_arch2/config/db/hive_model/product_model/product_model.dart';
import 'package:flutter/material.dart';

abstract class AuthEvent {}

class AuthOnLoginEvent extends AuthEvent {
  String email;
  String password;
  BuildContext context;

  AuthOnLoginEvent({required this.email, required this.password, required this.context});
}

class AuthOnLogoutEvent extends AuthEvent {
  BuildContext context;

  AuthOnLogoutEvent({required this.context});
}

class AuthOnNavigateToSignupEvent extends AuthEvent {
  BuildContext context;

  AuthOnNavigateToSignupEvent({required this.context});
}

class AuthOnSignupUserEvent extends AuthEvent {
  String firstName;
  String middleName;
  String lastName;
  String email;
  String password;
  String userType;

  BuildContext context;

  AuthOnSignupUserEvent({
    required this.firstName, 
    required this.middleName, 
    required this.lastName, 
    required this.email,
    required this.password,
    required this.userType,
    required this.context,
  });
}

class AuthOnAlreadyHaveAnAccountEvent extends AuthEvent {
  BuildContext context;

  AuthOnAlreadyHaveAnAccountEvent({required this.context});
}

class AuthOnCheckoutEvent extends AuthEvent {
  BuildContext context;
  List<ProductEntity> cartProductList = [];

  AuthOnCheckoutEvent({required this.context, required this.cartProductList});
}

class AuthCancelCartConfirmationDialog extends AuthEvent {
  BuildContext context;

  AuthCancelCartConfirmationDialog({required this.context});
}

class AuthProceedBuyCartItemConfirmationDialog extends AuthEvent {
}

class AuthOnUpdateCredentialEvent extends AuthEvent {
  String firstName;
  String middleName;
  String lastName;
  String email;
  String password;
  String userType;

  AuthOnUpdateCredentialEvent({
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.userType
  });
}
