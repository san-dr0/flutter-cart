import 'package:clean_arch2/feature/home/domain/product.domain.dart';
import 'package:flutter/material.dart';

abstract class AuthEvent {}

class AuthOnLoginEvent extends AuthEvent {
  String email;
  String password;
  BuildContext context;

  AuthOnLoginEvent({required this.email, required this.password, required this.context});
}

class AuthOnLogoutEvent extends AuthEvent {}
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

  BuildContext context;

  AuthOnSignupUserEvent({
    required this.firstName, 
    required this.middleName, 
    required this.lastName, 
    required this.email,
    required this.password,
    required this.context
  });
}

class AuthOnAlreadyHaveAnAccountEvent extends AuthEvent {
  BuildContext context;

  AuthOnAlreadyHaveAnAccountEvent({required this.context});
}

class AuthOnCheckoutEvent extends AuthEvent {
  BuildContext context;
  List<ProductModel> cartProductList = [];

  AuthOnCheckoutEvent({required this.context, required this.cartProductList});
}

class AuthCancelCartConfirmationDialog extends AuthEvent {
  BuildContext context;

  AuthCancelCartConfirmationDialog({required this.context});
}

class AuthProceedBuyCartItemConfirmationDialog extends AuthEvent {
  List<ProductModel> cartProductList;

  AuthProceedBuyCartItemConfirmationDialog({required this.cartProductList});
}
