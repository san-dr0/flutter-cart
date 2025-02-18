import 'package:clean_arch2/core/string.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState () => _SignupPage();
}

class _SignupPage extends State<SignupPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(signupTitle),
      ),
    );
  }
}
