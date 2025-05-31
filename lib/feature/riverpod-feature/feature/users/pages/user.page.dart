import 'package:clean_arch2/core/color.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:clean_arch2/feature/riverpod-feature/feature/riverpod/pod-entry/pod_entry.dart';
import 'package:clean_arch2/feature/riverpod-feature/feature/users/model/user.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserListPage extends ConsumerStatefulWidget {
  const UserListPage({super.key});

  @override
  ConsumerState<UserListPage> createState () => _UserListPage();
}

class _UserListPage extends ConsumerState<UserListPage> {
  List<UserListModel> userList = [];

  @override
  void initState() {
    super.initState();
    getUserList();
  }

  void getUserList () async {
    userList = await ref.read(adminAuthPod.notifier).listAllUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(registeredUserTitle),
        backgroundColor: tealColor,
      ),
      body: Column(
        children: [
          Text(userList.length.toString())
          // ListView.separated(
          //   physics: const NeverScrollableScrollPhysics(),
          //   itemBuilder: (context, index) {
          //     return Text(userList[index].email);
          //   }, 
          //   separatorBuilder: (context, index) {
          //     return SizedBox(height: 10.0,);
          //   },
          //   itemCount: userList.length
          // )
        ],
      )
    );
  }
}
