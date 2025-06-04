import 'dart:developer';

import 'package:clean_arch2/core/color.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:clean_arch2/core/text.style.dart';
import 'package:clean_arch2/feature-school/school-home/school.menu.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SchoolHomePage extends StatefulWidget {
  const SchoolHomePage({super.key});

  @override
  State<SchoolHomePage> createState () => _SchoolHomePage();
}

class _SchoolHomePage extends State<SchoolHomePage> {
  void onRegistration() {
    context.push("/school-registration");
  }
  
  void onLogin() {

  }

  void onSubject() {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(homeSchoolTitle),
        backgroundColor: goldColor,
        actions: [...headerMenu(onRegistration, onLogin, onSubject)],
      ),
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome to school application",
              style: textStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
