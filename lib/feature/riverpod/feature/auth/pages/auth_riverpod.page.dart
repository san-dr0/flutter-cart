import 'package:clean_arch2/core/color.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:clean_arch2/core/text.style.dart';
import 'package:clean_arch2/feature/riverpod/component/button/ink.dart';
import 'package:flutter/material.dart';

class AuthRiverPodPage extends StatefulWidget {
  const AuthRiverPodPage({super.key});

  @override
  State<AuthRiverPodPage> createState () => _AuthRiverPodPage();
}

class _AuthRiverPodPage extends State<AuthRiverPodPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _txtEmail;
  late TextEditingController _txtPassword;

  @override
  void initState() {
    super.initState();
    _txtEmail = TextEditingController();
    _txtPassword = TextEditingController();
  }

  void onLoginUser() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(loginTitle),
        backgroundColor: tealColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                loginTitle,
                style: textStyle(
                  color: Colors.black,
                  fontSize: 20
                ),
              ),
              TextFormField(
                controller: _txtEmail,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Empty email";
                  }
                  return null;
                },
                decoration: inputDecoration(label: "Email"),
              ),
              TextFormField(
                controller: _txtPassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Empty password";
                  }
                  return null;
                },
                decoration: inputDecoration(label: "Pass***"),
                obscureText: true,
              ),
              const SizedBox(height: 10.0,),
              SizedBox(
                width: 100.0,
                child: inkButton(tapped: (param) {
                  onLoginUser();
                }, subTitle: loginTitle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

InputDecoration inputDecoration({String label = ""}) {
  return InputDecoration(
    label: Text(label)
  );
}
