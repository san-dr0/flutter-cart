import 'package:clean_arch2/core/color.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AdminPageV2 extends StatefulWidget {
  const AdminPageV2({super.key});

  @override
  State<AdminPageV2> createState () => _AdminPageV2();
}

class _AdminPageV2 extends State<AdminPageV2> {

  void addPageEntry() {
    context.push("/admin-page-entry-v2");
  }

  void onGoToPage() {
    context.push('/admin-page-list-v2');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(adminV2Title),
        backgroundColor: tealColor,
        actions: [
          IconButton(onPressed: () {
            onGoToPage();
          }, icon: Icon(Icons.view_list_outlined, color: whiteColor,)),
          IconButton(onPressed: () {
            addPageEntry();
          }, icon: Icon(Icons.add_box_rounded, color: whiteColor,)),
        ],
      ),
      body: Drawer(
        child: DrawerHeader(child: Text("Drawer")),
      ),
    );
  }
}
