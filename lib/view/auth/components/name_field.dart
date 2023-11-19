import 'package:dibook/view/auth/constants/strings.dart';
import 'package:dibook/view/components/default_textfield.dart';
import 'package:flutter/material.dart';

class NameField extends StatelessWidget {
  final TextEditingController controller;
  const NameField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return DefaultTextField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter the name";
        }
        return null;
      },
      controller: controller,
      placeHolder: Strings.name,
    );
  }
}
