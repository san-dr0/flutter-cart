import 'package:clean_arch2/core/color.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:clean_arch2/core/text.style.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState () => _SignupPage();
}

class _SignupPage extends State<SignupPage> {
  TextEditingController txtFirstname = TextEditingController();
  TextEditingController txtMiddlename = TextEditingController();
  TextEditingController txtLastname = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  
  final formKey = GlobalKey<FormState>();

  void onLoginUser() {

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(signupTitle),
        backgroundColor: tealColor,
      ),
      body: Form(
        key: formKey,
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextFormField(
                controller: txtFirstname,
                decoration: _textDecoration(
                  label: "Firstname"
                ),
              ),
              TextFormField(
                controller: txtMiddlename,
                decoration: _textDecoration(
                  label: "Middlename"
                ),
              ),
              TextFormField(
                controller: txtLastname,
                decoration: _textDecoration(
                  label: "Lastname"
                ),
              ),
              TextFormField(
                controller: txtEmail,
                decoration: _textDecoration(
                  label: "Email"
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              TextFormField(
                controller: txtPassword,
                decoration: _textDecoration(
                  label: "Pass***"
                ),
                obscureText: true,
              ),
              const SizedBox(height: 12.0,),
              SizedBox(
                width: 100.0,
                child: InkWell(
                  onTap: () {
                    onLoginUser();
                  },
                  splashColor: Colors.teal[800],
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: Ink(
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        loginTitle,
                        textAlign: TextAlign.center,
                        style: textStyle(
                          color: Colors.white,
                          fontSize: 18.0
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

InputDecoration _textDecoration({String label = "Empty label"}) {
  return InputDecoration(
    label: Text(label)
  );
}