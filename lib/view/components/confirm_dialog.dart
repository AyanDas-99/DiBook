import 'package:flutter/material.dart';

class ConfirmDialog {
  static Future<bool?> show(
      {required BuildContext context, required String content}) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(content),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text("Yes")),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text("No"))
        ],
      ),
    );
  }

  const ConfirmDialog._();
}
