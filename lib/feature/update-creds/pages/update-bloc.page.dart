import 'package:clean_arch2/core/color.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:clean_arch2/core/text.style.dart';
import 'package:clean_arch2/feature/auth/presentation/bloc/auth.bloc.dart';
import 'package:clean_arch2/feature/auth/presentation/bloc/auth.event.dart';
import 'package:clean_arch2/feature/auth/presentation/bloc/auth.state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateCredentialPage extends StatefulWidget {
  const UpdateCredentialPage({super.key});
  
  @override
  State<UpdateCredentialPage> createState () => _UpdateCredentialPage();
}

class _UpdateCredentialPage extends State<UpdateCredentialPage> {
  late TextEditingController txtFirstname;
  late TextEditingController txtMiddlename;
  late TextEditingController txtLastname;
  late TextEditingController txtEmail;
  late TextEditingController txtPassword;

  late AuthBloc authBloc;

  @override
  void initState() {
    super.initState();
    authBloc = context.read<AuthBloc>();

    txtFirstname = TextEditingController(
      text: (authBloc.state is AuthOnValidCredentialsState) ? (authBloc.state as AuthOnValidCredentialsState).authCredentialsModel!.firstName : ''
    );
    txtMiddlename = TextEditingController(
      text: (authBloc.state is AuthOnValidCredentialsState) ? (authBloc.state as AuthOnValidCredentialsState).authCredentialsModel!.middleName : ''
    );
    txtLastname = TextEditingController(
      text: (authBloc.state is AuthOnValidCredentialsState) ? (authBloc.state as AuthOnValidCredentialsState).authCredentialsModel!.lastName : ''
    );
    txtEmail = TextEditingController(
      text: (authBloc.state is AuthOnValidCredentialsState) ? (authBloc.state as AuthOnValidCredentialsState).authCredentialsModel!.email : ''
    );
    txtPassword = TextEditingController(
      text: (authBloc.state is AuthOnValidCredentialsState) ? (authBloc.state as AuthOnValidCredentialsState).authCredentialsModel!.password : ''
    );
  }

  void onSaveAndUpdateRecords() {
    String firstName = txtFirstname.text;
    String middleName = txtMiddlename.text;
    String lastName = txtLastname.text;
    String email = txtEmail.text;
    String password = txtPassword.text;

    authBloc.add(AuthOnUpdateCredentialEvent(
      firstName: firstName, middleName: middleName, lastName: lastName, email: email, password: password)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: tealColor,
        title: Text(updateCredTitle),
      ),
      body: Column(
        children: [
          Form(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: txtFirstname,
                    decoration: InputDecoration(
                      label: Text("Firstname")
                    ),
                  ),
                  TextFormField(
                    controller: txtMiddlename,
                    decoration: InputDecoration(
                      label: Text("Middlename")
                    ),
                  ),
                  TextFormField(
                    controller: txtLastname,
                    decoration: InputDecoration(
                      label: Text("Lastname")
                    ),
                  ),
                  TextFormField(
                    controller: txtEmail,
                    decoration: InputDecoration(
                      label: Text("Email")
                    ),
                  ),
                  TextFormField(
                    controller: txtPassword,
                    decoration: InputDecoration(
                      label: Text("Pass****")
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 10.0,),
                  InkWell(
                    onTap: () {
                      onSaveAndUpdateRecords();
                    },
                    borderRadius: BorderRadius.circular(10.0),
                    splashColor: Colors.teal,
                    child: Ink(
                      decoration: BoxDecoration(
                        color: Colors.teal[300],
                        borderRadius: BorderRadius.all(Radius.circular(10.0))
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Update and save records",
                          style: textStyle(),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          BlocListener(
            bloc: authBloc,
            listener: (context, state) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(updateCredentialsSuccessfullTitle))
              );
            },
            listenWhen: (previous, current) => current is AuthOnValidCredentialsState,
            child: const SizedBox(),
          )
        ],
      ),
    );
  }
}
