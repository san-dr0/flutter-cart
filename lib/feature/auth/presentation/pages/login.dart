import 'package:clean_arch2/core/color.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:clean_arch2/core/text.style.dart';
import 'package:clean_arch2/feature/auth/presentation/bloc/auth.bloc.dart';
import 'package:clean_arch2/feature/auth/presentation/bloc/auth.state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth.event.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  
  @override
  State<LoginPage> createState () => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  late TextEditingController textEmail;
  late TextEditingController textPassword;
  late AuthBloc authBloc;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    textEmail = TextEditingController();
    textPassword = TextEditingController();

    authBloc = context.read<AuthBloc>();
  }

  void onLoginUser() {
    String email = textEmail.text;
    String password = textPassword.text;

    if (!formKey.currentState!.validate()) {
      return;
    }

    authBloc.add(
      AuthOnLoginEvent(
        email: 'ada.ada@gmail.com',
        password: '123',
        context: context
      )
    );
  }

  void onNotRegisteredYet() {
    authBloc.add(AuthOnNavigateToSignupEvent(context: context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          loginTitle
        ),
        backgroundColor: tealColor,
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder(
                bloc: authBloc,
                builder: (context, state) {
                  if (state is AuthOnInvalidCredentialsState) {
                    return Text(
                      state.errorMessage,
                      style: textStyle(
                        color: Colors.red[800]!,
                        fontSize: 18.0
                      ),
                    );
                  }
                  return Text("");
                },
                buildWhen: (previous, current) => current is AuthOnInvalidCredentialsState,
              ), // FOR INVALID CREDENTIALS
              TextFormField(
                controller: textEmail,
                decoration: InputDecoration(
                  label: Text(emailTitle)
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Empty is required";
                  }

                  return null;
                },
              ),
              TextFormField(
                controller: textPassword,
                decoration: InputDecoration(
                  label: Text(passwordTitle)
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password is required";
                  }

                  return null;
                },
              ),
              const SizedBox(height: 10.0,),
              SizedBox(
                width: 100.0,
                child: InkWell(
                  onTap: () {
                    onLoginUser();
                  },
                  splashColor: Colors.teal,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: Ink(
                    decoration: BoxDecoration(
                      color: Colors.teal[800],
                      borderRadius: BorderRadius.all(Radius.circular(10.0))
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
              const SizedBox(
                height: 8.0
              ),
              InkWell(
                onTap: () {
                  onNotRegisteredYet();
                },
                splashColor: Colors.blueGrey,
                child: Ink(
                  child: Text(
                    notRegisteredYet,
                    style: textStyle(
                      color: Colors.black, 
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
