import 'package:clean_arch2/core/text.style.dart';
import 'package:flutter/material.dart';

InkWell inkButton({String subTitle = "", Color splashColor = Colors.teal, Color bgColor = Colors.teal, 
  required void Function(Object? param) tapped, Object? param}) {
  return InkWell(
    onTap: () {
      tapped(param);
    },
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    splashColor: splashColor,
    child: Ink(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.all(Radius.circular(10.0))
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          subTitle,
          style: textStyle(
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}