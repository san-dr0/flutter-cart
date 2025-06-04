import 'package:flutter/material.dart';

List<Widget> headerMenu (Function() registrationFunc, Function() loginFunc, Function() subjectFunc) {
  return [
    IconButton(
      onPressed: () {
        registrationFunc();
      }, icon: Icon(Icons.app_registration)
    ),
    IconButton(
      onPressed: () {
        loginFunc();
      }, icon: Icon(Icons.login)
    ),
    IconButton(
      onPressed: () {
        subjectFunc();
      }, icon: Icon(Icons.subject)
    ),

  ];
}