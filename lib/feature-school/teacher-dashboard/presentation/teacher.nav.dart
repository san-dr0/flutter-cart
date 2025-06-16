import 'package:flutter/material.dart';

List<Widget> teacherNav (Function() studentAttendance, Function() studentScoring, Function() studentReports, Function() onGoToHome) {
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
    IconButton(onPressed: () {
      onGoToHome();
    }, icon: Icon(Icons.home))
  ];

  return navIcon;
}
