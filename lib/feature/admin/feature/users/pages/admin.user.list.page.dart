import 'package:clean_arch2/core/color.dart';
import 'package:flutter/material.dart';

class AdminUserListPage extends StatefulWidget {
  const AdminUserListPage({super.key});
  
  @override
  State<AdminUserListPage> createState () => _AdminUserListPage();
}

class _AdminUserListPage extends State<AdminUserListPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: tealColor,
      ),
    );
  }
}
