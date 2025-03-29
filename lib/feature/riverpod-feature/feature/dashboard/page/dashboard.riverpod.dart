import 'package:clean_arch2/core/color.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:flutter/material.dart';

class DashBoardRiverpodPage extends StatefulWidget {
  const DashBoardRiverpodPage({super.key});

  @override
  State<DashBoardRiverpodPage> createState () => _DashBoardRiverpodPage();
}

class _DashBoardRiverpodPage extends State<DashBoardRiverpodPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: tealColor,
        title: Text(dashBoardTitle),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Text("User:"),
            ),
            ListTile(
              title: Text("Balance"),
            ),
            ListTile(
              title: Text("Topup"),
            ),
            ListTile(
              title: Text("Biometrics"),
            ),
            ListTile(
              title: Text("Transactions"),
            ),
          ],
        ),
      ),
    );
  }
}
