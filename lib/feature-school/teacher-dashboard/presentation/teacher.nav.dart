import 'package:flutter/material.dart';

List<Widget> teacherNav (Function() studentAttendance, Function() studentScoring, Function() studentReports) {
  List<IconButton> navIcon = [
    IconButton(onPressed: () {
      studentAttendance();
    }, icon: Icon(Icons.note_alt)),
    IconButton(onPressed: () {
      studentScoring();
    }, icon: Icon(Icons.score_rounded)),
    IconButton(onPressed: () {
      studentReports();
    }, icon: Icon(Icons.receipt_long_sharp)),
  ];

  return navIcon;
}
