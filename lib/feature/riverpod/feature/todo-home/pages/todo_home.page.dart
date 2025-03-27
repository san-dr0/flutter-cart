import 'package:clean_arch2/core/color.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TodoHomePage extends StatefulWidget {
  const TodoHomePage({super.key});
  @override
  State<TodoHomePage> createState () => _TodoHomePage();
}

class _TodoHomePage extends State<TodoHomePage> {

  @override
  void initState() {
    super.initState(); 
  }

  void loginAdminDashBoard () {
    context.go("/admin-dashboard-v2");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: tealColor,
        title: Text(cartTitle),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.person, color: whiteColor,)),
          IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart, color: whiteColor)),
          IconButton(onPressed: () {
            loginAdminDashBoard();
          }, icon: Icon(Icons.admin_panel_settings_outlined, color: whiteColor)),
        ],
      ),
    );
  }
}
