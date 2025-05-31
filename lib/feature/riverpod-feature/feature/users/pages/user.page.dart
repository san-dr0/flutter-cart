import 'package:clean_arch2/core/color.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:clean_arch2/core/text.style.dart';
import 'package:clean_arch2/feature/riverpod-feature/component/button/ink.dart';
import 'package:clean_arch2/feature/riverpod-feature/feature/riverpod/pod-entry/pod_entry.dart';
import 'package:clean_arch2/feature/riverpod-feature/feature/users/model/user.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

class UserListPage extends ConsumerStatefulWidget {
  const UserListPage({super.key});

  @override
  ConsumerState<UserListPage> createState () => _UserListPage();
}

class _UserListPage extends ConsumerState<UserListPage> {
  List<UserListModel> userList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getUserList();
  }

  void getUserList () async {
    final userResp = await ref.read(adminAuthPod.notifier).listAllUser();
    setState(() {
      userList = userResp;
      isLoading = false;
    });
  }

  void onRemovedUser() {

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
          Text(
            "List of $registeredUserTitle",
            style: textStyle(
              fontSize: 20.0,
              color: Colors.black, 
              fontWeight: FontWeight.bold
            ),
          ),
          Expanded(
            child: Skeletonizer(
              enabled: isLoading,
              child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Firstname:", style: textStyle(color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),),
                                Text(userList[index].firstname),
                                Text("Lastname:", style: textStyle(color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),),
                                Text(userList[index].lastname),
                                Text("Email:", style: textStyle(color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),),
                                Text(userList[index].email),
                              ],
                            ),
                            Text("isSubscribed")
                          ],
                        ),
                        const SizedBox(height: 10.0,),
                        Row(
                          children: [
                            inkButton(
                              subTitle: "Remove", 
                              tapped: (param) {
                               onRemovedUser();
                             },
                             bgColor: Colors.red,
                             splashColor: Colors.red[800]!
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            }, 
            separatorBuilder: (context, index) {
              return SizedBox(height: 10.0,);
            },
            itemCount: userList.length
          ),
            )
          )
        ],
      )
    );
  }
}
