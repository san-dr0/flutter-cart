import 'package:clean_arch2/core/string.dart';
import 'package:clean_arch2/core/text.style.dart';
import 'package:clean_arch2/feature/riverpod-feature/component/button/ink.dart';
import 'package:flutter/material.dart';

void alertDialog({required BuildContext context, required String title, required Function() okayFunc, required Function() closeFunc}) {
  showDialog(context: context, builder: (context) {
    return AlertDialog(
      content: Text(
        title,
        style: textStyle(
          color: Colors.black
        ),
      ),
      actions: [
        inkButton(tapped: (param) {
          okayFunc();
        }, subTitle: okayTitle),
        inkButton(tapped: (param) {
          closeFunc();
        }, subTitle: closeTitle),
      ],
    );
  },);
}
