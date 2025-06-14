import 'package:flutter/material.dart';

Widget iconButton({Function()? buttonAction, IconData icon = Icons.person, Color color = Colors.amber, double iconSize = 20.0}) {
  return IconButton(onPressed: () {
    if (buttonAction == null) {
      return;
    }
    buttonAction();
  }, icon: Icon(icon), color: color, iconSize: iconSize,);
}
