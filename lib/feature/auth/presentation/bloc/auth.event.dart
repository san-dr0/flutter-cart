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
