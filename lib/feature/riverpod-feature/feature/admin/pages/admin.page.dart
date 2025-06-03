import 'package:clean_arch2/core/color.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:clean_arch2/core/text.style.dart';
import 'package:clean_arch2/feature/riverpod-feature/feature/riverpod/pod-entry/pod_entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AdminPageV2 extends ConsumerStatefulWidget {
  const AdminPageV2({super.key});

  @override
  ConsumerState<AdminPageV2> createState () => _AdminPageV2();
}

class _AdminPageV2 extends ConsumerState<AdminPageV2> {

  void addPageEntry() {
    context.push("/admin-page-entry-v2");
  }

  void onGoToPage() {
    context.push('/admin-page-list-v2');
  }

  void onGoHome() {
    ref.read(adminAuthPod.notifier).logoutAdmin();
    context.push('/');
  }

  void onGoToListUser() {
    context.push('/user-list-page');
  }

  void onGoToHome() {
    context.push('/');
  }

  @override
  Widget build(BuildContext context) {
    final adminInfo = ref.read(adminAuthPod);

    return Scaffold(
      appBar: AppBar(
        title: Text(adminV2Title),
        backgroundColor: tealColor,
        actions: [
          IconButton(onPressed: () {
            onGoToHome();
          }, icon: Icon(Icons.home, color: whiteColor,)),
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
            DrawerHeader(
              decoration: BoxDecoration(color: tealColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Name: ${adminInfo.hasValue ? "${adminInfo.value?.lastName}, ${adminInfo.value?.firstName}" : 'No user'}"),
                  Text("Email: ${adminInfo.hasValue ? adminInfo.value?.email : 'No user'}"),
                ],
              ),
            ),
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
