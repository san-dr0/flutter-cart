import 'package:flutter/material.dart';

abstract class AuthEvent {}

class AuthOnLoginEvent extends AuthEvent {
  String email;
  String password;
  BuildContext contet;

  AuthOnLoginEvent({required this.email, required this.password, required this.contet});
}

class AuthOnLogoutEvent extends AuthEvent {}
