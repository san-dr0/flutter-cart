import 'package:clean_arch2/core/color.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:flutter/material.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState () => _UserListPage();
}

class _UserListPage extends State<UserListPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(registeredUserTitle),
        backgroundColor: tealColor,
      ),
    );
  }
}
