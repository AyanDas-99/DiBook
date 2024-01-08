import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String msg) {
  if (ScaffoldMessenger.maybeOf(context) != null) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
