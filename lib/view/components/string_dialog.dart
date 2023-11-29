import 'package:dibook/view/components/default_textfield.dart';
import 'package:flutter/material.dart';

class StringDialog {
  static Future<String?> show(
      {required BuildContext context, required String content}) async {
    final controller = TextEditingController();
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          children: [
            Text(content),
            DefaultTextField(controller: controller),
          ],
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(controller.text);
              },
              child: const Text("Ok")),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"))
        ],
      ),
    );
  }

  const StringDialog._();
}
