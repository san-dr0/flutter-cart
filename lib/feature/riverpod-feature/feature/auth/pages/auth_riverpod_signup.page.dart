import 'package:clean_arch2/core/color.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:clean_arch2/core/text.style.dart';
import 'package:clean_arch2/feature/riverpod-feature/component/button/ink.dart';
import 'package:clean_arch2/feature/riverpod-feature/feature/auth/model/signup/signup.model.dart';
import 'package:clean_arch2/feature/riverpod-feature/feature/riverpod/pod-entry/pod_entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class AuthRiverPodSignupPage extends ConsumerStatefulWidget {
  const AuthRiverPodSignupPage({super.key});

  @override
  ConsumerState<AuthRiverPodSignupPage> createState () => _AuthRiverPodSignupPage();
}

class _AuthRiverPodSignupPage extends ConsumerState<AuthRiverPodSignupPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _txtFirstname;
  late TextEditingController _txtLastname;
  late TextEditingController _txtEmail;
  late TextEditingController _txtPassword;

  @override
  void initState() {
    super.initState();
    _txtEmail = TextEditingController();
    _txtPassword = TextEditingController();
    _txtFirstname = TextEditingController();
    _txtLastname = TextEditingController();
  }

  void onSignupUser() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    // AuthSignupRiverpodModel signupRiverpodModel = AuthSignupRiverpodModel(
    //   id: Uuid().v1(),
    //   firstname: _txtFirstname.text, 
    //   lastname: _txtLastname.text, 
    //   email: _txtEmail.text, 
    //   password: _txtPassword.text
    // );
    SupaUserModel supaUserModel = SupaUserModel(
      firstname: _txtFirstname.text, 
      lastname: _txtLastname.text, 
      email: _txtEmail.text, 
      password: _txtPassword.text
    );
    
    if (ref.read(userTypePod.notifier).getUserType() == 'user') {
      final response = await ref.read(authProvider.notifier).supRegisterNewUser(supaUserModel);
    
      switch(response) {
        case 0:
          Fluttertoast.showToast(msg: userAlreadyExistsTitle, toastLength: Toast.LENGTH_SHORT);
          break;
        case 1:
          Fluttertoast.showToast(msg: userCreatedSuccessfullyTitle, toastLength: Toast.LENGTH_SHORT);
          context.push("/riverpod-auth-login");
          break;
        default:
          Fluttertoast.showToast(msg: somethingWentWrongTitle, toastLength: Toast.LENGTH_SHORT);
          break;
      }
    }
    else if (ref.read(userTypePod.notifier).getUserType() == 'admin') {
      final adminResponse = await ref.read(adminAuthPod.notifier).singupAdmin(supaUserModel);
      if (adminResponse != 0) {
        context.go("/admin-dashboard-v2");
      }
      else {
        Fluttertoast.showToast(msg: somethingWentWrongTitle, toastLength: Toast.LENGTH_SHORT);
      }
    }

    clearFields();
  }

  void clearFields() {
    _txtFirstname.clear();
    _txtLastname.clear();
    _txtEmail.clear();
    _txtPassword.clear();
  }

  void onAlreadyHaveAnAccount() {
    context.push("/riverpod-auth-login");
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
                "$signupAsTitle ${ref.read(userTypePod).value}",
                style: textStyle(
                  color: Colors.black,
                  fontSize: 20
                ),
              ),
              TextFormField(
                controller: _txtFirstname,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Empty firstname";
                  }
                  return null;
                },
                decoration: inputDecoration(label: "Firstname"),
              ),
              TextFormField(
                controller: _txtLastname,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Empty lastname";
                  }
                  return null;
                },
                decoration: inputDecoration(label: "Lastname"),
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
                keyboardType: TextInputType.emailAddress,
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
                  onSignupUser();
                }, subTitle: signupTitle),
              ),
              TextButton(onPressed: () {
                onAlreadyHaveAnAccount();
              }, child: Text(alreadyHaveAnAccount))
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
