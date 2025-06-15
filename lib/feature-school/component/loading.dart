import 'package:clean_arch2/core/string.dart';
import 'package:flutter/material.dart';

Widget loadingSpinner() {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const SizedBox(height: 10.0,),
      CircularProgressIndicator(),
      Text(pleaseWaitTitle)
    ],
  );
}
