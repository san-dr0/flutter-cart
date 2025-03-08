import 'package:clean_arch2/core/color.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:clean_arch2/core/text.style.dart';
import 'package:clean_arch2/feature/topup/component/topup.component.dart';
import 'package:flutter/material.dart';

class TopUpPage extends StatefulWidget {
  const TopUpPage({super.key});

  @override
  State<TopUpPage> createState () => _TopUpPage();
}

class _TopUpPage extends  State<TopUpPage> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(topUpTitle),
          backgroundColor: tealColor,
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text(
                  "Interactive",
                  style: textStyle(),
                ),
              ),
              Tab(
                child: Text(
                  "Inputted",
                  style: textStyle(),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: TopUpComponent(),
            ),
            Center(
              child: Text("Oh1"),
            ),
          ],
        ),
      ),
    );
  }
}
