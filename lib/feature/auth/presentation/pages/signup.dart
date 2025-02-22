import 'dart:developer';

import 'package:clean_arch2/core/color.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:clean_arch2/core/text.style.dart';
import 'package:clean_arch2/feature/auth/presentation/bloc/auth.bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth.event.dart';
import '../bloc/auth.state.dart';

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
  late AuthBloc authBloc;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authBloc = context.read<AuthBloc>();
  }
  void onLoginUser() {
    if (!formKey.currentState!.validate()) {
      return;
    }
    
    String firstName = txtFirstname.text;
    String middleName = txtMiddlename.text;
    String lastName = txtLastname.text;
    String email = txtEmail.text;
    String password = txtPassword.text;

    authBloc.add(AuthOnSignupUserEvent(
      firstName: firstName,
      middleName: middleName,
      lastName: lastName,
      email: email,
      password: password,
      context: context,
    ));
  }
  
  void onAlreadyHaveAnAccount() {
    authBloc.add(AuthOnAlreadyHaveAnAccountEvent(context: context));
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Firstname is required";
                  }

                  return null;
                },
              ),
              TextFormField(
                controller: txtMiddlename,
                decoration: _textDecoration(
                  label: "Middlename"
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Middlename is required";
                  }

                  return null;
                },
              ),
              TextFormField(
                controller: txtLastname,
                decoration: _textDecoration(
                  label: "Lastname"
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Lastname is required";
                  }

                  return null;
                },
              ),
              TextFormField(
                controller: txtEmail,
                decoration: _textDecoration(
                  label: "Email"
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email is required";
                  }

                  return null;
                },
              ),
              TextFormField(
                controller: txtPassword,
                decoration: _textDecoration(
                  label: "Pass***"
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password is required";
                  }

                  return null;
                },
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
              ),
              BlocListener(
                bloc: context.read<AuthBloc>(),
                listener: (context, state) {
                  if (state is AuthOnIssueInSigningUpState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                      )
                    );
                  }
                },
                child: const SizedBox(
                  height: 5.0,
                ),
              ),
              
              InkWell(
                onTap: () {
                  onAlreadyHaveAnAccount();
                },
                borderRadius: BorderRadius.circular(10.0),
                splashColor: Colors.blueGrey,
                child: Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))
                  ),
                  child: Text(
                    alreadyHaveAnAccount,
                    style: textStyle(
                      color: Colors.black,
                      fontSize: 15.0
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