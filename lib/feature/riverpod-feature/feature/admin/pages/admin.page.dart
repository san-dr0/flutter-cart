import 'package:clean_arch2/core/color.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:clean_arch2/core/text.style.dart';
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

  void onGoHome() {
    context.push('/');
  }

  void onGoToListUser() {
    context.push('/user-list-page');
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
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(child: Text("Drawer")),
            ListTile(
              onTap: () {
                onGoToListUser();
              },
              title: Text("List all users"),
            ),
            ListTile(
              onTap: () {
              },
              title: Text("Subscribed users"),
            ),
            ListTile(
              onTap: () {
              },
              title: Text("Unsubscribed users"),
            ),
            ListTile(
              onTap: () {
                onGoHome();
              },
              title: Text("Logout"),
            )
          ]
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            width: MediaQuery.sizeOf(context).width,
            child: Column(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(supBaseTitle, style: textStyle(fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),),
                        Text(supaBaseTitleDescription)
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(riverPodTitle, style: textStyle(fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),),
                        Text(riverPodTitleDescription)
                      ],
                    ),
                  ),
                ),
              ],
            )
          )
        ],
      ),
    );
  }
}
